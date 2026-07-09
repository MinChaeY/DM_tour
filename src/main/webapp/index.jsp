<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" type="text/css" href="css/style.css">

<title> 동미투어 </title>
</head>
<body>
  <!-- 헤더 영역 -->
  <div id="header-container"></div>

  <!-- 콘텐츠 영역 -->
  <main>
      <!-- 웹 페이지의 주요 내용을 추가합니다. -->
      <div id="content-container2"></div>
      <div id="content-container"></div>

  </main>

  <!-- 푸터 영역 -->
  <div id="footer-container"></div>


  <!-- 여기에 스크립트 링크 또는 스크립트 코드 추가 -->
  
  <script>
      // 헤더 가져오기
      fetch('1Main/header.jsp')
          .then(response => response.text())
          .then(data => {
              document.getElementById('header-container').innerHTML = data;
          });

      // 컨텐츠 영역 가져오기
      // 메세지 함수가 작동이 안되길래 바꿨는데 여전히 작동되지 않음. 
       fetch('1Main/content.jsp')
            .then(response => response.text())
            .then(html => {
                document.getElementById('content-container').innerHTML = html;
                
                // DOMContentLoaded 이벤트에 바인딩하여 함수 호출
                document.addEventListener('DOMContentLoaded', function () {
                    uploadMessage();
                });
            }).catch(error => console.error('Fetch error:', error));
      //날씨 api 파일을 index안에 가져옴
      fetch('${pageContext.request.contextPath}/weather.do')
      .then(response => response.text())
      .then(data => {
          document.getElementById('content-container2').innerHTML = data;
      });
      
      // 푸터 가져오기
      fetch('1Main/footer.jsp')
          .then(response => response.text())
          .then(data => {
              document.getElementById('footer-container').innerHTML = data;
          });
      
      
 
  </script>
</body>
</html>