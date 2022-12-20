package com.gdu.smore.aop;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.aspectj.lang.annotation.Pointcut;
import org.springframework.context.annotation.EnableAspectJAutoProxy;
import org.springframework.stereotype.Component;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

@EnableAspectJAutoProxy
@Aspect
@Component
public class RequiredLoginAspect {

	@Pointcut("execution(* com.gdu.smore.controller.*Controller.requiredLogin_*(..))")
	public void requiredLogin() { }
	
	@Before("requiredLogin()")  // 포인트컷 실행 전에 requiredLogin() 메소드 수행
	public void requiredLoginHandler(JoinPoint joinPoint) throws Throwable {
		
		// 로그인이 되어 있는지 확인하기 위해서 session이 필요하므로 request가 필요하다.
		// 응답을 만들기 위해서 response도 필요하다.
		ServletRequestAttributes servletRequestAttributes = (ServletRequestAttributes)RequestContextHolder.getRequestAttributes();
		HttpServletRequest request = servletRequestAttributes.getRequest();
		HttpServletResponse response = servletRequestAttributes.getResponse();
		
		HttpSession session = request.getSession();
		
		if(session.getAttribute("loginUser") == null) {
			
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();
			
			out.println("<script>");
			out.println("if(confirm('로그인이 필요한 기능입니다. 로그인 하시겠습니까?')){");
			out.println("location.href='" + request.getContextPath() + "/user/login/form';");
			out.println("} else {");
			out.println("history.back();");
			out.println("}");			
			out.println("</script>");
			out.close();
		}	
	}
	
}
