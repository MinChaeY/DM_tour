<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href='${pageContext.request.contextPath}/css/style.css'>
<link rel="stylesheet" href='${pageContext.request.contextPath}/css/mypage.css'>
<title> 동미투어 </title>
</head>
<body>
    <!-- top 헤더 영역 -->
    <div id="header-container"></div>

	<!-- 콘텐츠 영역 -->
	<div id="content1">
		<!-- 왼쪽 메뉴바 -->
		<nav class="left-sidebar">
		    <ul>
		        <li><a href="#" onclick="showContent('profile')">내 정보</a></li>
		        <li><a href="#" onclick="showContent('edit-info')">정보 수정</a></li>
		        <li><a href="#" onclick="showContent('change-password')">비밀번호 변경</a></li>
		    </ul>
		</nav>
		
		<!-- 오른쪽 콘텐츠 영역 -->
		<section class="right-content" id="profile" style="display: none;">
		    <!-- 내 정보 표시 -->
		    <h2>회원 정보</h2>
		    <p>여기에 회원 정보를 표시하세요.</p>
		    <div class="profile-info">
		        <img src='${pageContext.request.contextPath}/img/myprofile.jpg' alt="프로필 사진" style="border-radius: 50%; width: 200px;">
		        <p><strong>아이디:</strong> ${idKey}</p>
		        <p><strong>닉네임:</strong> <span id="profile-nickname">${nickKey}</span></p>
		
		        <p><strong>성별:</strong> 여성</p>
		    </div>
		</section>
		
		<section class="right-content" id="edit-info" style="display: none;">
		    <!-- 정보 수정 양식 등 -->
		    <h2>정보 수정</h2>
		    <p>여기에서 정보를 수정하세요.</p>
		    <form id="editProfileForm" action="#" method="POST">
		        <img src='${pageContext.request.contextPath}/img/myprofile.jpg' alt="프로필 사진" style="border-radius: 50%; width: 200px;">
		        <label for="profilePicture">프로필 사진 변경:</label>
		        <input type="file" id="profilePicture" name="profilePicture" accept="image/*">
		        <br>
		        <label for="nickname">닉네임 변경:</label>
		        <input type="text" id="nickname" name="nickname" placeholder="새로운 닉네임">
		
		        <button type="submit">저장</button>
		    </form>
		</section>
		
		<section class="right-content" id="change-password" style="display: none;">
		    <!-- 비밀번호 변경 양식 등 -->
		    <h2>비밀번호 변경</h2>
		    <p>여기에 비밀번호 변경 양식 등을 표시하세요.</p>
		</section>
	</div>


  <!-- 푸터 영역 -->
  <div id="footer-container"></div>



  <!-- 여기에 스크립트 링크 또는 스크립트 코드 추가 -->
  
	<script>
    
		// 웹 페이지가 로드될 때 DOMContentLoaded 이벤트 리스너 실행
		document.addEventListener("DOMContentLoaded", function () {
	        // 헤더 가져오기
	        fetch('${pageContext.request.contextPath}/1Main/header.jsp')
	            .then(response => response.text())
	            .then(data => {
	    		    // top-header 시작 위치 찾기
	    		    const startIndex = data.indexOf('<header class="top-header">');
	    		    // top-header 종료 위치 찾기
	    		    const endIndex = data.indexOf('</header>', startIndex) + '</header>'.length;
	    		
	    		    // top-header 부분 추출
	    		    const topHeaderHTML = data.substring(startIndex, endIndex);
	    		
	    		    // top-header를 특정한 컨테이너에 추가
	    		    document.getElementById('header-container').innerHTML = topHeaderHTML;

	                // 푸터 가져오기
	                return fetch('${pageContext.request.contextPath}/1Main/footer.jsp');
	            })
	            .then(response => response.text())
	            .then(data => {
	                document.getElementById('footer-container').innerHTML = data;
	        	 	adjustContentHeight(); // 페이지 로드 시 높이 조절 함수 호출
	            });
	    });
		
		
		function showContent(contentId) {
		// 모든 콘텐츠 숨김
		var contents = document.getElementsByClassName('right-content');
		for (var i = 0; i < contents.length; i++) {
		    contents[i].style.display = 'none';
		}
		
		// 선택한 콘텐츠만 표시
		document.getElementById(contentId).style.display = 'block';
		}
		
		// 페이지 로드 시 자동으로 '''프로필 정보화면''' 보이기
		document.addEventListener('DOMContentLoaded', function () {
		showContent('profile');
		});
		

		
		
		/*닉네임 바꾸기*/
		
		// 내 정보 표시 부분
		const profileNicknameElement = document.getElementById('profile-nickname');
		const editNicknameInput = document.getElementById('nickname');
		
		// 기존 닉네임 가져와서 텍스트 입력란에 설정
		editNicknameInput.value = profileNicknameElement.textContent
		
		
		document.addEventListener('DOMContentLoaded', function () {
		    showContent('profile');
		    
		        // 프로필 수정 폼 이벤트 리스너 등록
		    document.getElementById('editProfileForm').addEventListener('submit', function (event) {
		        event.preventDefault(); // 폼의 기본 동작 방지
		
		        // 수정된 내용을 가져오기
		        var newNickname = document.getElementById('nickname').value;
		        // 다른 필요한 수정 내용도 가져오기
		        
		        // 프로필 영역에 수정된 내용 반영
		        document.getElementById('profile-nickname').innerText = newNickname;
		        // 다른 필요한 부분도 반영
		
		        // 프로필 영역 보이기
		        showContent('profile');
		    });
		});


		 // 콘텐츠 높이 동적 조절
		 function adjustContentHeight() {
		     var headerHeight = document.getElementById('header-container').offsetHeight;
		     var footerHeight = document.getElementById('footer-container').offsetHeight;
		     var content1 = document.getElementById('content1');
		     var windowHeight = window.innerHeight;

		     content1.style.minHeight = windowHeight - headerHeight - footerHeight -24 + 'px';
		     console.log(headerHeight+", "+footerHeight)
		 }
  	</script>
</body>
</html>