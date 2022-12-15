package com.gdu.smore.aop;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Pointcut;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

@Component	
@Aspect		
public class RequestLoggingAspect {

	private static final Logger LOG = LoggerFactory.getLogger(RequestLoggingAspect.class);
	
	@Pointcut("within(com.gdu.smore.controller..*)")  
													  
	public void setPointCut() {}	
	
	@Around("com.gdu.smore.aop.RequestLoggingAspect.setPointCut()") // setPointCut 메소드에 설정된 포인트컷에서 동작하는 어드바이스
	public Object executeLogging(ProceedingJoinPoint joinPoint) throws Throwable {  //@Around는 반드시 ProceedingJoinPoint joinPoint 선언해야 함
		
		  // HttpServletRequest를 사용하는 방법
	      HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();

	    		  
	  	  // HttpServletRequest를 Map으로 바꾸기
	      // 파라미터는 Map의 key가 되고, 값은 Map의 value가 된다.
		  Map<String, String[]> map = request.getParameterMap();
	      String params = "";
	      if(map.isEmpty()) {
	    	  params += "[No Parameter]";
	      } else {
	    	  for(Map.Entry<String, String[]> entry : map.entrySet()) {
	    		  params += "[" + entry.getKey() + "=" + String.format("%s", (Object[])entry.getValue());  // %s 문자열로 출력
	    	  }
	      }
	      
	      // 어드바이스는 proceed() 메소드 실행 결과를 반환
	      Object result = null;
	      try {
	    	  result = joinPoint.proceed(joinPoint.getArgs());
	      } catch (Exception e) {
			throw e;
		} finally {
			// 무조건 실행되는 영역(여기서 로그를 찍는다.)
			// 치환문자 : {}
			LOG.info("{} {} {} > {}", request.getMethod(), request.getRequestURI(), params, request.getRemoteHost());
		}
	      return result;
	}
}
