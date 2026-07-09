<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<%-- 스타일 --%>
<style>
    .con {
        height: 400px;
        margin: 10px;
    }
    .con tr td {
    	padding-left: 50px;
    	padding-right: 50px;
    }
    table {
    	table-layout: fixed;
    	width: 100%;
    }
    tr {
        height: 300px;
    }
    td {
        text-align: center;
        vertical-align: top; /* 상단 정렬 설정 */
    }

    #todays {
        color: #000;
        font-family: Pretendard;
        font-size: 36px;
        font-style: normal;
        font-weight: 500;
        line-height: normal;
    }
    .genre {
        color: black;
        text-decoration: none;
    }
    /* 링크 추가하면 아래 주석 해제하기 */
    /*
    .genre:active, .genre:link, .genre:visited {
        color: aqua;
    }
    */
    
</style>
<title>Insert title here</title>

</head>

<body>
    <%-- 헤더 영역 --%>
    <div id="header-container"></div>
  
    <div id="content1">
        <h1>오늘의 추천 장소</h1>
    	<br>
    	<br>
        <div>
	        <h4 style="margin-left: 50px;">
	            <a href="#" class="genre">한식</a> | 
	            <a href="#" class="genre">분식</a> | 
	            <a href="#" class="genre">중식</a> | 
	            <a href="#" class="genre">양식</a> | 
	            <a href="#" class="genre">일식</a> | 
	            <a href="#" class="genre">아시안</a> | 
	            <a href="#" class="genre">인스턴트</a> | 
	            <a href="#" class="genre">이태리</a> | 
	            <a href="#" class="genre">간편식</a> | 
	            <a href="#" class="genre">디저트</a> | 
	            <a href="#" class="genre">주점</a>
            </h4>
        </div>
<table class="con">
    <%-- 사용자의 역할을 확인하는 코드 (예: 세션에서 사용자 정보를 가져오는 등) --%>
    <%
        String userRole = (String)session.getAttribute("role"); // 사용자의 역할 (예: '0'은 관리자)

        // 데이터 베이스 값 가져오기, 아래는 예시 데이터
        String[] letsEat = {"인생극장쪽갈비 고척점", "멘야이찌방", "명가 즉석 두부이야기 본점", "지지고 동양미래대점", "데일리스위츠", "공양"};

        for (int i = 0; i < letsEat.length; i += 3) {
    %>
                <tr><!-- 3개마다 반복 -->
                <% for (int j = 0; j < 3; j++) { %>
                    <td>
                        <img src="${pageContext.request.contextPath}/img/eatImg/<%= i+j+1 %>.png"><br>
                        <h4><%= letsEat[i + j] %></h4>

                        <%-- 사용자의 역할이 관리자인 경우에만 링크 추가 --%>
                        <% if ("0".equals(userRole)) { %>
                            <br>
                            <a href="#">[수정]</a>
                            <a href="#">[삭제]</a>
                        <% } %> <%-- if문 종료 --%>
                    </td>
                <% } %>
            </tr>
            <% } %> <%-- for문 종료 --%>
</table>

    </div>
    
    <p style="margin-bottom: 30px;" />
    
    <%-- 푸터 영역 --%>
    <div id="footer-container"></div>

    <script>
    // 헤더 가져오기
    fetch('${pageContext.request.contextPath}/1Main/header.jsp')
        .then(response => response.text())
        .then(data => {
            document.getElementById('header-container').innerHTML = data;
        });
  
     // 푸터 가져오기
     fetch('${pageContext.request.contextPath}/1Main/footer.jsp')
          .then(response => response.text())
          .then(data => {
              document.getElementById('footer-container').innerHTML = data;
           });
   
    </script>
</body>
</html>