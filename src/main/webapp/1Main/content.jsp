<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href='${pageContext.request.contextPath}/css/content.css'>
<title>Insert title here</title>

</head>
<body>
    <div id="content1">
    <div class="maincontent">
       

        
        
        
        <section id="recommend">
            <h3><a href="#">공지사항</a></h3>
             <div class="item">
              <section id="videooo">
            <iframe width="350" height="200" src="https://www.youtube.com/embed/9TLiFboJWp8?si=rXiu2zPjSnKFNxGn" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen></iframe>
        </section>

             </div>
            <div class="item">
                <section id="sec3">
        
            <div class="guestbook">
                <h1 id="guesth1">한줄방명록</h1>
                <textarea id="message" placeholder="메시지를 작성해주세요.
  Write your message."></textarea>
                <ul id="entries">
                   <!-- 예시 방명록  -->
                   <li class="entry">홍길동
                    메시지: 배고프다.</li>
                   <li class="entry">김철수
                    메시지: 랄랄라라</li>
                    
                    <!-- 닉네임을 데이터베이스에서 가져올 예정이므로 코드 추가가 필요함 -->
                   <!-- 추가적인 예시 방명록들을 필요에 맞게 추가 -->
                 </ul>
             </div>
           </section>
            </div>
            <div class="item">
                <section id="sec4">
             <div class="announcement">
                <p class="title"><strong>긴급공지!</strong></p><br>
                
                <ul class="ul-announce">
                   <li>동미투어 이용 안내</li>
                   <li>개인정보 이용 관련</li>
                   <li>문의사항</li>
                </ul>
            </div>
           </section>
            </div>
            
    
            <div class="clear"></div>
            
        </section> <!-- section recommend -->
        
        
        
       
           
           
          
        
    </div>
    </div>
    
    
    <script>
    
        // Enter 키 누를 때 이벤트 처리
        // index 에 fetch로 넣었을때 이벤트가 작동하지 않아서 코드를 바꿨는데 여전히 작동이 안됨.
       document.addEventListener('DOMContentLoaded', function () {
        // DOMContentLoaded 이벤트에 바인딩하여 함수 호출
         console.log('DOMContentLoaded 이벤트 발생');
        document.getElementById('message').addEventListener('keydown', function (event) {
            if (event.key === 'Enter' && !event.shiftKey) {
                event.preventDefault();
                uploadMessage();
            }
        });

        // 방명록 업로드 함수
        function uploadMessage() {
            var messageTextarea = document.getElementById('message');
            var entriesList = document.getElementById('entries');
            var messageText = messageTextarea.value.trim();

            if (messageText !== '') {
                var entry = document.createElement('li');
                entry.className = 'entry';
                entry.textContent = '메시지: ' + messageText;
                entriesList.appendChild(entry);
                messageTextarea.value = ''; // 텍스트 입력란 초기화
            }
        }
    });
     

 
    </script>
</body>
</html>