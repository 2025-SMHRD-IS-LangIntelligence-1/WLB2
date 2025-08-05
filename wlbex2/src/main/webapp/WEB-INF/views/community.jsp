<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html lang="ko">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>커뮤니티</title>
<style>
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
	height: 900px;
	max-width: 500px;
	margin: 0 auto;
	background-color: #333;
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

.review-bar {
	width: 90%;
	height: 300px;
	resize: none;
	border-radius: 10px;
	border: 1px solid #ccc;
	padding: 10px;
	box-sizing: border-box;
	margin-left: 25px;
}

.bottom-nav {
	position: fixed;
	bottom: 0;
	left: 0;
	width: 100%;
	margin-left: 36.9%;
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
		<div class="tab-container">
			<div class="tab active" onclick="switchTab('free')">자유</div>
			<div class="tab" onclick="switchTab('review')">후기</div>
		</div>

		<div class="post-list" id="freeTab">
			<!-- Spring에서 구현하기 -->
			<ul>
				<li onclick="goToPost('게시물1')">게시물1</li>
				<li onclick="goToPost('게시물2')">게시물2</li>
				<li onclick="goToPost('게시물3')">게시물3</li>
				<li onclick="goToPost('게시물4')">게시물4</li>
				<li onclick="goToPost('게시물5')">게시물5</li>
				<li onclick="goToPost('게시물6')">게시물6</li>
			</ul>
		</div>

		<div class="post-list" id="reviewTab" style="display: none;">
			<ul>
				<li onclick="goToPost('후기1')">후기1</li>
				<li onclick="goToPost('후기2')">후기2</li>
				<li onclick="goToPost('후기3')">후기3</li>
				<li onclick="goToPost('후기4')">후기4</li>
				<li onclick="goToPost('후기5')">후기5</li>
				<li onclick="goToPost('후기6')">후기6</li>
			</ul>
		</div>
		<div class="search-bar">
			<input type="text" placeholder="🔍 검색어를 입력하세요" />
		</div>
		<tr>
		<tr>
			<form action="insert" method="post">
				<textarea class="review-bar" rows="10" name="review_content">
				</textarea>
				<button type="submit">등록</button>
			</form>

		</tr>

		</tr>


	</div>

	<!-- 하단 고정 내비게이션 -->
	<footer class="bottom-nav">
		<a href="main">🏠 <strong>홈</strong></a> <a href="">🎬 <strong>영화</strong></a>
		<a href="#">🍿 <strong>간식</strong></a> <a href="#">👤 <strong>내정보</strong></a>
	</footer>

	<script>
        function switchTab(tab) {
            document.querySelectorAll('.tab').forEach(t => t.classList.remove('active'));
            document.querySelectorAll('.post-list').forEach(p => p.style.display = 'none');

            if (tab === 'free') {
                document.querySelector('.tab:nth-child(1)').classList.add('active');
                document.getElementById('freeTab').style.display = 'block';
            } else {
                document.querySelector('.tab:nth-child(2)').classList.add('active');
                document.getElementById('reviewTab').style.display = 'block';
            }
        }

        function goToPost(title) {
        	 window.location.href = "post.html?title=" + encodeURIComponent(title);
        }
    </script>
</body>

</html>