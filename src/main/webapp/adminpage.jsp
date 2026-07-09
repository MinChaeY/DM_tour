<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.util.*, com.servlet.step4.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>  

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>동미투어</title>
    <link rel="stylesheet" href='${pageContext.request.contextPath}/css/style.css'>
    <link rel="stylesheet" href='${pageContext.request.contextPath}/css/adminpage.css'>
</head>
<body>
    <!-- top 헤더 영역 -->
    <div id="header-container"></div>

    <!-- 콘텐츠 영역 -->
    <div id="content1">
        <!-- 왼쪽 메뉴바 -->
        <nav class="left-sidebar">
            <ul>
                <li><a href="#" onclick="showContent('member')">회원 정보</a></li>
                <li><a href="#" >회원 관리</a></li>
            </ul>
        </nav>

    <!-- 오른쪽 콘텐츠 영역 -->
        <!-- 관리자인 경우에만 회원 목록을 표시 -->
			<!-- 회원 목록 표시 부분 -->
			<section class="right-content" id="member">
			    <div class="member-info">
			        <h1>회원목록</h1>
			        관리자 아이디: ${idKey}
			        <c:if test="${idKey == null}">
			            <a href='${pageContext.request.contextPath}/3Join/Login.jsp'>로그인</a>
			        </c:if>
			        <c:if test="${idKey != null}">
			            <a href='logout.do'>로그아웃</a>
			        </c:if>
			<br>
				<br>
				<table>
				    <thead>
				        <tr>
				            <th>아이디</th>
				            <th>비밀번호</th>
				            <th>닉네임</th>
				            <th>성별</th>
				            <th>역할</th>
				            <th>동작</th>
				        </tr>
				    </thead>
				    <tbody>
				        <c:forEach items="${vlist}" var="memberList">
				            <tr data-member-id="${memberList.id}">
				                <td>${memberList.id}</td>
				                <td>${memberList.password}</td>
				                <td>${memberList.nick}</td>
				                <td>${memberList.gen}</td>
				                <td>${memberList.role}</td>
				                <td>
				                    <a href="#" onclick="deleteMember('${memberList.id}')">삭제</a>
				                    <a href="#" onclick="editMember('${memberList.id}', '${memberList.password}', '${memberList.nick}', '${memberList.gen}', '${memberList.role}')">수정</a>
				                </td>
				            </tr>
				        </c:forEach>
				    </tbody>
				</table>
			    </div>
			</section>
			
	<!-- 회원 정보 수정 폼 -->
	<section class="right-content" id="edit-info" style="display: none;">
	    <h2>회원 정보 수정</h2>
	    <br>
		   <form id="editmem" onsubmit="submitForm(event);" accept-charset="UTF-8">
		        <label for="editId">아이디:</label>
		        <input type="text" id="editId" name="editId" readonly> <br>
		
		        <label for="editPassword">비밀번호:</label>
		        <input type="text" id="editPassword" name="editPassword" required><br>
		
		        <label for="editNick">닉네임:</label>
		        <input type="text" id="editNick" name="editNick" required><br>
		
		        <label for="editGen">성별:</label>
		        <select id="editGen" name="editGen">
		            <option value="남성">남성</option>
		            <option value="여성">여성</option>
		        </select><br>
		
		        <label for="editRole">역할:</label>
		        <select id="editRole" name="editRole">
		            <option value="0">관리자</option>
		            <option value="1">회원</option>
		        </select><br>
		        <br>
		        <button type="submit">수정 완료</button>
		    </form>
	</section>
