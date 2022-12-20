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
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.gdu.smore.domain.user.UserDTO;
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
	
	@GetMapping("/user/login/form")
	public String loginForm(HttpServletRequest request, Model model) {
		// 로그인 후 되돌아 갈 주소 url
		model.addAttribute("url", "http://localhost:9090");  

		// 네이버 로그인
		model.addAttribute("apiURL", userService.getNaverLoginApiURL(request));
      
		return "user/login";
	}

	@PostMapping("/user/login")
	public void login(HttpServletRequest request, HttpServletResponse response) {
		userService.login(request, response);
	}
	
	// 네이버 로그인
	@GetMapping("/user/naver/login")
	public String naverLogin(HttpServletRequest request, Model model) {
		
		String access_token = userService.getNaverLoginToken(request);
		UserDTO profile = userService.getNaverLoginProfile(access_token);  // 네이버로그인에서 받아온 프로필 정보
		UserDTO naverUser = userService.getNaverUserById(profile.getId()); // 이미 네이버로그인으로 가입한 회원이라면 DB에 정보가 있음
		
		// 네이버로그인으로 가입하려는 회원 : 간편가입페이지로 이동
		if(naverUser == null) {
			model.addAttribute("profile", profile);
			return "user/naver_join";
		}
		// 네이버로그인으로 이미 가입한 회원 : 로그인 처리
		else {
			userService.naverLogin(request, naverUser);
			return "redirect:/";
		}
	}
	
	@PostMapping("/user/naver/join")
	public void naverJoin(HttpServletRequest request, HttpServletResponse response) {
		userService.naverJoin(request, response);
	}
	
	@GetMapping("/user/logout")
	public String logout(HttpServletRequest request, HttpServletResponse response) {
		userService.logout(request, response);
		return "redirect:/";
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
	public Map<String, Object> checkPw(HttpServletRequest request) {
		return userService.confirmPassword(request);
	}
	
	@PostMapping("/user/modify/pw")
	public void modifyPw(HttpServletRequest request, HttpServletResponse response) {
		userService.modifyPassword(request, response);
	}
   
	@PostMapping("/user/modify/info")
	public void modify(HttpServletRequest request, HttpServletResponse response) {
		userService.modifyUser(request, response);
	}
	
	// 탈퇴
	@GetMapping("/user/retire")
	public void retire(HttpServletRequest request, HttpServletResponse response) {
		userService.retire(request, response);
	}
	
	// 휴면
	@GetMapping("/user/sleep/display")
	public String sleepDisplay() {
		return "user/sleep";
	}

	@PostMapping("/user/restore")
	public void restore(HttpServletRequest request, HttpServletResponse response) {
		userService.restoreUser(request, response);
	}
	
	// 아이디 찾기
	@GetMapping("/user/findId/form")
	public String findIdForm() {
		return "user/findid";
	}
	
	@ResponseBody
	@PostMapping(value="/user/findId", produces="application/json")
	public Map<String, Object> findId(@RequestBody Map<String, Object> map) {
		return userService.findId(map);
	}
	
	// 비번 찾기
	@GetMapping("/user/findPw/form")
	public String findPwForm() {
		return "user/findpw";
	}
	
	@ResponseBody
	@PostMapping(value="/user/findPw", produces="application/json")
	public Map<String, Object> findPw(@RequestBody Map<String, Object> map) {
		return userService.findId(map);
	}
	
	@ResponseBody
	@PostMapping(value="/user/sendTemporaryPassword", produces="application/json")
	public Map<String, Object> memberSendEmailTemporaryPassword(UserDTO user) {
		return userService.sendTemporaryPw(user);
	}
	
}

