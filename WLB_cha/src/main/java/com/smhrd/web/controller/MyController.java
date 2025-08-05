package com.smhrd.web.controller;

import com.smhrd.web.entity.TbMember;
import com.smhrd.web.entity.TbReview;
import com.smhrd.web.mapper.MemberMapper;
import com.smhrd.web.mapper.ReviewMapper;
import com.smhrd.web.model.ReviewVO;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.ui.Model;

@Controller
public class MyController {

	private Logger logger = LoggerFactory.getLogger(getClass());

	@Autowired
	private MemberMapper memberMapper;

	@Autowired
	private ReviewMapper reviewmapper;

	// 메인 페이지
	@GetMapping("/")
	public String showMainPage() {
		return "main2";
	}

	@GetMapping("/login")
	public String ShowLoginPage(HttpSession session) {
		if (session.getAttribute("member") != null) {
			return "redirect:/main2";
		}
		return "login";
	}

	// 회원가입 폼 페이지
	@GetMapping("/register")
	public String showRegistrationForm() {
		return "register";
	}

	@GetMapping("/review")
	public String showReviewPage() {
		return "review";
	}

	@GetMapping("/main")
	public String showMain2Page() {
		return "main2";
	}

	@GetMapping("/community")
	public String showCommunityPage() {
		return "community";
	}

	// 회원가입 처리
	@PostMapping("/register")
	public String registerUser(TbMember member, Model model) {
		memberMapper.insert(member);
		System.out.println("회원가입 성공! 아이디: " + member.getUser_id());
		return "redirect:/";
	}

	// 아이디 중복 체크
	@GetMapping("/checkId")
	@ResponseBody
	public String checkId(@RequestParam("user_id") String user_id) {
		TbMember member = memberMapper.selectById(user_id);
		return (member != null) ? "exists" : "available";
	}

	
	@PostMapping("/login")
	@ResponseBody
	public Map<String, Object> login(@RequestParam String user_id, @RequestParam String user_pw, HttpSession session) {
		// DB에서 사용자 정보 확인
		TbMember member = memberMapper.login(new TbMember(user_id, user_pw));

		Map<String, Object> response = new HashMap<>();

		if (member != null) {
			session.setAttribute("member", member); // 로그인 성공 시 세션에 정보 저장
			response.put("success", true); // 성공
			 logger.info("✅ 로그인 성공 - 아이디: {}, 닉네임: {}", member.getUser_id(), member.getUser_nick());
			response.put("message", "로그인 성공"); // 로그인 성공 메시지 추가
		} else {
			response.put("success", false); // 실패
			response.put("message", "아이디 또는 비밀번호가 틀렸습니다."); // 로그인 실패 메시지 추가
		}

		return response; // JSON 응답 반환
	}

	@PostMapping("/insert")
	public String insertReview(@RequestParam String review_content) {
		// `review_content`만 받아서 insert 호출
		TbReview review = new TbReview();
		review.setReview_content(review_content);

		// MyBatis insert 호출
		reviewmapper.insert(review);

		return "redirect:/community"; // 리디렉션
	}

	

	// 로그아웃 처리 (알림 없음)
	@PostMapping("/logout")
	public String logout(HttpSession session) {
		logger.info("로그아웃 성공");
		
		session.invalidate();
		return "redirect:/";
	}

}
