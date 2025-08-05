<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>회원가입</title>
    <style>
        body {
            font-family: sans-serif;
            background-color: rgb(255, 255, 255);
            color: black;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        .login-container {
            width: 400px;
            padding: 30px;
            background-color: #fefefe;
            border-radius: 15px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.2);
        }

        .login-container h2 {
            text-align: center;
            margin-bottom: 20px;
            color: #000;
        }

        .input-group {
            margin-bottom: 15px;
        }

        .input-group label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
        }

        .input-group input,
        .input-group select {
            width: 100%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 8px;
        }

        .input-group input:focus,
        .input-group select:focus {
            outline: none;
            border-color: #fd4c4c;
            box-shadow: 0 0 5px rgba(253, 76, 76, 0.4);
        }

        .id-input-wrapper {
            display: flex;
        }

        .id-input-wrapper input {
            flex: 1;
            border-top-right-radius: 0;
            border-bottom-right-radius: 0;
        }

        .id-input-wrapper button {
            padding: 10px;
            font-size: 12px;
            border: 1px solid #ccc;
            border-left: none;
            background-color: #ffcccc;
            color: black;
            cursor: pointer;
            border-top-right-radius: 8px;
            border-bottom-right-radius: 8px;
        }

        .id-input-wrapper button:hover {
            background-color: #fd4c4c;
            color: white;
        }

        .btn-group input[type="submit"] {
            width: 100%;
            padding: 12px;
            background-color: #ffcccc;
            border: none;
            border-radius: 20px;
            font-weight: bold;
            cursor: pointer;
        }

        .btn-group input[type="submit"]:hover {
            background-color: #fd4c4c;
            color: white;
        }

        #checkIdResult {
            font-size: 13px;
            margin-top: 5px;
            text-align: left;
        }
    </style>

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>

    <div class="login-container">
        <h2>회원가입</h2>
        <form action="${pageContext.request.contextPath}/register"
              method="post" class="signup-form">

            <div class="input-group">
                <label for="user_id">아이디</label>
                <div class="id-input-wrapper">
                    <input type="text" name="user_id" id="user_id" placeholder="아이디를 입력하세요" required>
                    <button type="button" id="checkIdBtn">중복체크</button>
                </div>
                <div id="checkIdResult"></div>
            </div>

            <div class="input-group">
                <label for="user_pw">비밀번호</label>
                <input type="password" name="user_pw" id="user_pw" placeholder="비밀번호를 입력하세요" required>
            </div>

            <div class="input-group">
                <label for="user_nick">닉네임</label>
                <input type="text" name="user_nick" id="user_nick" placeholder="닉네임을 입력하세요" required>
            </div>

            <div class="input-group">
                <label for="user_birthdate">생일</label>
               <input type="date" name="user_birthdate" id="user_birthdate" 
       required min="1900-01-01" max="2025-12-31">

            </div>

            <div class="input-group">
                <label for="user_gender">성별</label>
                <select name="user_gender" id="user_gender">
                    <option value="M">남성</option>
                    <option value="F">여성</option>
                </select>
            </div>

            <div class="btn-group">
                <input type="submit" value="회원가입">
            </div>
        </form>
    </div>

    <script>
        $(document).ready(function () {
            $("#checkIdBtn").click(function () {
                let userId = $("#user_id").val().trim();
                if (userId === "") {
                    alert("아이디를 입력하세요!");
                    return;
                }

                $.ajax({
                    url: "${pageContext.request.contextPath}/checkId",
                    type: "GET",
                    data: { user_id: userId },
                    success: function (result) {
                        if (result === "exists") {
                            $("#checkIdResult").text("이미 사용 중인 아이디입니다.").css("color", "red");
                        } else if (result === "available") {
                            $("#checkIdResult").text("사용 가능한 아이디입니다!").css("color", "green");
                        }
                    },
                    error: function () {
                        alert("서버 요청 실패");
                    }
                });
            });
        });
    </script>

</body>
</html>
