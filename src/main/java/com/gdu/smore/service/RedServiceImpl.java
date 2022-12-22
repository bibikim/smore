package com.gdu.smore.service;

import org.springframework.context.annotation.PropertySource;
import org.springframework.stereotype.Service;

import com.gdu.smore.domain.redbell.GrpRedbellDTO;

@PropertySource(value = {"classpath:application.yml"})
@Service
public class RedServiceImpl implements RedService {

	@Override
	public GrpRedbellDTO getRedByNo(int redNo) {
		
		return null;
	}
}
