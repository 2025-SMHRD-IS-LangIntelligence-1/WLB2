<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>감정별 영화 추천</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css">
</head>

<body>
    <div class="main">
        <header class="header">
            <img src = "${pageContext.request.contextPath}/resources/images/Lo.png" alt="로고" />
        </header>

        <!-- 메인 첫 홈페이지 -->
        <div class="mainimg">
            <img src="${pageContext.request.contextPath}/resources/images/home1.png" alt="메인 이미지" />
        </div>

        <!-- 메인 콘텐츠 시작 -->
        <div class="content">
            <div class="slogan">MAKE TODAY AMAZING!!</div>
            <div class="desc">오늘의 감정을 설문으로 분석하고<br>영화와 간식을 추천 받아보실래요?</div>

            <div class="btngroup">
                <button id="loginBtn" class="btn">로그인</button>
                <button id="test1Btn" class="btn">테스트하기</button>
            </div>

            <h2 class="emo_text">감정에 따른 영화 추천</h2>
            <p class = "hover-text">감정 소개</p>

            <div class="emotion-buttons">
                <button onclick="showMovies('happy')">😊 기쁨</button>
                <button onclick="showMovies('excitement')">😆 설렘</button>
                <button onclick="showMovies('neutral')">😐 보람</button>
            </div>
            <div class="emotion-buttons" style="margin-top: 3px;">
                <button onclick="showMovies('sad')">😢 슬픔</button>
                <button onclick="showMovies('stress')">😣 압박</button>
                <button onclick="showMovies('angry')">😡 분노</button>
            </div>
            <div class="movie-list" id="movieList"></div>

            <div class="btngroup">
                <a href="./review/review.html" class="btn" style="margin-top: 30px;">커뮤니티</a>
            </div>
        </div>
    </div>

    <!-- 로그인 모달 -->
    <div id="loginModal" class="login_modal">
        <div class="login_modal-content">
            <span class="close-login">&times;</span>
            <h2 style="margin-bottom: 30px;">로그인</h2>
            <input type="text" placeholder="아이디" /><br />
            <input type="password" placeholder="비밀번호" /><br />
            <button class="btn loginBtn" id="loginSubmitBtn" style="padding: 10px 155px;">로그인</button>
            <div style="margin-top: 10px">
                <button id="joinBtn" class="joinBut" style="padding: 10px 30px;">회원가입</button>
                <button id="findPwdBtn" class="joinBut" style="margin-left: 20px;">비밀번호 찾기</button>
            </div>
        </div>
    </div>

    <!-- 회원가입 모달 -->
    <div id="joinModal" class="join_modal">
        <div class="join_modal-content">
            <span class="close-join">&times;</span>
            <h2 style="margin-bottom: 30px">회원가입</h2>
            <input type="text" placeholder="아이디" /><br />
            <input type="password" placeholder="비밀번호" /><br />
            <input type="password" placeholder="비밀번호 확인" /><br />
            <input type="text" placeholder="닉네임" /><br />
            <input type="date" placeholder="생년월일" /><br />
            <select>
                <option value="" disabled selected >성별 선택</option>
                <option value="male">남성</option>
                <option value="female">여성</option>
            </select><br />
            <a>가입 버튼을 누르면 간단 설문에 참여합니다.</a>
            <button class="btn" id="joinSubmitBtn" style="padding : 10px 155px;">가입</button>
        </div>
    </div>

    <!-- 가입(설문) 모달 -->
    <div id="testModal" class="test_modal">
        <div class="test_modal-content">
            <span class="close-test">&times;</span>
            <h2 style="margin-bottom: 30px;">회원가입 설문 조사</h2>
            <div class="survey-box" style="text-align: center;">
                <div><a>간단 설문에 참여하시면 <br>사용자에게 더 <strong>정확한 추천</strong>이 됩니다.</a></div>
                <br>

                <div class="question" id="questionText" style="margin-bottom: 15px;">
                    Q1. 기분이 좋을 때 즐겨보는 장르는 무엇인가요?
                </div>
                <div class="options" id="optionsContainer">
                    <button>로맨스</button>
                    <button>공포</button>
                    <button>드라마</button>
                    <button>액션</button>
                </div>
                <button class="btn" id="nextBtn" style="padding : 10px 155px;">1/6</button>
            </div>
        </div>
    </div>

    <!-- 감정 테스트 모달 -->
    <div id="test1Modal" class="test1_modal">
        <div class="test1_modal-content">
            <span class="close close-test1">&times;</span>
            <h2 style="margin-bottom: 20px;">감정 테스트</h2>

            <div id="step1">
                <div class="gauge-container">
                    <div class="gauge-bar" id="gaugeBar">
                        <div class="gauge-fill" id="gaugeFill"></div>
                    </div>
                    <div class="gauge-labels" id="gaugeLabels">
                        <span data-value="0">0%<br>분노</span>
                        <span data-value="20">20%<br>슬픔</span>
                        <span data-value="40">40%<br>압박</span>
                        <span data-value="60">60%<br>보람</span>
                        <span data-value="80">80%<br>설렘</span>
                        <span data-value="100">100%<br>기쁨</span>
                    </div>
                    <div class="selected-value" id="selectedValue">오늘의 기분: 선택 안됨</div>
                </div>
                <button id="toStep2Btn" class="btn" disabled style="margin-top: 20px;">다음</button>
            </div>

            <div id="step2" style="display:none; width: 100%;">
                <div id="questionContainer"
                    style="text-align: center; font-size: 20px; margin-bottom: 40px; margin-top: 70px;"></div>
                <div id="labelContainer">
                    <button id="yesBtn" class="select-button" type="button">네</button>
                    <button id="noBtn" class="select-button" type="button">아니오</button>
                </div>
                <button id="submitSurveyBtn" class="btn" style="margin-top: 20px;" disabled>다음</button>
            </div>
        </div>
    </div>

    <!-- 하단 메뉴 바 -->
    <footer class="bottom-nav">
        <a href="#" style="color: #fd4c4c;">🏠 <strong>홈</strong></a>
        <a href="#">🎬 <strong>영화</strong></a>
        <a href="#">🍿 <strong>간식</strong></a>
        <a href="./my/mypage.html">👤 <strong>내정보</strong></a>
    </footer>
    
    <script>
    	const ctx = "${pageContext.request.contextPath}"
    </script>

    <script src="${pageContext.request.contextPath}/resources/js/script.js"></script>
</body>

</html>