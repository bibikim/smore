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
	private int sNo;
	private String nickname;
	private String sTitle;
	private String sContent;
	private Date sCreateDate;
	private Date sModifyDate;
	private int sHit;
	private String sGender;
	private String sRegion;
	private String sWido;
	private String sGdo;
	private String sLang;
	private String sPeople;
	private String sContact;
	private Date sDate;
	private String sIp;
}
