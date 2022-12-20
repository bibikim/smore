package com.gdu.smore.service;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.gdu.smore.domain.user.SleepUserDTO;
import com.gdu.smore.domain.user.UserDTO;

public interface UserService {
	public Map<String, Object> isReduceId(String id);
	public Map<String, Object> isReduceEmail(String email);
	public Map<String, Object> sendAuthCode(String email);
	
	public void join(HttpServletRequest request, HttpServletResponse response);
	public void login(HttpServletRequest request, HttpServletResponse response);
	public void logout(HttpServletRequest request, HttpServletResponse response);
	
	// 네이버 로그인
	public String getNaverLoginApiURL(HttpServletRequest request);  
	public String getNaverLoginToken(HttpServletRequest request);   
	public UserDTO getNaverLoginProfile(String accessToken);       
	public UserDTO getNaverUserById(String id);
	public void naverLogin(HttpServletRequest request, UserDTO naverUser);
	public void naverJoin(HttpServletRequest request, HttpServletResponse response);
	
	// 카카오 로그인
	/*
	public String getKakaoLoginApiURL(HttpServletRequest request);  
	public String getKakaoLoginToken(HttpServletRequest request);   
	public UserDTO getKakaoLoginProfile(String accessToken);       
	public UserDTO getKakaoUserById(String id);
	public void kakaoLogin(HttpServletRequest request, UserDTO kakaoUser);
	public void kakaoJoin(HttpServletRequest request, HttpServletResponse response);
	*/
	
	// 로그인 유지
	public void keepLogin(HttpServletRequest request, HttpServletResponse response);
	public UserDTO getUserBySessionId(Map<String, Object> map);
	
	// 아이디 찾기
	public Map<String, Object> findId(Map<String, Object> map);
	
	// 비번 찾기
	public Map<String, Object> sendTemporaryPw(UserDTO user);
	
	// 정보 수정
	public Map<String, Object> confirmPassword(HttpServletRequest request);
	public void modifyPassword(HttpServletRequest request, HttpServletResponse response);
	public void modifyUser(HttpServletRequest request, HttpServletResponse response);
	
	// 탈퇴
	public void retire(HttpServletRequest request, HttpServletResponse response);
	
	// 휴면
	public void sleepUserHandle();
	public SleepUserDTO getSleepUserById(String id);
	public void restoreUser(HttpServletRequest request, HttpServletResponse response);
	
}