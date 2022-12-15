package com.gdu.smore.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import com.gdu.smore.interceptor.KeepLoginInterceptor;
import com.gdu.smore.interceptor.PreventLoginInterceptor;
import com.gdu.smore.interceptor.SleepUserCheckingInterceptor;

@Configuration
public class WebMvcConfig implements WebMvcConfigurer {

	// servlet-context.xml에서 resources 태그로 썸머노트이미지 저장시키는 경로 빈 등록한거 자바단에서 만들어둠
	@Override
	public void addResourceHandlers(ResourceHandlerRegistry registry) {
		registry.addResourceHandler("/load/image/**")
			    .addResourceLocations("file:///C:/summernoteImage/");
	}
	
	@Override
	public void addInterceptors(InterceptorRegistry registry) {
		registry.addInterceptor(new KeepLoginInterceptor())
			.addPathPatterns("/**"); // 적용할 URL
		registry.addInterceptor(new PreventLoginInterceptor())
			.addPathPatterns("/user/login/form")
			.addPathPatterns("/user/join/write")
			.addPathPatterns("/user/agree");
		registry.addInterceptor(new SleepUserCheckingInterceptor())
			.addPathPatterns("/user/login");
			// .excludePathPatterns("");	// 제외할 URL
	}
	
	
	
}
