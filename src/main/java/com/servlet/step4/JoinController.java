package com.servlet.step4;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/register.do")
public class JoinController extends HttpServlet {
	/**
	 * 회원가입 서블릿
	 */
	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		String id = request.getParameter("id");
		String pw = request.getParameter("password");
		String nick = request.getParameter("nick");
		String gen = request.getParameter("gen");

		MemberDTO mDto = new MemberDTO();
		mDto.setId(id);
		mDto.setPassword(pw);
		mDto.setNick(nick);
		mDto.setGen(gen);		
		
        // 빈칸 검증
        if (id == null || pw == null || nick == null || gen == null ||
            id.trim().isEmpty() || pw.trim().isEmpty() || nick.trim().isEmpty() || gen.trim().isEmpty()) {
        // 빈칸이 있으면 회원가입 불가
            request.setAttribute("joinResult", 0);  // 실패 상태 전달
            RequestDispatcher dispatcher = request.getRequestDispatcher("/3Join/Register.jsp");
            dispatcher.forward(request, response);
            return;
        }
		
		MemberDAO mDao = new MemberDAO();	
		boolean insertCheck = mDao.memberInsert(mDto);

	    if(insertCheck){
	    	request.setAttribute("joinResult", insertCheck);
			HttpSession session = request.getSession();
			session.setAttribute("idKey", id);
			RequestDispatcher dispatcher = request.getRequestDispatcher("/index.jsp");
			dispatcher.forward(request, response);

		}else{
	    	request.setAttribute("joinResult", 0);
			RequestDispatcher dispatcher = request.getRequestDispatcher("/3. Join/Register.jsp");
			dispatcher.forward(request, response);
		}
		   	  
	}
	
}
