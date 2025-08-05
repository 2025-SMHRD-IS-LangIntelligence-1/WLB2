<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<html lang="ko">

<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>감정별 영화 추천</title>
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
	width: 500px;
	margin: 0 auto;
	overflow-x: hidden;
}

.mainimg {
	position: relative;
	height: 70vh;
}

.mainimg img {
	width: 100%;
	height: 100%;
	object-fit: cover;
	transition: opacity 1s ease-in-out;
	opacity: 1;
}

.maintext {
	position: absolute;
	top: 5%;
	width: 100%;
	text-align: left;
	color: #fd4c4c;
	font-size: 24px;
	font-weight: bold;
	margin-left: 10px;
}

.subtext {
	position: absolute;
	bottom: 50px;
	width: 100%;
	text-align: right;
	color: #fd4c4c;
	font-size: 24px;
	font-weight: bold;
	margin-left: -10px;
}

.header {
	background-color: rgb(0, 0, 0);
}

.content {
	background-color: rgb(0, 0, 0);
	padding: 20px 10px 100px;
	text-align: center;
}

.titleimg {
	width: 80%;
	margin-bottom: 10px;
}

.slogan {
	color: #ffcccc;
	font-size: 22px;
	font-weight: bold;
	margin-bottom: 15px;
}

.desc {
	font-size: 15px;
	margin-bottom: 20px;
	color: #ccc;
}

.btngroup {
	display: flex;
	justify-content: center;
	gap: 16px;
	margin-bottom: 20px;
}

.btn {
	padding: 10px 20px;
	background-color: #ffcccc;
	border: none;
	border-radius: 20px;
	font-weight: bold;
	cursor: pointer;
	text-decoration: none;
	color: black;
}

.loginBtn {
	padding: 100px 20px;
}

.joinBut {
	padding: 10px 20px;
	background-color: #e9dce4;
	border: none;
	border-radius: 20px;
	font-weight: bold;
	cursor: pointer;
	text-decoration: none;
	color: black;
}

.emo_text {
	margin-bottom: 25px;
}

.emotionbtns {
	display: flex;
	flex-wrap: wrap;
	justify-content: center;
	gap: 10px;
	margin: 20px 0;
}

.emotion-buttons button {
	padding: 10px 20px;
	border-radius: 20px;
	border: 5px solid #ffcccc;
	background-color: #fff;
	color: #333;
	cursor: pointer;
	transition: background-color 0.3s;
	margin-bottom: 10px;
}

.emotion-buttons button:hover {
	background-color: #ffcb05;
	color: #fff;
}

.movie-list {
	display: flex;
	flex-wrap: wrap;
	gap: 20px;
	justify-content: center;
}

.movie-card {
	width: 200px;
	border: 1px solid #ddd;
	border-radius: 10px;
	overflow: hidden;
	background-color: #fff;
	box-shadow: 0 2px 6px rgba(0, 0, 0, 0.1);
	color: black;
}

.movie-card img {
	width: 100%;
	height: 280px;
	object-fit: cover;
}

.movie-card .info {
	padding: 10px;
}

.movie-card .info h3 {
	font-size: 18px;
	margin-bottom: 5px;
}

.movie-card .info p {
	font-size: 14px;
	color: #555;
}

.login_modal, .join_modal, .test_modal {
	display: none;
	position: fixed;
	z-index: 999;
	left: 0;
	top: 0;
	width: 100%;
	height: 100%;
	overflow: auto;
	background-color: rgba(0, 0, 0, 0.6);
}

.login_modal-content, .join_modal-content, .test_modal-content {
	background-color: white;
	margin: 15% auto;
	padding: 30px;
	border-radius: 15px;
	width: 450px;
	text-align: center;
	color: black;
	position: relative;
}

.login_modal-content input, .join_modal-content input,
	.test_modal-content input {
	width: 90%;
	padding: 8px;
	margin-bottom: 10px;
	border-radius: 8px;
	border: 1px solid #ccc;
}

.close-login, .close-join, .close-test {
	position: absolute;
	top: 10px;
	right: 15px;
	font-size: 25px;
	cursor: pointer;
}

