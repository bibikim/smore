package com.gdu.smore.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import com.gdu.smore.interceptor.KeepLoginInterceptor;
import com.gdu.smore.interceptor.PreventLoginInterceptor;
import com.gdu.smore.interceptor.SleepUserCheckingInterceptor;

@Configuration
public class WebMvcConfig implements WebMvcConfigurer {

	@Autowired
	private KeepLoginInterceptor keepLoginInterceptor;
	
	@Autowired 
	private PreventLoginInterceptor preventLoginInterceptor;
	
	@Autowired
	private SleepUserCheckingInterceptor sleepUserCheckingInterceptor;
	
	@Override
	public void addResourceHandlers(ResourceHandlerRegistry registry) {
		registry.addResourceHandler("/load/image/**")
			    .addResourceLocations("file:///C:/summernoteImage/");
	}
	
	@Override
	public void addInterceptors(InterceptorRegistry registry) {
		registry.addInterceptor(keepLoginInterceptor)
				.addPathPatterns("/") // 적용할 URL
				.excludePathPatterns("/login");
		
		registry.addInterceptor(preventLoginInterceptor)
				.addPathPatterns("/user/login/form") .addPathPatterns("/user/join/write")
				.addPathPatterns("/user/agree");
		  
		registry.addInterceptor(sleepUserCheckingInterceptor)
				.addPathPatterns("/user/login");
	}
	
}
