package com.gdu.smore.interceptor;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

@Component  // bean 생성 완.  -> servlet-context.xml에서 작업해주자
public class PreventLoginInterceptor implements HandlerInterceptor {

	// 로그인이 완료된 사용자가
	// 로그인페이지이동, 약관페이지이동, 가입페이지이동 등의 요청을 하면
	// 이를 막는 인터셉터
	
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		
		if(request.getSession().getAttribute("loginUser") != null) {   // 세션에 올라간 loginUser 찾기
			
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();
				
			out.println("<script>");
			out.println("alert('해당 기능은 사용할 수 없습니다')");
			out.println("location.href='" + request.getContextPath()  + "';");  // contextPath = /app13
			out.println("</script>");
			out.close();
			
			return false; // 컨트롤러의 요청(/user/login/form으로 이동하겠다는 요청) 처리되지 않는다.
			
		} else {
			
			return true;  // 컨트롤러의 요청이 처리된다.
			
		}
		
		
		// 요청 이전에 개입하는 것 -> filter(character encoding) / interceptor / aop
		// 요청 이전에 제일 먼저 filter처리(web.xml)하고 interceptor 있으면 그거 또 처리하고 요청 수행
		
	}
	
}
