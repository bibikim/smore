package com.gdu.smore.service;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

public interface JobZzimService {

	public Map<String, Object> getScrapCheck(HttpServletRequest request);
	public Map<String, Object> getScrapCount(int jobNo);
	public Map<String, Object> markScrap(HttpServletRequest request);
	
	// 파라미터를 컨트롤러에서 받아올건지
	// 서비스(임플)에서 받아서 올건지.
	// 서비스에서 작업한걸 jsp 로 넘겨줘야 할 때 어떻게 넘겨줘야할지 생각,,
	// jsp에서 서버로 넘어올때 응답을 해줘야하면 response도 필요한 것이고..
	// DTO에 담기 애매하면 model에 담아주고~ map도 괜찮고~
	
	
	
}
