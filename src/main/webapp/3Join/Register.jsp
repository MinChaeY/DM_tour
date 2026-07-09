<%@ page contentType="text/html;charset=UTF-8"%>
<%
    String mem_id = (String)session.getAttribute("idKey");

    String log="";
    if(mem_id == null) log ="<a href='" + request.getContextPath() + "/3Join/Login.jsp' style='color: #57acf7; text-decoration: none;'> 로그인 </a>";
    else log = "<a href='" + request.getContextPath() + "/logout.do' style='color: #57acf7; text-decoration: none;'> 로그아웃 </a>";

    String mem="";
    if(mem_id == null) mem ="<a href='" + request.getContextPath() + "/3Join/Register.jsp' style='color: #57acf7; text-decoration: none;'> 회원 가입 </a>";
    else mem = "<a href='#' style='color: #57acf7; text-decoration: none;'> 회원 수정 </a>";

    // 실패 상태를 확인하여 알럿을 띄우는 JavaScript 코드 추가
    int joinResult = (request.getAttribute("joinResult") != null) ? (int)request.getAttribute("joinResult") : -1;
%>
<html>
<head>
    <title>회원가입</title>
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
            color: black;
            margin-bottom: 10px;
        }

        table {
            width: 100%;
            margin-top: 20px;
        }

        td {
            padding: 8px;
        }

        input[type="text"],
        input[type="password"],
        select {
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

        .alert {
            color: #a94442;
            background-color: #f2dede;
            border: 1px solid #ebccd1;
            border-radius: 4px;
            padding: 10px;
            margin-top: 10px;
            display: <%=(joinResult == 0) ? "block" : "none"%>;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>회원가입</h1>

        <%=log%> <%=mem%>

        <br><br>
        <table>
            <form name="regForm" method="get" action="${pageContext.request.contextPath}/register.do">
                <tr>
                    <td>회원 가입</td>
                </tr>
                <tr>
                    <td>아이디</td>
                    <td>
                        <input type="text" name="id" placeholder="아이디를 입력하세요.">
                        <input type="button" value="ID중복확인" onClick="idCheck(this.form.mem_id.value)">
                    </td>
                </tr>
                <tr>
                    <td>패스워드</td>
                    <td><input type="password" name="password" placeholder="비밀번호를 입력하세요."></td>
                </tr>
                <tr>
                    <td>패스워드 확인</td>
                    <td><input type="password" name="RePassword" placeholder="비밀번호를 다시 입력하세요."></td>
                </tr>
                <tr>
                    <td>닉네임</td>
                    <td><input type="text" name="nick" placeholder="닉네임은 수정할 수 있습니다."> </td>
                </tr>
                <tr>
                    <td>성별</td>
                    <td>
                        <select name=gen>
                            <option value="0">선택하세요.
                            <option value="여성">여성
                            <option value="남성">남성
                        </select>
                    </td>
                </tr>
                <tr>
                    <td>
                        <input type="submit" value="회원가입">
                        <input type="reset" value="다시쓰기">
                    </td>
                </tr>

                <!-- 실패 상태일 때 알럿을 띄우는 조건 추가 -->
                <tr>
                    <td colspan="2" class="alert" id="alertMessage">
                        <% if (joinResult == 0) { %>
                            회원가입에 실패했습니다. 필수 정보를 모두 입력해주세요.
                        <% } %>
                    </td>
                </tr>
            </form>
        </table>
    </div>

    <script>
        // 실패 상태일 때 알럿을 띄우는 JavaScript 함수
        function showFailedAlert() {
            document.getElementById('alertMessage').style.display = 'block';
        }
        
        // 페이지 로드 후 실행
        window.onload = function() {
            <% if (joinResult == 0) { %>
                showFailedAlert();
            <% } %>
        }
    </script>
</body>
</html>
