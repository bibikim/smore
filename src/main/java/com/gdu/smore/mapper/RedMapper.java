package com.gdu.smore.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.gdu.smore.domain.redbell.GrpRedbellDTO;

@Mapper
public interface RedMapper {
	public int insertRed(GrpRedbellDTO redNo);
}