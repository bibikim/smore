package com.gdu.smore.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.ui.Model;

public interface RedService {
	// public void getRedList(HttpServletRequest request, Model model);

	public void saveRed(HttpServletRequest request, HttpServletResponse response);

}