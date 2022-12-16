package com.gdu.smore.service;

import java.util.Map;

public interface AdminService {
	public Map<String, Object> getUserList(int page);
	public Map<String, Object> getSleepUserList(int page);
	public Map<String, Object> removeUserList(String userNoList);
	public Map<String, Object> getreportUserList(int page);
}