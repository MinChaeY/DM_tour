package com.servlet.step4;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
/**
 * 로그인 서블릿
 */
@WebServlet("/login.do")
public class LoginController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final String INDEX_JSP = "/index.jsp";
    private static final String LOG_ERROR_JSP = "/3Join/LogError.jsp";

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        // 로그인 로직
        String id = request.getParameter("id");
        String pw = request.getParameter("password");

        try {
            MemberDAO mDao = new MemberDAO();
            boolean idKey = mDao.loginCheck(id, pw);

            if (idKey) {
                // 로그인 성공 시 회원 목록 및 역할 정보 조회
                MemberDAO rDao = new MemberDAO();

                // 회원 목록 조회
                ArrayList<MemberDTO> mList = rDao.selectMemberList();
                HttpSession session = request.getSession();
                session.setAttribute("vlist", mList);
                session.setAttribute("idKey", id);
                
                // 여기에서 닉네임 정보를 가져와서 세션에 설정
                String nick = rDao.getNick(id);
                session.setAttribute("nickKey", nick);
               

                // 여기에서 역할 정보를 가져와서 세션에 설정
                String userRole = rDao.getRole(id);
                session.setAttribute("role", userRole);
                
                RequestDispatcher dispatcher = request.getRequestDispatcher(INDEX_JSP);
                dispatcher.forward(request, response);

            } else {
                response.sendRedirect(request.getContextPath() + LOG_ERROR_JSP);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + LOG_ERROR_JSP);
        }
    }

}

 
