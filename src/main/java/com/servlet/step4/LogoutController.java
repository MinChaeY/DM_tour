package com.servlet.step4;

import java.io.IOException;
import java.io.PrintWriter;


import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/logout.do")
public class LogoutController extends HttpServlet {
    /**
	 * 로그아웃 서블릿
	 */
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        session.invalidate();

        // 로그아웃 메시지 설정
        request.setAttribute("logoutMessage", "로그아웃이 완료되었습니다.");

        // JavaScript 코드를 사용하여 얼럿 메시지 띄우기
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        out.println("<script type=\"text/javascript\">");
        out.println("alert('로그아웃이 완료되었습니다.');");
        out.println("location='index.jsp';");
        out.println("</script>");
    }
}

