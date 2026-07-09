<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>로그인 실패</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background-color: #f0f0f0;
            margin: 0;
            padding: 0;
            display: flex;
            align-items: center;
            justify-content: center;
            height: 100vh;
            text-align: center;
        }

        .container {
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            padding: 20px;
        }

        h1 {
            color: #d9534f;
            margin-bottom: 10px;
        }

        h2 {
            color: #777;
            margin-bottom: 20px;
        }

        a {
            color: #428bca;
            text-decoration: none;
            font-weight: bold;
            border-bottom: 2px solid transparent;
            transition: border-bottom 0.3s ease-in-out;
        }

        a:hover {
            border-bottom: 2px solid #428bca;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>로그인할 수 없습니다.</h1>
        <h4>아이디와 비밀번호를 확인해 주세요.</h4>
        <a href='${pageContext.request.contextPath}/3Join/Login.jsp'>재로그인</a>
    </div>
</body>
</html>
