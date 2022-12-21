package com.gdu.smore.batch;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.gdu.smore.service.UserService;

@EnableScheduling
@Component
public class SleepUserScheduler {

	@Autowired
	private UserService userService;
		
	@Scheduled(cron="0 0/1 * * * *") 
	public void execute() {
		userService.sleepUserHandle(); 
	}
	 
}
