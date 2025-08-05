<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <title>메인 페이지</title>
    <meta charset="UTF-8" />
</head>
<body>

    <c:if test="${not empty member}">
        <!-- 로그인한 상태 -->
        <h2>${member.user_nick}님, 환영합니다!</h2>

        <!-- 로그아웃 버튼 -->
        <form action="logout" method="post">
            <input type="submit" value="로그아웃">
        </form>
    </c:if>

    <c:if test="${empty member}">
        <!-- 비로그인 상태일 때만 회원가입/로그인 버튼 보임 -->
        <div id="wrapper">
            <form action="register" method="get">
                <input type="submit" value="회원가입하기" class="button fit">
            </form>
        </div>

        <div id="wrapper">
            <form action="login" method="get">
                <input type="submit" value="로그인하기" class="button fit">
            </form>
        </div>
    </c:if>

    <!-- Scripts -->
    <script src="assets/js/jquery.min.js"></script>
    <script src="assets/js/main.js"></script>
    <script>
    <% String loginSuccess = request.getParameter("loginSuccess");
       String welcomeNick = request.getParameter("welcomeNick"); %>

    <% if ("1".equals(loginSuccess)) { %>
        alert("로그인에 성공하였습니다!");
    <% } else if (welcomeNick != null && !welcomeNick.isEmpty()) { %>
        alert("환영합니다, <%= welcomeNick %>님!");
    <% } %>

    // 주소창 파라미터 제거 (새로고침시 알림 안 뜨게)
    if (window.location.search.includes("loginSuccess") || window.location.search.includes("welcomeNick")) {
        const url = new URL(window.location.href);
        url.search = "";
        window.history.replaceState({}, document.title, url);
    }
    </script>
</body>
</html>
