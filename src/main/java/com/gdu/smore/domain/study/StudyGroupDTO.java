package com.gdu.smore.domain.study;

import java.sql.Date;

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
	private Date studDate;
	private String ip;
}
