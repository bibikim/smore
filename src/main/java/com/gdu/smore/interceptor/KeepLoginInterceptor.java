package com.gdu.smore.interceptor;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.util.WebUtils;

import com.gdu.smore.domain.user.UserDTO;
import com.gdu.smore.service.UserService;

@Component
public class KeepLoginInterceptor implements HandlerInterceptor {

	@Autowired
	private UserService userService;
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		
		HttpSession session = request.getSession();
		if(session.getAttribute("loginUser") == null) {
			
			Cookie cookie = WebUtils.getCookie(request, "keepLogin");
			if(cookie != null) {
				
				Map<String, Object> map = new HashMap<String, Object>();
				map.put("sessionId", cookie.getValue());
				
				UserDTO loginUser = userService.getUserBySessionId(map);
				if(loginUser != null) {
					session.setAttribute("loginUser", loginUser);
				}
			}
		}
		return true;
	}

}
