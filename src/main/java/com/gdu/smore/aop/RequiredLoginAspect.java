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

// 로그인이 되었는지 안되었는지 매번 확인할 수 없으니까 확인하는 코드를 여기다 하나만 넣고 동작하게 하려는 목적

@Component
@EnableAspectJAutoProxy
@Aspect  // 컨트롤러의 모든 메소드 조인포인트 -> 그중에서 aop 적용시킬 메소드는 포인트컷!
public class RequiredLoginAspect {
					// 모든 컨트롤러의 requiredLogin_이 붙어있는 모든 메소드(매개변수 노상관)!
	@Pointcut("execution(* com.gdu.smore.*Controller.requiredLogin_*(..))")  // (..) 매개변수가 어떤것이든 상관없다는 의미
	public void requiredLogin() { }  // 이 메소드는 원래 본문이 없고, 포인트컷 수행을 위해서만 있는 메소드
	
	// 포인트컷 실행 전에 requiredLogin() 메소드 수행
	@Before("requiredLogin()")  // required가 붙어있는 모든 메소드들 수행하기 전에 동작하라고 Before에 requiredLogin() 메소드 호출!
	public void requiredLoginHandler(JoinPoint joinPoint) throws Throwable {  // aspectJ 패키지의 JoinPoint

		// 로그인이 되어 있는지 확인하기 위해서 session이 필요하므로,
		// request가 필요하다.
		// 응답을 만들기 위해서 response도 필요하다.
		ServletRequestAttributes servletWebRequest = (ServletRequestAttributes)RequestContextHolder.getRequestAttributes();
		HttpServletRequest request = servletWebRequest.getRequest();
		HttpServletResponse response = servletWebRequest.getResponse();
		
		// 세션
		HttpSession session = request.getSession();
		
		// 로그인 여부 확인
		if(session.getAttribute("loginUser") == null) {
			
			// 로그인 해야 가능한 요청들인데 로그인이 안되는 상황(== null)
			// throwable 했기 때문에 try-catch 필요 없음
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
		
		// aop가 동작하기 위해서는 만들고 @컴포넌트 등록하고 해당 컴포넌트 동작시키는 @EnableAspcetJAutoProxy가 필요하다
		
		
		
	}
}
