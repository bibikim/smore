package com.gdu.smore.interceptor;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

@Component 
public class PreventLoginInterceptor implements HandlerInterceptor {

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		
		if(request.getSession().getAttribute("loginUser") != null) { 
			
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();
				
			out.println("<script>");
			out.println("alert('해당 기능은 사용할 수 없습니다')");
			out.println("location.href='/';"); 
			out.println("</script>");
			out.close();
			return false; // 컨트롤러의 요청(/user/login/form으로 이동하겠다는 요청) 처리되지 않는다.
			
		} else {
			return true;  
		}
	}
}
