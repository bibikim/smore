package com.gdu.smore.mapper;

import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface FreeLikedMapper {

	public int selectUserLikeCount(Map<String, Object> map);
	public int selectFreeLikeCount(int freeNo);
	public int insertLike(Map<String, Object> map);
	public int deleteLike(Map<String, Object> map);
}
