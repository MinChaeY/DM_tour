package com.servlet.step4;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * 회원목록 업데이트 서블릿
 */
@WebServlet("/Fetch.do")
public class FetchController extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        try {
            // MemberDAO의 selectMemberList() 메소드를 호출하여 회원 목록을 가져옴
            MemberDAO memberDAO = new MemberDAO();
            ArrayList<MemberDTO> memberList = memberDAO.selectMemberList();
            
            // HTML 응답 시작
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>회원목록</title>");
            out.println("</head>");
            out.println("<body>");

            // 회원 목록을 HTML 테이블 형식으로 변환
            String htmlResponse = convertMemberListToHtmlTable(memberList);

            // HTML 응답 전송
            out.print(htmlResponse);

            // HTML 응답 종료
            out.println("</body>");
            out.println("</html>");
        } catch (Exception e) {
            out.print("회원 목록을 가져오는 중 오류 발생: " + e.getMessage());
        } finally {
            out.close();
        }
    }

    // 회원 목록을 HTML 테이블 형식으로 변환하는 메소드
    private String convertMemberListToHtmlTable(ArrayList<MemberDTO> memberList) {
        StringBuilder htmlBuilder = new StringBuilder();
        htmlBuilder.append("<h1>회원목록</h1>");
        htmlBuilder.append("<br>");
        htmlBuilder.append("<table>");
        htmlBuilder.append("<tr><th>아이디</th><th>비밀번호</th><th>닉네임</th><th>성별</th><th>역할</th><th>동작</th></tr>");

        for (MemberDTO member : memberList) {
            htmlBuilder.append("<tr>");
            htmlBuilder.append("<td>").append(member.getId()).append("</td>");
            htmlBuilder.append("<td>").append(member.getPassword()).append("</td>");
            htmlBuilder.append("<td>").append(member.getNick()).append("</td>");
            htmlBuilder.append("<td>").append(member.getGen()).append("</td>");
            htmlBuilder.append("<td>").append(member.getRole()).append("</td>");
            htmlBuilder.append("<td><a href='#' onclick='deleteMember(\"").append(member.getId()).append("\")'>삭제</a> ");
            htmlBuilder.append("<a href='#' onclick='editMember(\"").append(member.getId()).append("\", \"").append(member.getPassword()).append("\", \"")
                    .append(member.getNick()).append("\", \"").append(member.getGen()).append("\", \"").append(member.getRole()).append("\")'>수정</a></td>");
            htmlBuilder.append("</tr>");
        }

        htmlBuilder.append("</table>");

        return htmlBuilder.toString();
    }
}
