package com.servlet.step4;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import java.io.InputStream;
import java.util.Properties;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.JDBCUtil;
import common.ShopInfo;

@WebServlet("/weather.do")
public class WeatherController extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private static Properties props = new Properties();

    static {
        try (InputStream in = WeatherController.class.getClassLoader().getResourceAsStream("config.properties")) {
            if (in != null) {
                props.load(in);
            } else {
                System.err.println("config.properties not found in classpath for WeatherController!");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private void fetchDataFromApi(HttpServletRequest request) throws IOException {
    	 //오늘의 예보를 가져오기 위해 Date 패키지를 이용해 오늘 날짜 저장
    	Date todayInfo = new Date();
       // 날짜에서 연도월일을 20231212의 형태로 추출하기 위해 SimpleDateFormat 패키지 사용
        SimpleDateFormat dateForm = new SimpleDateFormat("yyyyMMddHH");
        // 0~~7의 문자열까지만 자르고 today에 저장
        String today = dateForm.format(todayInfo).substring(0, 8);

        // 웹페이지를 연 시간과 가장 가까운 기상 예보를 얻기 위해 넣음. 뒤에 +"00"을 넣은 이유는 아래 넣는 데이터 형식이 "0000"이기 때문 또한 예보 업데이트에 시간이 좀 걸리는 것 같기 때문에 -1을 해줌. 그리고 이거 새벽(0~~6)시에는 적용이 안되는 것 같다...
        String now = Integer.toString(Integer.parseInt(dateForm.format(todayInfo).substring(8, 10)) - 1) + "00";
        System.out.println(now);
        
        
        if (Integer.parseInt(dateForm.format(todayInfo).substring(8, 10)) < 6) {
            now="2300";
        }
        
        // 10시 이전에서 출력이 0900 이 아닌 900으로 되는 것을 확인하였음. 그래서 0900의 출력의 형태로 고치기 위해 if문 추가
        if(Integer.parseInt(dateForm.format(todayInfo).substring(8, 10)) <= 10&&Integer.parseInt(dateForm.format(todayInfo).substring(8, 10)) >= 6){
        	now= "0" +Integer.toString(Integer.parseInt(dateForm.format(todayInfo).substring(8, 10)) - 1) + "00";
        }
        // 0~6시 까지는 기상예보가 갱신되지 않는다고 함. 그래서 그 시간 전까지는 하루 전의 최신 예보를 출력하도록 설정
        if (Integer.parseInt(dateForm.format(todayInfo).substring(8, 10)) < 6) {
            today = Integer.toString(Integer.parseInt(dateForm.format(todayInfo).substring(0, 8)) - 1);
            now="2300";
        }

        String apiUrl = "http://apis.data.go.kr/1360000/VilageFcstInfoService_2.0/getUltraSrtNcst";
        String serviceKey = props.getProperty("weather.serviceKey");
        if (serviceKey == null) {
            serviceKey = "";
        }

        String parameters = "serviceKey=" + URLEncoder.encode(serviceKey, "UTF-8")
                + "&pageNo=" + URLEncoder.encode("1", "UTF-8")
                + "&numOfRows=" + URLEncoder.encode("1000", "UTF-8")
                //데이터 처리가 쉽도록 xml말고 JSON 형태로 데이터를 가져옴.
                + "&dataType=" + URLEncoder.encode("JSON", "UTF-8") 
                + "&base_date=" + URLEncoder.encode(today, "UTF-8")
                + "&base_time=" + URLEncoder.encode(now, "UTF-8")
                // 개봉 1,2,3 동의 x값과 y값. 공공 데이터 포털에서 제공한 엑셀 파일에서 추출해옴, 해당 지역의 예보만을 얻기 위함
                + "&nx=" + URLEncoder.encode("58", "UTF-8")
                + "&ny=" + URLEncoder.encode("125", "UTF-8");

        URL url = new URL(apiUrl + "?" + parameters);
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("GET");
        conn.setRequestProperty("Content-type", "application/json");
        System.out.println("Response code: " + conn.getResponseCode());

        
        StringBuilder apiResponse = new StringBuilder();
        
        try (BufferedReader rd = new BufferedReader(new InputStreamReader(conn.getInputStream()))) {
            String line;
            while ((line = rd.readLine()) != null) {
                apiResponse.append(line);
            }
        } catch (IOException e) {
            e.printStackTrace();
            throw e;
        } finally {
            conn.disconnect();
        }

        // 직접 weatherDataList에 apiResponse를 string의 형태로 바꾸어 저장
        request.setAttribute("weatherDataList", extractWeatherData(apiResponse.toString()));
    }

    // 리스트에 특정 데이터를 선별하여 저장
    private List<String[]> extractWeatherData(String apiResponse) {
        List<String[]> weatherDataList = new ArrayList<>();
        // 여기서는 PTY,REH,T1H 의 값만을 골라서 선별하였음
        Pattern pattern = Pattern.compile("\"category\":\"(PTY|REH|T1H)\".*?\"obsrValue\":\"(.*?)\"");
        Matcher matcher = pattern.matcher(apiResponse);

        while (matcher.find()) {
            String category = matcher.group(1);
            String value = matcher.group(2);
            weatherDataList.add(new String[]{category, value});
        }
        // 무슨값이 저장되었는지 시험하기 위해 웹페이지에 프린트함
        System.out.println("weatherDateList에 저장된 값: " + weatherDataList.toString());

        return weatherDataList;
    }
    
    private List<ShopInfo> extractRestaurantListFromDB(int weather) {
        List<ShopInfo> restaurantList = new ArrayList<>();

        // MySQL 데이터베이스 연결 및 쿼리 실행
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            conn = JDBCUtil.getConnection();

            // 날씨가 특정 값인 경우의 맛집을 가져오는 쿼리
            String query = "SELECT * FROM for_eat WHERE weather = ?";
            stmt = conn.prepareStatement(query);
            stmt.setInt(1, weather);
            rs = stmt.executeQuery();

            while (rs.next()) {
                int shopNo = rs.getInt("no");
                String shopName = rs.getString("name");
                String shopContents = rs.getString("contents");
                String shopImage = rs.getString("image");
                String shopKind = rs.getString("kind");
                String shopOpen = rs.getString("open");
                String shopClose = rs.getString("close");
                String shopBreak = rs.getString("break_time");
                String shopOff = rs.getString("day_off");
                int shopDis = rs.getInt("distance");
                String shopWeather = rs.getString("weather");
                String shopNaver = rs.getString("naver");
                String shopGoogle = rs.getString("google");
                String shopKakao = rs.getString("kakao");
                int shopView = rs.getInt("view");

                ShopInfo shopInfo = new ShopInfo(shopNo, shopName, shopContents, shopImage, shopKind, shopOpen, shopClose, shopBreak, shopOff, shopDis, shopWeather, shopNaver, shopGoogle, shopKakao, shopView);
                restaurantList.add(shopInfo);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            JDBCUtil.close(rs, stmt, conn);
        }

        return restaurantList;
    }




    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // API 호출 및 데이터 가져오기
            fetchDataFromApi(request);

            // 각 날씨에 대한 맛집 리스트 가져오기 각각 다른 리스트에 저장하였음
            List<ShopInfo> restaurantList0 = extractRestaurantListFromDB(0);
            List<ShopInfo> restaurantList1 = extractRestaurantListFromDB(1);
            List<ShopInfo> restaurantList2 = extractRestaurantListFromDB(2);
            List<ShopInfo> restaurantList3 = extractRestaurantListFromDB(3);

            // JSP 파일로 포워딩
            request.setAttribute("restaurantList0", restaurantList0);
            request.setAttribute("restaurantList1", restaurantList1);
            request.setAttribute("restaurantList2", restaurantList2);
            request.setAttribute("restaurantList3", restaurantList3);

            request.getRequestDispatcher("/1Main/weather.jsp").forward(request, response);
        } catch (ServletException e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().println("Internal Server Error");
        }
    }
}
