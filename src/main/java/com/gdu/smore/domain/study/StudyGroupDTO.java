package com.gdu.smore.domain.study;


import java.util.Date;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
@Builder
public class StudyGroupDTO {
	private int rowNum;
	private int studNo;
	private String nickname;
	private String title;
	private String content;
	@JsonFormat(pattern = "yyyy-MM-dd")
	private Date createDate;
	private Date modifyDate;
	private int hit;
	private String gender;
	private String region;
	private String wido;
	private String gdo;
	private String lang;
	private String people;
	private String contact;
	@JsonFormat(pattern = "yyyy-MM-dd")
	private Date studDate;
	private String ip;
	private String jang;
}
