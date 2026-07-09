package com.servlet.step4;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * 회원정보 수정 서블릿
 */
@WebServlet("/Update.do")
public class UpdateController extends HttpServlet {
	

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	response.setCharacterEncoding("UTF-8");
    	
        // 클라이언트로부터 전송된 데이터를 받음
        String id = request.getParameter("id");
        String password = request.getParameter("password");
        String nick = request.getParameter("nick");
        String gen = request.getParameter("gen");
        String role = request.getParameter("role");

        // 받은 데이터를 이용하여 MemberDTO 객체 생성
        MemberDTO memberDTO = new MemberDTO();
        memberDTO.setId(id);
        memberDTO.setPassword(password);
        memberDTO.setNick(nick);
        memberDTO.setGen(gen);
        memberDTO.setRole(Integer.parseInt(role));

        // MemberDAO를 통해 회원 정보를 업데이트
        MemberDAO memberDAO = new MemberDAO();
        boolean updateResult = memberDAO.updateMember(memberDTO);

        // 클라이언트에게 응답을 전송
        if (updateResult) {
            response.getWriter().write("success"); // 성공했을 경우
        } else {
            response.getWriter().write("failure"); // 실패했을 경우
        }
    }
}


