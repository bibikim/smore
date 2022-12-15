package com.gdu.smore.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class WebMvcConfig implements WebMvcConfigurer {

	// servlet-context.xml에서 resources 태그로 썸머노트이미지 저장시키는 경로 빈 등록한거 자바단에서 만들어둠
	@Override
	public void addResourceHandlers(ResourceHandlerRegistry registry) {
		registry.addResourceHandler("/load/image/**")
			.addResourceLocations("file:///C:/summernoteImage/");
	}
	
}
