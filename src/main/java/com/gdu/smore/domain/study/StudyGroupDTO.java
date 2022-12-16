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
	private int SNo;
	private int rowNum;
	private String nickname;
	private String STitle;
	private String SContent;
	private Date SCreateDate;
	private Date SModifyDate;
	private int SHit;
	private String SGender;
	private String SRegion;
	private String SWido;
	private String SGdo;
	private String SLang;
	private String SPeople;
	private String SContact;
	private Date SDate;
	private String SIp;
}
