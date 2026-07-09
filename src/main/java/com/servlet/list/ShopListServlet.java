package com.servlet.list;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
// import javax.servlet.http.HttpSession;

import common.ShopInfo;

@WebServlet("/shop.do")
public class ShopListServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
        	// HttpSession session = request.getSession();
        	// int idKey = (int) session.getAttribute("role");
            // ShopInfo info = new ShopInfo();

            List<ShopInfo> shopList = new ArrayList<>();

            // 상품 목록 조회 쿼리
            String query = "SELECT * FROM for_eat";
            pstmt = conn.prepareStatement(query);
            rs = pstmt.executeQuery();

            // 결과를 Product 객체에 저장
            while (rs.next()) {
                int shopNo = rs.getInt("no");
                String shopName = rs.getString("name");
                String shopCon = rs.getString("contents");
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

                ShopInfo info = new ShopInfo(shopNo, shopName, shopCon, shopImage, shopKind, shopOpen, shopClose, shopBreak, shopOff, shopDis, shopWeather, shopNaver, shopGoogle, shopKakao, shopView);
                shopList.add(info);
            }

            // 상품 목록을 request에 저장
            request.setAttribute("shopList", shopList);

            // JSP로 포워드
            request.getRequestDispatcher("/shopList.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                // 리소스 해제
                if (rs != null) rs.close();
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
}