</div>


    <!-- 푸터 영역 -->
    <div id="footer-container"></div>

  
    <script>
    function deleteMember(id) {
        // 삭제 여부를 확인하는 팝업을 표시.
        var isConfirmed = confirm('정말 삭제하시겠습니까?');

        // 사용자가 확인하면 서버로 삭제 요청 보내기.
        if (isConfirmed) {
            // AJAX를 사용하여 서버로 삭제 요청을 보냄.
            var xhr = new XMLHttpRequest();
            xhr.open('POST', "${pageContext.request.contextPath}/Delete.do", true);
            xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');

            // 서버로 전송할 데이터를 설정.
            var data = 'id=' + encodeURIComponent(id);

            xhr.onreadystatechange = function () {
                if (xhr.readyState == 4) {
                    if (xhr.status == 200) {
                        // 서버에서 성공적으로 응답을 받으면 해당 행을 삭제
                        var row = document.querySelector('tr[data-member-id="' + id + '"]');
                        if (row) {
                            // 0.7초 후에 삭제되었습니다 팝업 메시지 표시
                            setTimeout(function () {
                                window.alert('삭제되었습니다.');
                                updateMemberList(); // 삭제 후 멤버 목록 업데이트 호출
                            }, 700);
                        }
                    } else {
                        // 서버에서 오류 응답을 받으면 오류 메시지 표시
                        window.alert('삭제 중 오류가 발생했습니다.');
                    }
                }
            };

            // 데이터를 전송합니다.
            xhr.send(data);
        }
    }
    
 // 회원 목록을 업데이트하는 함수
    function updateMemberList() {
        var xhr = new XMLHttpRequest();
        xhr.open('GET', '${pageContext.request.contextPath}/Fetch.do', true); // 서버에서 멤버 목록을 가져오는 서블릿 주소로 변경해야 합니다.

        xhr.onreadystatechange = function () {
            if (xhr.readyState == 4) {
                if (xhr.status == 200) {
                    // 서버에서 성공적으로 응답을 받으면 멤버 목록을 업데이트
                    var memberListContainer = document.getElementById('member'); // 멤버 목록을 표시하는 컨테이너 ID로 변경해야 합니다.
                    memberListContainer.innerHTML = xhr.responseText;
                    adjustContentHeight(); // 예시로 높이 조절 함수 호출
                } else {
                    // 서버에서 오류 응답을 받으면 오류 메시지 표시
                    window.alert('멤버 목록을 가져오는 중 오류가 발생했습니다.');
                }
            }
        };

        // 데이터를 요청합니다.
        xhr.send();
    }

    function editMember(id, password, nick, gen, role) {
        // 수정 폼을 표시
        showContent('edit-info');

        // 기존 데이터를 폼에 채움
        document.getElementById('editId').value = id;
        document.getElementById('editPassword').value = password;
        document.getElementById('editNick').value = nick;
        document.getElementById('editGen').value = gen;
        document.getElementById('editRole').value = role;
    }
    
    //회원 정보 업데이트
    function submitForm(event) {
        event.preventDefault(); // 기존의 폼 제출 방식을 방지합니다.

        // 입력받은 폼 데이터 수집
        var id = document.getElementById('editId').value;
        var password = document.getElementById('editPassword').value;
        var nick = document.getElementById('editNick').value;
        var gen = document.getElementById('editGen').value;
        var role = document.getElementById('editRole').value;

        // AJAX를 사용하여 서버로 수정 요청을 보냄
        var xhr = new XMLHttpRequest();
        xhr.open('POST', '${pageContext.request.contextPath}/Update.do', true);
        xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded; charset=UTF-8'); //한글깨져서 인코딩 추가

        // 서버로 전송할 데이터 설정
        var data = 'id=' + encodeURIComponent(id) +
                   '&password=' + encodeURIComponent(password) +
                   '&nick=' + encodeURIComponent(nick) +
                   '&gen=' + encodeURIComponent(gen) +
                   '&role=' + encodeURIComponent(role);

        xhr.onreadystatechange = function () {
            if (xhr.readyState == 4) {
                if (xhr.status == 200) {
                    // 서버에서 성공적으로 응답을 받으면 다음 작업을 수행
                    window.alert('수정되었습니다.');
                    showContent('member'); // 회원 목록으로 이동하거나 다른 조치를 취할 수 있습니다.
                    updateMemberList(); // 수정 후 멤버 목록 업데이트 호출
                } else {
                    // 서버에서 오류 응답을 받으면 오류 메시지 표시
                    window.alert('수정 중 오류가 발생했습니다.');
                }
            }
        };

        // 데이터를 전송합니다.
        xhr.send(data);
    }
    
 // 회원 목록을 업데이트하는 함수
    function updateMemberList() {
        var xhr = new XMLHttpRequest();
        xhr.open('GET', '${pageContext.request.contextPath}/Fetch.do', true); // 서버에서 멤버 목록을 가져오는 서블릿 주소로 변경해야 합니다.

        xhr.onreadystatechange = function () {
            if (xhr.readyState == 4) {
                if (xhr.status == 200) {
                    // 서버에서 성공적으로 응답을 받으면 멤버 목록을 업데이트
                    var memberListContainer = document.getElementById('member'); // 멤버 목록을 표시하는 컨테이너 ID로 변경해야 합니다.
                    memberListContainer.innerHTML = xhr.responseText;
                    adjustContentHeight(); // 예시로 높이 조절 함수 호출
                } else {
                    // 서버에서 오류 응답을 받으면 오류 메시지 표시
                    window.alert('멤버 목록을 가져오는 중 오류가 발생했습니다.');
                }
            }
        };

        // 데이터를 요청합니다.
        xhr.send();
    }

    
   
        <!--여기서 부터는 콘텐츠 부분 관련된 함수-->
        
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
            // 왼쪽 메뉴 모든 콘텐츠 숨김
            var contents = document.getElementsByClassName('right-content');
            for (var i = 0; i < contents.length; i++) {
                contents[i].style.display = 'none';
            }

            // 왼쪽 메뉴 중 선택한 콘텐츠만 표시
            document.getElementById(contentId).style.display = 'block';
        }


        // 헤더, 푸터 콘텐츠 높이 동적 조절
        function adjustContentHeight() {
            var headerHeight = document.getElementById('header-container').offsetHeight;
            var footerHeight = document.getElementById('footer-container').offsetHeight;
            var content1 = document.getElementById('content1');
            var windowHeight = window.innerHeight;

            content1.style.minHeight = windowHeight - headerHeight - footerHeight - 24 + 'px';
            console.log(headerHeight+", "+footerHeight);
        }
    </script>
</body>
</html>