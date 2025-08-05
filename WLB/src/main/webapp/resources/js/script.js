// (1) 상단 이미지 자동 전환
const mainImages = [`${ctx}/resources/images/전지적독자시점.png`,
	 `${ctx}/resources/images/노이즈.png`,
 `${ctx}/resources/images/파묘.png`,
 `${ctx}/resources/images/F1.png`
 ];
 
let currentIndex = 0;

function changeMainImage() {
  const mainImg = document.querySelector('.mainimg img');
  mainImg.style.opacity = 0;

  setTimeout(() => {
    currentIndex = (currentIndex + 1) % mainImages.length;
    mainImg.src = mainImages[currentIndex];
    mainImg.style.opacity = 1;
  }, 500);
}

setInterval(changeMainImage, 8000);

// (2) 감정별 영화 보여주기
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
  sad: [ // 이미지 경로는 아래 경로와 같이
    { title: "타이타닉", img: `${ctx}/resources/images/titanic.jfif`, rating: "⭐9.89" },
    { title: "감기", img: `${ctx}/resources/images/cold.jfif`, rating: "⭐6.92" },
    { title: "7번방의 선물", img: `${ctx}/resources/images/7.jfif`, rating: "⭐8.83" },
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

// (3) 모달 관련
const loginModal = document.getElementById("loginModal");
const joinModal = document.getElementById("joinModal");
const testModal = document.getElementById("testModal");
const testModal1 = document.getElementById("test1Modal");

const loginBtn = document.getElementById("loginBtn");
const joinBtn = document.getElementById("joinBtn");
const joinSubmitBtn = document.getElementById("joinSubmitBtn");
const test1Btn = document.getElementById("test1Btn");

const closeLogin = document.querySelector(".close-login");
const closeJoin = document.querySelector(".close-join");
const closeTest = document.querySelector(".close-test");
const closeTest1 = document.querySelector(".close-test1");

let scrollPosition = 0;

function openModal(modal) {
  scrollPosition = window.scrollY || window.pageYOffset;
  const scrollBarWidth = window.innerWidth - document.documentElement.clientWidth;

  document.body.style.position = 'fixed';
  document.body.style.top = `-${scrollPosition}px`;
  document.body.style.width = '100%';
  document.body.style.overflow = 'hidden';
  document.body.style.paddingRight = `${scrollBarWidth}px`;
  document.body.classList.add('modal-open');

  modal.style.display = "block";
}

function closeModal(modal) {
  modal.style.display = "none";
  document.body.style.position = '';
  document.body.style.top = '';
  document.body.style.width = '';
  document.body.style.overflow = '';
  document.body.style.paddingRight = '';
  document.body.classList.remove('modal-open');
  window.scrollTo(0, scrollPosition);
}

function closeAllModals() {
  [loginModal, joinModal, testModal].forEach(m => m.style.display = "none");
  document.body.classList.remove("modal-open");
  window.scrollTo(0, scrollPosition);
}

loginBtn.onclick = () => {
  closeAllModals();
  openModal(loginModal);
};
joinBtn.onclick = () => {
  closeAllModals();
  openModal(joinModal);
};
joinSubmitBtn.onclick = () => {
  closeAllModals();
  openModal(testModal);
};
test1Btn.onclick = () => {
  closeAllModals();
  openModal(testModal1);
};

closeLogin.onclick = () => closeModal(loginModal);
closeJoin.onclick = () => closeModal(joinModal);
closeTest.onclick = () => closeModal(testModal);
closeTest1.onclick = () => closeModal(testModal1);

window.onclick = (event) => {
  if (event.target === loginModal) closeModal(loginModal);
  if (event.target === joinModal) closeModal(joinModal);
  if (event.target === testModal) closeModal(testModal);
  if (event.target === testModal1) closeModal(testModal1);
};

// (4) 회원가입 설문
const surveyData = [
  { question: "Q1. 기분이 좋을 때 즐겨보는 장르는 무엇인가요?", options: ["로맨스", "공포", "드라마", "액션"] },
  { question: "Q2. 스트레스를 날리기 위해 즐겨보는 장르는 무엇인가요?", options: ["로맨스", "공포", "드라마", "액션"] },
  { question: "Q3. 슬픔과 감정 이입이 심할 때 즐겨보는 장르는 무엇인가요?", options: ["로맨스", "공포", "드라마", "액션"] },
  { question: "Q4. 감정이 격해질 때, 어떤 장르를 보며 가라앉히시나요?", options: ["로맨스", "공포", "드라마", "액션"] },
  { question: "Q5. 설레는 기분이거나 두근두근할 때 선호하는 장르는?", options: ["로맨스", "공포", "드라마", "액션"] },
  { question: "Q6. 인생의 의미를 다시 떠올리고 싶을 때는?", options: ["로맨스", "공포", "드라마", "액션"] },
];

let currentStep = 0;
let answers = [];

const questionText = document.getElementById('questionText');
const optionsContainer = document.getElementById('optionsContainer');
const nextBtn = document.getElementById('nextBtn');

optionsContainer.addEventListener('click', (e) => {
  if (e.target.tagName !== 'BUTTON') return;
  optionsContainer.querySelectorAll('button').forEach(btn => btn.classList.remove('selected'));
  e.target.classList.add('selected');
});

nextBtn.addEventListener('click', () => {
  const selectedBtn = optionsContainer.querySelector('button.selected');
  if (!selectedBtn) return alert('장르를 선택해주세요!');
  answers[currentStep] = selectedBtn.textContent.trim();

  if (++currentStep < surveyData.length) {
    updateSurvey(currentStep);
  } else {
    fetch("/survey/save", {
      method: "POST",
      headers: {
        "Content-Type": "application/json"
      },
      body: JSON.stringify({
        userId: "testUser",
        answers: answers
      })
    })
      .then(res => res.text())
      .then(msg => {
        alert("설문이 저장되었습니다!");
        closeModal(testModal);
        resetSurvey();
      })
      .catch(err => console.error(err));
  }
});

function updateSurvey(step) {
  questionText.textContent = surveyData[step].question;
  optionsContainer.innerHTML = '';
  surveyData[step].options.forEach(opt => {
    const btn = document.createElement('button');
    btn.textContent = opt;
    optionsContainer.appendChild(btn);
  });
  if (answers[step]) {
    const btn = [...optionsContainer.children].find(b => b.textContent === answers[step]);
    btn?.classList.add('selected');
  }
  nextBtn.textContent = step === surveyData.length - 1 ? '제출' : `${step + 1}/${surveyData.length}`;
}

function resetSurvey() {
  currentStep = 0;
  answers = [];
  updateSurvey(0);
}
updateSurvey(0);

// (5) 감정 테스트 모달 질문
const gaugeFill = document.getElementById('gaugeFill');
const selectedValue = document.getElementById('selectedValue');
const labels = document.querySelectorAll('#test1Modal .gauge-labels span');
const toStep2Btn = document.getElementById('toStep2Btn');
const step1 = document.getElementById('step1');
const step2 = document.getElementById('step2');
const questionContainer = document.getElementById('questionContainer');
const submitSurveyBtn = document.getElementById('submitSurveyBtn');

let selectedValuePercent = null;
let currentQuestionIndex = 0;
let answersMBTI = [];

const yesBtn = document.getElementById('yesBtn');
const noBtn = document.getElementById('noBtn');

const questionsByEmotionMBTI = {
  0: ["분노가 치밀 때 나는 감정을 쉽게 제어할 수 있다.", "분노가 치밀 때도 침착함을 유지한다."],
  20: ["슬플 때 나는 주변 사람들과 대화를 많이 한다.", "슬픔을 느낄 때 주로 혼자만의 시간을 갖는다."],
  40: ["스트레스를 받을 때 나는 운동이나 활동으로 해소한다.", "압박감을 느낄 때 휴식을 취하는 편이다."],
  60: ["보람을 느낄 때 나는 내 성취를 자주 돌아본다.", "보람찬 순간을 기억하는 것이 내게 힘이 된다."],
  80: ["설렘이 가득할 때 나는 새로운 도전을 즐긴다.", "설렘을 더 크게 만드는 것은 나에게 큰 동기부여가 된다."],
  100: ["기쁨을 느낄 때 가장 먼저 주변 사람들과 나눈다.", "기쁨을 나누고 싶은 사람이 내 인생에서 중요하다."],
};

labels.forEach(label => {
  label.addEventListener('click', () => {
    selectedValuePercent = label.getAttribute('data-value');
    gaugeFill.style.width = selectedValuePercent + '%';
    selectedValue.textContent = `오늘의 기분: ${selectedValuePercent}%`;
    toStep2Btn.disabled = false;
  });
});

toStep2Btn.addEventListener('click', () => {
  if (!selectedValuePercent) return;
  step1.style.display = 'none';
  step2.style.display = 'block';
  currentQuestionIndex = 0;
  answersMBTI = [];
  showQuestion(currentQuestionIndex);
});

yesBtn.addEventListener('click', () => {
  yesBtn.classList.add('selected');
  noBtn.classList.remove('selected');
  answersMBTI[currentQuestionIndex] = '1';
  submitSurveyBtn.disabled = false;
});

noBtn.addEventListener('click', () => {
  noBtn.classList.add('selected');
  yesBtn.classList.remove('selected');
  answersMBTI[currentQuestionIndex] = '2';
  submitSurveyBtn.disabled = false;
});

function showQuestion(index) {
  const qs = questionsByEmotionMBTI[selectedValuePercent];
  questionContainer.innerHTML = '';
  const p = document.createElement('p');
  p.textContent = qs[index];
  questionContainer.appendChild(p);

  submitSurveyBtn.disabled = true;
  yesBtn.classList.remove('selected');
  noBtn.classList.remove('selected');

  if (answersMBTI[index] === '1') yesBtn.classList.add('selected');
  if (answersMBTI[index] === '2') noBtn.classList.add('selected');

  submitSurveyBtn.textContent = index === qs.length - 1 ? '제출' : '다음';
}

submitSurveyBtn.addEventListener('click', () => {
  if (!document.querySelector('.select-button.selected')) {
    alert('답변을 선택해주세요!');
    return;
  }

  answersMBTI[currentQuestionIndex] = yesBtn.classList.contains('selected') ? '1' : '2';
  currentQuestionIndex++;
  const qs = questionsByEmotionMBTI[selectedValuePercent];

  if (currentQuestionIndex < qs.length) {
    showQuestion(currentQuestionIndex);
  } else {
    fetch("/survey/mbti", {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({
        userId: "testUser",  // 실제 로그인한 사용자 ID
        moodPercent: selectedValuePercent,
        answers: answersMBTI
      })
    })
      .then(res => res.text())
      .then(msg => {
        alert("MBTI 설문 저장 완료!");
      })
      .catch(err => console.error(err));

    closeModal(testModal1);
    step2.style.display = 'none';
    step1.style.display = 'block';
    toStep2Btn.disabled = true;
    gaugeFill.style.width = '0';
    selectedValue.textContent = '오늘의 기분: 선택 안됨';
    selectedValuePercent = null;
    answersMBTI = [];
    currentQuestionIndex = 0;
    submitSurveyBtn.textContent = '제출';
  }
});
