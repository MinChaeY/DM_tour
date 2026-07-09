<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style.css">
<title>푸터부분임</title>
    <style>
        /* 푸터 스타일 */
        footer {
            background-color: #8ebafd; /* 푸터 배경색 */
            color: #fff; /* 푸터 텍스트 색상 */
            padding: 20px; /* 푸터 여백 */
            text-align: center; /* 텍스트 가운데 정렬 */
    		position: relative; /* 페이지 내용의 위치에 따라 상대적으로 배치 */
            width: 100%; /* 전체 너비 */
            z-index: 2; /*마이페이지의 left-sidebar랑 안 겹치게..*/
            margin: auto; 
            bottom: 0; /* 페이지 하단에 위치 */
            
        }

        /* 저작권 정보 스타일 */
        .copyright p {
            margin: 0;
            font-size: 14px; /* 폰트 크기 */
        }

        /* 유의사항 정보 스타일 */
        .disclaimer p {
            font-size: 12px; /* 폰트 크기 */
        }
    </style>
</head>
<body>
    <!-- 푸터 영역 -->
    <footer>
        <div class="copyright">
            <p>&copy; 2023 동미투어 웹사이트~ </p>
        </div>
        <div class="disclaimer">
            <p>이 웹사이트는 어쩌구 저쩌구</p>
        </div>
    </footer>
</body>
</html>