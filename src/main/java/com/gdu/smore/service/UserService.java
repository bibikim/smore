package com.gdu.smore.service;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.gdu.smore.domain.user.UserDTO;

public interface UserService {
	public Map<String, Object> isReduceId(String id);
	public Map<String, Object> isReduceEmail(String email);
	public Map<String, Object> sendAuthCode(String email);
	
	public void join(HttpServletRequest request, HttpServletResponse response);
	public void login(HttpServletRequest request, HttpServletResponse response);
	public void logout(HttpServletRequest request, HttpServletResponse response);
	
	// 로그인 유지
	public void keepLogin(HttpServletRequest request, HttpServletResponse response);
	public UserDTO getUserBySessionId(Map<String, Object> map);
	
	// 정보 수정
	public Map<String, Object> confirmPassword(HttpServletRequest request);
	public void modifyPassword(HttpServletRequest request, HttpServletResponse response);
	public void modifyUser(HttpServletRequest request, HttpServletResponse response);
	
	// 탈퇴
	public void retire(HttpServletRequest request, HttpServletResponse response);
	
	
	
}