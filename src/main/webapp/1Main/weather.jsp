<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, java.util.Random" %>
<%@ page import="common.ShopInfo" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Weather Data</title>
</head>
<body>

<div id="weatherbody" style="display: flex; flex-wrap:; wrap; align-items: center; justify-content: space-around; padding: 10px; ">
    <div class="weather-info" style="margin-left:140px; flex 1; text-align: center; border-radius: 10px; padding: 20px; box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1); background-color: #f5f5f5;">
        <%@ page import="java.util.List, java.util.ArrayList, java.util.Random" %>

        <%
        List<String[]> weatherDataList = (List<String[]>) request.getAttribute("weatherDataList");

        if (weatherDataList != null && !weatherDataList.isEmpty()) {
            // for 문을 이용하여 목록에 저장된 값들을 출력
            for (String[] weatherData : weatherDataList) {
                String category = weatherData[0];
                String value = weatherData[1];
                String imageSrc = ""; // 이미지 경로를 저장할 변수

                if ("PTY".equals(category)) {
                    int ptyValue = Integer.parseInt(value);
                    String weatherDescription;

                    switch (ptyValue) {
                    case 0:
                        weatherDescription = "맑음";
                        imageSrc = "img/sun.png"; // 맑음 이미지 경로
                        break;
                    case 1:
                        weatherDescription = "비";
                        imageSrc = "img/rainy.png"; // 비 이미지 경로
                        break;
                    case 2:
                        weatherDescription = "비/눈";
                        imageSrc = "img/rainy.png"; // 비/눈 이미지 경로
                        break;
                    case 3:
                        weatherDescription = "눈";
                        imageSrc = "img/snow.png"; // 눈 이미지 경로
                        break;
                    case 4:
                        weatherDescription = "소나기";
                        imageSrc = "img/shower.png"; // 소나기 이미지 경로
                        break;
                    case 5:
                    case 7:
                        weatherDescription = "빗방울";
                        imageSrc = "img/shower.png"; // 빗방울 이미지 경로
                        break;
                    default:
                        weatherDescription = "알 수 없음";
                        imageSrc = "images/unknown.png"; // 알 수 없음 이미지 경로
                }
    %>
                    <img src="<%= imageSrc %>" alt="<%= weatherDescription %> 이미지" width="110px" height="110px" style="margin-left: " >
                    <p style="margin: 5px 0; margin-left:">날씨: <%= weatherDescription %></p>
    <%
                } else if ("REH".equals(category)) {
    %>
                    <p style="margin: 10px 0; margin-left:">습도: <%= value %> %</p>
    <%
                } else if ("T1H".equals(category)) {
    %>
                    <p style="margin: 10px 0; margin-left:">기온: <%= value %> ℃</p>
    <%
                }
            }
        } else {
    %>
            <p>날씨 정보를 가져올 수 없습니다.</p>
    <%
        }
    %>
    </div>
<div class="restaurant-list" style="flex: 1; margin-left: 0px; text-align: center; margin: 5px 0; display: flex; flex-wrap: wrap; justify-content: space-around; gap: 5px">
    <div style="width: 100%;">
        <p style="font-size: 1.17em; font-weight: bold; color: #57acf7; margin-right: 630px;"> 날씨에 따른 오늘의 추천</p> <br> <br>
    </div>
    
        <%
        // weather값에 따라 분류해놓은 리스트들을 가져옴
        List<ShopInfo> restaurantList0 = (List<ShopInfo>) request.getAttribute("restaurantList0");
        List<ShopInfo> restaurantList1 = (List<ShopInfo>) request.getAttribute("restaurantList1");
        List<ShopInfo> restaurantList2 = (List<ShopInfo>) request.getAttribute("restaurantList2");
        List<ShopInfo> restaurantList3 = (List<ShopInfo>) request.getAttribute("restaurantList3");

        Random random = new Random();

        List<ShopInfo> selectedRestaurants = new ArrayList<>();

        int caseValue = Integer.parseInt(weatherDataList.get(0)[1]);
        switch (caseValue) {
            case 0:
                selectedRestaurants = getRandomElements(restaurantList0, 2, random);
                break;
            case 5:
            case 7:
                selectedRestaurants = getRandomElements(restaurantList1, 2, random);
                break;
            case 1:
            case 2:
            case 3:
                selectedRestaurants = getRandomElements(restaurantList2, 2, random);
                break;
            case 4:
                selectedRestaurants = getRandomElements(restaurantList3, 2, random);
                break;
            default:
                
        }

        
        for (ShopInfo restaurant : selectedRestaurants) {
        %>
        <div style="text-align: center; display: flex; flex-direction: column; align-items: center; margin-right: 50px; margin-left: 20px">
            <img src="img/eatImg/<%= restaurant.getNo() %>.png" alt="<%= restaurant.getName() %> 이미지" width="350px" height="250px" style="margin-bottom: 0px; margin-right: 30px">
           
            
            <p style="margin: 5px;"><%= restaurant.getName() %></p>
        </div>
        <%
        }
        %>
    </div>
</div>

<%! 
private List<ShopInfo> getRandomElements(List<ShopInfo> originalList, int count, Random random) {
    List<ShopInfo> selectedElements = new ArrayList<>();
    List<ShopInfo> copyList = new ArrayList<>(originalList);

    for (int i = 0; i < count && !copyList.isEmpty(); i++) {
        int randomIndex = random.nextInt(copyList.size());
        selectedElements.add(copyList.get(randomIndex));
        copyList.remove(randomIndex);
    }

    return selectedElements;
}
%>

</body>
</html>
