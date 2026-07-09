package com.servlet.step4;

import java.io.IOException;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
/**
 * 회원정보 삭제 서블릿
 */
@WebServlet("/Delete.do")
public class DeleteController extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {


        // 클라이언트에서 전달된 삭제할 회원의 아이디
        String id = request.getParameter("id");

        // 회원 삭제 처리
        MemberDAO memberDAO = new MemberDAO();
        boolean deleteResult = memberDAO.deleteMember(id);

        if (deleteResult) {
            // 삭제 성공 시
            response.sendRedirect(request.getContextPath() + "/adminpage.jsp"); // 삭제 후 이동할 페이지
        } else {
            // 삭제 실패 시
            response.sendRedirect(request.getContextPath() + "/error.jsp"); // 삭제 실패 시 이동할 페이지
        }
    }
}