.survey-box {
	background-color: white;
	padding: 20px;
	border-radius: 20px;
	color: black;
	width: 90%;
	max-width: 500px;
}

.survey-box h3 {
	font-size: 15px;
	margin-bottom: 5px;
}

.survey-box .options {
	display: flex;
	flex-wrap: wrap;
	justify-content: center;
	gap: 10px;
	margin-bottom: 15px;
	text-align: center;
}

.survey-box .options button {
	padding: 8px 16px;
	border: 1px solid #aaa;
	border-radius: 20px;
	background-color: #f7f7f7;
	cursor: pointer;
}

.survey-box .options button:hover {
	background-color: #ffcccc;
}

.survey-box .submit-btn {
	background-color: #ffcccc;
	padding: 10px 30px;
	border-radius: 20px;
	border: none;
	font-weight: bold;
	cursor: pointer;
}

button.selected {
	background-color: #ffcccc;
	color: rgb(0, 0, 0);
}

body.modal-open {
	overflow: hidden;
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
		<header class="header">
			<h1 style="margin-left: 10px;">MovieSnack!</h1>
		</header>

		<!-- 메인 첫 홈페이지 -->
		<div class="mainimg">
			<!-- 	<img src="./home1.png" alt="메인 이미지" /> -->
		</div>

		<!-- 메인 콘텐츠 시작 -->
		<div class="content">
			<div class="slogan">MAKE TODAY AMAZING!!</div>
			<div class="desc">
				오늘의 감정을 설문으로 분석하고<br>영화와 간식을 추천 받아보실래요?
			</div>

			<div class="btngroup">
				<c:choose>
					<c:when test="${empty sessionScope.member}">
						<button id="loginBtn" class="btn">로그인</button>
					</c:when>
					<c:otherwise>
						<form action="/web/logout" method="post" style="display: inline;">
							<button type="submit" class="btn">로그아웃</button>
						</form>
					</c:otherwise>
				</c:choose>
				<a href="/test" class="btn">테스트하기</a> <a href="community"
					class="btn">커뮤니티</a>
			</div>

			<h2 class="emo_text">감정에 따른 영화 추천</h2>

			<div class="emotion-buttons">
				<button onclick="showMovies('happy')">😊 기쁨</button>
				<button onclick="showMovies('excitement')">😆 설렘</button>
				<button onclick="showMovies('neutral')">😐 보람</button>
			</div>
			<div class="emotion-buttons">
				<button onclick="showMovies('sad')">😢 슬픔</button>
				<button onclick="showMovies('stress')">😣 스트레스</button>
				<button onclick="showMovies('angry')">😡 분노</button>
			</div>

			<div class="movie-list" id="movieList"></div>
		</div>
	</div>

	<!-- 로그인 모달 -->
	<div id="loginModal" class="login_modal">
		<div class="login_modal-content">
			<span class="close-login">&times;</span>
			<h2 style="margin-bottom: 30px;">로그인</h2>

			<input id="user_id" type="text" name="user_id" placeholder="아이디" /><br />
			<input id="user_pw" type="password" name="user_pw" placeholder="비밀번호" /><br />


			<div class="btn-group">
				<input type="submit" id="loginSubmitBtn" value="로그인">
			</div>


			<div style="margin-top: 10px">
				<button id="joinBtn" class="joinBut" style="padding: 10px 30px;">회원가입</button>
				<button id="joinBtn" class="joinBut" style="margin-left: 20px;";>
					비밀번호 찾기</a>
			</div>
		</div>
	</div>

	<!-- 회원가입 모달 -->
	<div id="joinModal" class="join_modal">
		<div class="join_modal-content">
			<span class="close-join">&times;</span>
			<h2 style="margin-bottom: 30px;">회원가입</h2>
			<form action="${pageContext.request.contextPath}/register"
				method="post">

				<!-- 아이디 + 중복체크 -->
				<div style="margin-bottom: 15px; text-align: left;">
					<label for="user_id">아이디</label>
					<div style="display: flex; gap: 5px;">
						<input type="text" name="join_user_id" id="join_user_id"
							placeholder="아이디를 입력하세요" style="flex: 1;" required />
						<button type="button" id="checkIdBtn"
							style="background-color: #ffcccc; border: none; padding: 5px 10px; border-radius: 8px; cursor: pointer;">중복체크</button>
					</div>
					<div id="checkIdResult" style="font-size: 13px; margin-top: 5px; height: 20px;"></div>
				</div>

				<!-- 비밀번호 -->
				<div style="margin-bottom: 15px; text-align: left;">
					<label for="user_pw">비밀번호</label> <input type="password"
						name="join_user_pw" id="join_user_pw" placeholder="비밀번호를 입력하세요"
						style="width: 100%;" required />
				</div>

				<!-- 비밀번호 확인 -->
				<div style="margin-bottom: 15px; text-align: left;">
					<label for="user_pw_check">비밀번호 확인</label> <input type="password"
						id="user_pw_check" placeholder="비밀번호를 다시 입력하세요"
						style="width: 100%;" required />
				</div>

				<!-- 닉네임 -->
				<div style="margin-bottom: 15px; text-align: left;">
					<label for="user_nick">닉네임</label> <input type="text"
						name="user_nick" id="user_nick" placeholder="닉네임을 입력하세요"
						style="width: 100%;" required />
				</div>

				<!-- 생일 -->
				<div style="margin-bottom: 15px; text-align: left;">
					<label for="user_birthdate">생일</label> <input type="date"
						name="user_birthdate" id="user_birthdate" required
						min="1900-01-01" max="2025-12-31" style="width: 100%;" />
				</div>

				<!-- 성별 -->
				<div style="margin-bottom: 25px; text-align: left;">
					<label for="user_gender">성별</label> <select name="user_gender"
						id="user_gender" style="width: 100%;">
						<option value="M">남성</option>
						<option value="F">여성</option>
					</select>
				</div>

				<!-- 회원가입 버튼 -->
				<input type="submit" value="회원가입"
					style="width: 100%; padding: 10px; background-color: #ffcccc; border: none; border-radius: 20px; font-weight: bold; cursor: pointer;" />
			</form>
		</div>
	</div>


	<!-- 가입(설문) 모달 -->
	<div id="testModal" class="test_modal">
		<div class="test_modal-content">
			<span class="close-test">&times;</span>
			<h2 style="margin-bottom: 5px;">회원가입 설문 조사</h2>
			<div class="survey-box">
				<div>
					<a>간단 설문에 참여하시면 <br>사용자에게 더 <strong>정확한 추천</strong>이 됩니다.
					</a>
				</div>
				<br>

				<div class="question" style="margin-bottom: 15px;">기분이 좋을 때
					즐겨보는 장르는 무엇인가요?</div>
				<div class="options">
					<button>로맨스</button>
					<button>공포</button>
					<button>드라마</button>
					<button>액션</button>
				</div>

				<div class="question" style="margin-bottom: 15px;">스트레스를 날리기
					위해 즐겨보는 장르는 무엇인가요?</div>
				<div class="options">
					<button>로맨스</button>
					<button>공포</button>
					<button>드라마</button>
					<button>액션</button>
				</div>

				<div class="question" style="margin-bottom: 15px;">슬픔과 감정 이입이
					심할 때 즐겨보는 장르는 무엇인가요?</div>
				<div class="options">
					<button>로맨스</button>
					<button>공포</button>
					<button>드라마</button>
					<button>액션</button>
				</div>

				<div class="question" style="margin-bottom: 15px;">감정이 격해질 때,
					어떤 장르를 보며 가라앉히시나요?</div>
				<div class="options">
					<button>로맨스</button>
					<button>공포</button>
					<button>드라마</button>
					<button>액션</button>
				</div>

				<div class="question" style="margin-bottom: 15px;">설레는 기분이거나
					두근두근한 감정이 들 때, 어떤 장르를 선호하시나요?</div>
				<div class="options">
					<button>로맨스</button>
					<button>공포</button>
					<button>드라마</button>
					<button>액션</button>
				</div>

				<div class="question" style="margin-bottom: 15px;">인생의 의미를 다시
					떠오르고 싶을 때 어떤 장르를 찾게 되시나요?</div>
				<div class="options">
					<button>로맨스</button>
					<button>공포</button>
					<button>드라마</button>
					<button>액션</button>
				</div>

				<button class="btn" id="surveySubmitBtn" style="margin-top: 15px;">설문
					제출</button>
			</div>
		</div>
	</div>

	<!-- 하단 메뉴 바 -->
	<footer class="bottom-nav">
		<a href="#">🏠 <strong>홈</strong></a> <a href="#">🎬 <strong>영화</strong></a>
		<a href="#">🍿 <strong>간식</strong></a> <a href="#">👤 <strong>내정보</strong></a>
	</footer>

	<script>
        const movieData = {
            happy: [
                { title: "코코", img: "images/happy1.jpg", rating: 9.2 },
                { title: "업", img: "images/happy2.jpg", rating: 8.7 },
            ],
            excitement: [
                { title: "라라랜드", img: "images/excite1.jpg", rating: 8.0 },
                { title: "어벤져스", img: "images/excite2.jpg", rating: 8.5 },
            ],
            neutral: [
                { title: "월터의 상상은 현실이 된다", img: "images/calm1.jpg", rating: 8.1 },
                { title: "빅 피쉬", img: "images/calm2.jpg", rating: 7.9 },
            ],
            sad: [
                { title: "타이타닉", img: "./타이타닉.jfif", rating: "⭐9.89" },
                { title: "감기", img: "./감기.jfif", rating: "⭐6.92" },
                { title: "7번방의 선물", img: "./7번방의선물.jfif", rating: "⭐8.83" },
            ],
            stress: [
                { title: "인셉션", img: "images/stress1.jpg", rating: 8.8 },
                { title: "매트릭스", img: "images/stress2.jpg", rating: 8.7 },
            ],
            angry: [
                { title: "존 윅", img: "images/angry1.jpg", rating: 8.1 },
                { title: "베놈", img: "images/angry2.jpg", rating: 7.4 },
            ],
        };

       // const mainImages = [
        //    './home1.png', // 추후 수정 예정
         //   './home2.png', // 추후 수정 예정
          //  './home3.png', // 추후 수정 예정
        //];

        let currentIndex = 0;

        /* function changeMainImage() {
            const mainImg = document.querySelector('.mainimg img');


            mainImg.style.opacity = 0;

            setTimeout(() => {

                currentIndex = (currentIndex + 1) % mainImages.length;
                mainImg.src = mainImages[currentIndex];

                mainImg.style.opacity = 1;
            }, 500);
        }*/
        // setInterval(changeMainImage, 8000);

        function showMovies(emotion) {
            const movieList = document.getElementById("movieList");
            movieList.innerHTML = "";

            if (!movieData[emotion]) return;

            movieData[emotion].forEach((movie) => {
                const card = document.createElement("div");
                card.className = "movie-card";
                card.innerHTML = `
                                        <img src="${movie.img}" alt="${movie.title}" />
                                        <div class="info">
                                        <h3>${movie.title}</h3>
                                        <p>평점: ${movie.rating}</p>
                                        </div>
                                        `;
                movieList.appendChild(card);
            });
        }

     // 모달 요소
        const loginModal = document.getElementById("loginModal");
        const joinModal = document.getElementById("joinModal");
        const testModal = document.getElementById("testModal");

        // 버튼 요소
        const loginBtn = document.getElementById("loginBtn");               // 메인 페이지 로그인 버튼
        const loginSubmitBtn = document.getElementById("loginSubmitBtn");   // 모달 안 로그인 버튼
        const joinBtn = document.getElementById("joinBtn");
        const joinSubmitBtn = document.getElementById("joinSubmitBtn");
        const surveySubmitBtn = document.getElementById("surveySubmitBtn");

        // 닫기 버튼
        const closeLogin = document.querySelector(".close-login");
        const closeJoin = document.querySelector(".close-join");
        const closeTest = document.querySelector(".close-test");

        // 모달 열고 닫기
        loginBtn.onclick = () => {
            closeAllModals();
            document.body.classList.add("modal-open");
            loginModal.style.display = "block";
        };

        closeLogin.onclick = () => {
            loginModal.style.display = "none";
            document.body.classList.remove("modal-open");
        };

        joinBtn.onclick = () => {
            closeAllModals();
            document.body.classList.add("modal-open");
            joinModal.style.display = "block";
        };

        closeJoin.onclick = () => {
            joinModal.style.display = "none";
            document.body.classList.remove("modal-open");
        };

        joinSubmitBtn.onclick = () => {
            closeAllModals();
            document.body.classList.add("modal-open");
            testModal.style.display = "block";
        };

        closeTest.onclick = () => {
            testModal.style.display = "none";
            document.body.classList.remove("modal-open");
        };

        // 모달 바깥 클릭 시 닫기
        window.onclick = (event) => {
            if (event.target === loginModal || event.target === joinModal || event.target === testModal) {
                closeAllModals();
                document.body.classList.remove("modal-open");
            }
        };

        // 모달 전체 닫기 함수
        function closeAllModals() {
            loginModal.style.display = "none";
            joinModal.style.display = "none";
            testModal.style.display = "none";
        }

     // 실제 로그인 fetch 요청 (모달 안 로그인 버튼 클릭 시)
        loginSubmitBtn.addEventListener('click', function(e) {
            console.log("로그인 버튼 클릭됨!");

            const user_id = document.getElementById('user_id').value;
            const user_pw = document.getElementById('user_pw').value;

            console.log('보낼 데이터:', { user_id, user_pw });
            e.preventDefault();
            fetch('/web/login', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded'
                },
                body: "user_id=" + encodeURIComponent(user_id) + "&user_pw=" + encodeURIComponent(user_pw),
                credentials: 'include' // 세션 사용 시
            })
            .then(response => {
                console.log('서버 응답 상태:', response.status);
                if (!response.ok) {
                    throw new Error('HTTP 오류! 상태코드: ' + response.status);
                }
                return response.json(); // 서버가 JSON 응답할 경우
            })
            .then(data => {
                if (data.success) {
                	 window.location.href = '/web/main'; 
                } else {
                    alert("로그인 실패: " + data.message);
                }
            })
            .catch(error => {
                console.error("에러 발생:", error);
            });

       
        });


        // 설문 제출 버튼 클릭 시 모든 질문 확인
        surveySubmitBtn.onclick = () => {
            const answers = [];
            let allAnswered = true;

            document.querySelectorAll('.survey-box .options').forEach((group) => {
                const selected = group.querySelector('button.selected');
                if (selected) {
                    answers.push(selected.textContent.trim());
                } else {
                    allAnswered = false;
                }
            });

            if (!allAnswered) {
                alert("모든 문항에 답해주세요!");
                return;
            }

            console.log("설문 응답 결과:", answers);
            alert("설문 제출 완료!");
            testModal.style.display = "none";
            document.body.classList.remove("modal-open");
        };

        // 버튼 선택 유지
        document.querySelectorAll('.survey-box .options').forEach(group => {
            const buttons = group.querySelectorAll('button');
            buttons.forEach(button => {
                button.addEventListener('click', () => {
                    buttons.forEach(btn => btn.classList.remove('selected'));
                    button.classList.add('selected');
                });
            });
        });
        
        let isIdChecked = false;

        $("#checkIdBtn").click(function () {
            let userId = $("#join_user_id").val().trim();

            if (userId === "") {
                alert("아이디를 입력하세요!");
                return;
            }

            $.ajax({
                url: "/web/checkId",
                type: "GET",
                data: { user_id: userId },
                success: function (result) {
                    if (result === "exists") {
                        isIdChecked = false;
                        $("#checkIdResult").text("이미 사용 중인 아이디입니다.").css("color", "red");
                    } else if (result === "available") {
                        isIdChecked = true;
                        $("#checkIdResult").text("사용 가능한 아이디입니다!").css("color", "green");
                    }
                },
                error: function () {
                    alert("서버 요청 실패");
                }
            });
        });

       

    </script>
</body>

</html>