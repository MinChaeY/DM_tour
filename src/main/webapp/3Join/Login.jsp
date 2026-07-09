<%@ page contentType="text/html;charset=UTF-8"%>
<%
	String mem_id = (String)session.getAttribute("idKey");
	
	String log="";
	if(mem_id == null) log ="<a href='" + request.getContextPath() + "/3Join/Login.jsp'> 로그인 |</a>";
	else log = "<a href='" + request.getContextPath() + "/logout.do'> 로그아웃 </a>";

	String mem="";
	if(mem_id == null) mem ="<a href='" + request.getContextPath() + "/3Join/Register.jsp'> 회원 가입 </a>";
	else mem = "<a href='#'> 회원 수정 </a>";
%>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>동미투어 로그인</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        form {
            background-color: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        table {
            width: 100%;
        }

        td {
            padding: 8px;
        }

        input[type="text"],
        input[type="password"] {
            width: 100%;
            padding: 8px;
            margin: 4px 0;
            box-sizing: border-box;
        }

        input[type="submit"],
        input[type="reset"] {
            background-color: #57acf7;
            color: white;
            padding: 10px 15px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }

        input[type="submit"]:hover,
        input[type="reset"]:hover {
            background-color: 4d76bd;
        }

    </style>
</head>
<body>
<div class="container" id="container">
  <div class="form-container sign-in-container">
    <form method="post" action="${pageContext.request.contextPath}/login.do">
        <table>
            <tr>
                <td colspan="2" style="text-align: center; font-size: 24px; font-weight: bold;">동미투어 로그인</td>
            </tr>
            <tr>
                <td>아이디:</td>
                <td><input type="text" name="id" placeholder="아이디를 입력하세요."></td>
            </tr>
            <tr>
                <td>비밀번호:</td>
                <td><input type="password" name="password" placeholder="비밀번호를 입력하세요."></td>
            </tr>
            <tr>
                <td colspan="2">
                    <input type="submit" value="로그인">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    <input type="reset" value="다시쓰기">
                </td>
            </tr>
        </table>
    </form>
  </div>
</div>
</body>
</html>
