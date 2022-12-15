package com.gdu.smore.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.gdu.smore.service.UserService;

@Controller
public class UserController {

	@Autowired
	private UserService userService;

	// 약관 동의
	@GetMapping("/user/agree/form")
	public String agreeForm() {
		return "user/agree";
	}
	
	@GetMapping("/user/join/write")
	public String joinWrite(@RequestParam(required=false) String location
						  , @RequestParam(required=false) String promotion
						  , Model model) {
		model.addAttribute("location", location);
		model.addAttribute("promotion", promotion);
		return "user/join";
	}
	
	@ResponseBody
	@GetMapping(value="/user/checkReduceId", produces=MediaType.APPLICATION_JSON_VALUE)
	public Map<String, Object> checkReduceId(String id){
		return userService.isReduceId(id);
	}
	
	@ResponseBody
	@GetMapping(value="/user/checkReduceEmail", produces=MediaType.APPLICATION_JSON_VALUE)
	public Map<String, Object> checkReduceEmail(String email){
		return userService.isReduceEmail(email);
	}
	
	@ResponseBody
	@GetMapping(value="/user/sendAuthCode", produces=MediaType.APPLICATION_JSON_VALUE)
	public Map<String, Object> sendAuthCode(String email){
		return userService.sendAuthCode(email);
	}
	
	@GetMapping("/user/join")
	public String board() {
		return "/user/join";
	}
	
	@PostMapping("/user/join")
	public void join(HttpServletRequest request, HttpServletResponse response) {
		userService.join(request, response);
	}
	
	@PostMapping("/user/login")
	public void login(HttpServletRequest request, HttpServletResponse response) {
		userService.login(request, response);
	}
	
	@GetMapping("/user/logout")
	public String logout(HttpServletRequest request, HttpServletResponse response) {
		userService.logout(request, response);
		return "redirect:/";
	}

	@GetMapping("/user/login/form")
	public String loginForm(HttpServletRequest request, Model model) {
		System.out.println(request.getContextPath());
		// 요청 헤더 referer : 이전 페이지의 주소가 저장
		model.addAttribute("url", "http://localhost:9090");  // 로그인 후 되돌아 갈 주소 url

		// 네이버 로그인
		//  model.addAttribute("apiURL", userService.getNaverLoginApiURL(request));
      
		return "user/login";
	}

	// 회원정보 수정
	@GetMapping("/user/mypage")
	public String requiredLogin_mypage() {
		return "user/mypage";
	}
	
	@GetMapping("/user/check/form")
	public String requiredLogin_checkForm() {
		return "user/checkpw";
	}
   
	@GetMapping("/user/checkpw")
	public String requiredLogin_moveCheckPw(HttpServletRequest request) {
		return "user/checkpw";
	}
	
	@GetMapping("/user/info")
	public String requiredLogin_moveInfo(HttpServletRequest request) {
		return "user/info";
	}
   
	@ResponseBody
	@PostMapping(value="/user/check/pw", produces="application/json")
	public Map<String, Object> requiredLogin_checkPw(HttpServletRequest request) {
		return userService.confirmPassword(request);
	}
	
	@PostMapping("/user/modify/pw")
	public void requiredLogin_modifyPw(HttpServletRequest request, HttpServletResponse response) {
		userService.modifyPassword(request, response);
	}
   
	@PostMapping("/user/modify/info")
	public void requiredLogin_modify(HttpServletRequest request, HttpServletResponse response) {
		userService.modifyUser(request, response);
	}
	
	// 탈퇴
	@GetMapping("/user/retire")
	public void requiredLogin_retire(HttpServletRequest request, HttpServletResponse response) {
		userService.retire(request, response);
	}
	
   
}

