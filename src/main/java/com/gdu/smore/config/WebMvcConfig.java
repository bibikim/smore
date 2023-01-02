package com.gdu.smore.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import com.gdu.smore.interceptor.KeepLoginInterceptor;
import com.gdu.smore.interceptor.PreventLoginInterceptor;
import com.gdu.smore.interceptor.SleepUserCheckingInterceptor;
import com.gdu.smore.util.MyFileUtil;

import lombok.AllArgsConstructor;

@AllArgsConstructor
@Configuration
public class WebMvcConfig implements WebMvcConfigurer {

	private KeepLoginInterceptor keepLoginInterceptor;
	private PreventLoginInterceptor preventLoginInterceptor;
	private SleepUserCheckingInterceptor sleepUserCheckingInterceptor;
	private MyFileUtil myFileUtil;

	@Override
	public void addResourceHandlers(ResourceHandlerRegistry registry) {
		registry.addResourceHandler("/load/image/**")
			    .addResourceLocations("file:" + myFileUtil.getSummernotePath() + "/");
	}
	
	@Override
	public void addInterceptors(InterceptorRegistry registry) {
		registry.addInterceptor(keepLoginInterceptor)
				.addPathPatterns("/") // 적용할 URL
				.excludePathPatterns("/login");
		
		registry.addInterceptor(preventLoginInterceptor)
				.addPathPatterns("/user/login/form")
				.addPathPatterns("/user/join/write")
				.addPathPatterns("/user/agree");
		  
		registry.addInterceptor(sleepUserCheckingInterceptor)
				.addPathPatterns("/user/login");
	}
	
}
