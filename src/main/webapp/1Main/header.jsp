<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String mem_id = (String)session.getAttribute("idKey");
    String mem_role = (String)session.getAttribute("role"); // 세션에 회원 역할 저장.

    System.out.println("mem_role: " + mem_role); // 디버그 출력

    String log="";
    if(mem_id == null) log ="<a href='" + request.getContextPath() + "/3Join/Login.jsp' style='color: black; text-decoration: none;'> 로그인</a>";
    else log = "<a href='" + request.getContextPath() + "/logout.do' style='color:#5685d6; text-decoration: none;'> 로그아웃 </a>";

    String mem="";
    if(mem_id == null) mem ="<a href='" + request.getContextPath() + "/3Join/Register.jsp' style='color: black; text-decoration: none;'> 회원 가입 </a>";
    else mem = "<a href='" + request.getContextPath() + "/mypage.jsp' style='color: #5685d6; text-decoration: none;'> 회원 수정 </a>";

    String adminPageLink = "";
    if(mem_id != null && "0".equals(mem_role)) {
        System.out.println("Setting is adminPage"); // 디버그 출력
        adminPageLink = "<li><a href='" + request.getContextPath() + "/adminpage.jsp'>관리자페이지</a></li>";
    }
%>
<!DOCTYPE html>
<html>
<head>
   <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
	<link rel="stylesheet" href='${pageContext.request.contextPath}/css/style.css'>
<title>헤더부분임</title>
</head>
<body>

    <!-- top 헤더 영역 -->
    <header class="top-header">
        <h1 class="dongyang" >
            <a href="${pageContext.request.contextPath}/index.jsp" style="text-decoration: none; color:black;">동미<span class="dongtour">투어</span></a>
        </h1>
        <nav>
            <form class="search" action="#" method="GET">
                <div class="rounded-search">
                    <input type="text" name="search" placeholder="검색어를 입력하세요">
                    <button type="submit">검색</button>
                </div>
            </form>
        </nav>
            <ul class="login">
				<%=log%> |  <%=mem%>
				<br><br>
				<%
				if(mem_id != null){
				%>
					<%=mem_id%>님 방문해 주셔서 감사합니다. 
				<%}else{%>
					로그인 하신 후 이용해 주세요
				<%}%>
				<%=adminPageLink%> <!-- 추가된 부분 -->
            </ul>
    </header>

    <!-- bottom 헤더 영역 -->
    <header class="bottom-header">
        <nav>
            <ul class="menu">
                <li><a href='${pageContext.request.contextPath}/2Sub/forEat.jsp'>먹거리</a>
                    <div class="submenu">
                        <a href="#">일식</a>
                        <a href="#">중식</a>
                        <a href="#">양식</a>
                        <a href="#">한식</a>
                    </div>
                </li>
                <li><a href="#">놀거리</a>
                    <div class="subplay">
                        <a href="#">놀이1</a>
                        <a href="#">놀이2</a>
                        <a href="#">놀이3</a>
                        <a href="#">놀이4</a>
                    </div>
                </li>
                <li><a href="${pageContext.request.contextPath}/2Sub/wallpaper.jsp">고척돔 스케줄</a></li>
                <li><a href="${pageContext.request.contextPath}/mypage.jsp">마이페이지</a></li>
            </ul>
        </nav>
    </header>
    <!-- 컨텐츠의 나머지 내용 -->
</body>
</html>