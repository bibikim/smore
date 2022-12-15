package com.gdu.smore.service;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartHttpServletRequest;

public interface FreeService {

	public void getFreeList(Model model);
	public void saveFree(HttpServletRequest request, HttpServletResponse response);
	public Map<String, Object> savefImage(MultipartHttpServletRequest mRequest);
	public int increaseHit(int fNo);
	
}
