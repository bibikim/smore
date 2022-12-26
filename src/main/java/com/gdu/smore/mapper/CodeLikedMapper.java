package com.gdu.smore.mapper;

import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface CodeLikedMapper {

	public int selectUserLikeCount(Map<String, Object> map);
	public int selectCodeLikeCount(int coNo);
	public int insertLike(Map<String, Object> map);
	public int deleteLike(Map<String, Object> map);
}
