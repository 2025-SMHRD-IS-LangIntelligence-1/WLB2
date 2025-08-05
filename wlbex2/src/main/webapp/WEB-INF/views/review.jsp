<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html lang="ko">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>커뮤니티</title>
    <style>
        html {
            overflow-y: scroll;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: sans-serif;
            background-color: rgb(255, 255, 255);
            color: white;
        }

        .main {
            width: 100%;
            max-width: 500px;
            margin: 0 auto;
        }

        .header {
            background-color: black;
            color: white;
            padding: 20px;
            text-align: center;
            font-size: 24px;
            font-weight: bold;
            border-bottom: 1px solid #444;
        }

        .tab-container {
            display: flex;
            margin-top: 10px;
            justify-content: center;
            background: none;
        }

        .tab {
            padding: 10px 20px;
            margin: 0 5px;
            background-color: #ffe5e5;
            border-radius: 10px 10px 0 0;
            color: #333;
            font-weight: bold;
            cursor: pointer;
        }

        .tab.active {
            background-color: #fd4c4c;
            color: white;
        }

        .post-list {
            background: white;
            color: black;
            padding: 20px;
            border-radius: 0 0 20px 20px;
            width: 90%;
            margin: 0 auto;
        }

        .post-list ul {
            list-style: none;
            padding: 0;
            margin: 0;
        }

        .post-list li {
            padding: 12px 10px;
            border-bottom: 1px solid #ccc;
            cursor: pointer;
            transition: color 0.3s;
        }

        .post-list li:hover {
            color: #fd4c4c;
        }

        .search-bar {
            margin: 20px auto 40px;
            display: flex;
            justify-content: center;
        }

        .search-bar input {
            width: 90%;
            padding: 10px;
            border-radius: 10px;
            border: 1px solid #ccc;
        }

        .bottom-nav {
            position: fixed;
            bottom: 0;
            left: 0;
            width: 100%;
            margin-left: 36.85%;
            max-width: 500px;
            background-color: #ffcccc;
            display: flex;
            justify-content: space-around;
            align-items: center;
            padding: 10px 0;
            border-top: 1px solid #ffcccc;
            z-index: 1000;
        }

        .bottom-nav a {
            text-decoration: none;
            color: #333;
            font-size: 14px;
            display: flex;
            flex-direction: column;
            align-items: center;
        }
    </style>
</head>

<body>
    <div class="main">
        <div class="header">커뮤니티</div>

        <div class="search-bar">
            <input type="text" placeholder="🔍 검색어를 입력하세요" />
        </div>

        <div class="post-list">
            <ul>
                <c:forEach var="review" items="${reviewList}">
                    <li onclick="goToPost('${review.review_title}')">
                        <strong>${review.user_id}</strong><br>
                        <span>${review.review_content}</span><br>
                        <small>${review.created_at}</small>
                    </li>
                </c:forEach>
            </ul>
        </div>
    </div>

    <!-- 하단 고정 내비게이션 -->
    <footer class="bottom-nav">
        <a href="main.html">🏠 <strong>홈</strong></a>
        <a href="">🎬 <strong>영화</strong></a>
        <a href="#">🍿 <strong>간식</strong></a>
        <a href="#">👤 <strong>내정보</strong></a>
    </footer>

    <script>
        function goToPost(title) {
            // JavaScript에서 URL 인코딩을 처리
            window.location.href = `post.html?title=${encodeURIComponent(title)}`;
        }
    </script>
</body>

</html>
