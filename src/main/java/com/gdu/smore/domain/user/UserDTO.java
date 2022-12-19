package com.gdu.smore.domain.user;

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
public class UserDTO {
	private int rowNum;
	private int userNo;
	private String id;
	private String nickname;
	private String pw;
	private String name;
	private int grade; // 관리자:0 스터디장:1  일반 : 2
	private String gender;
	private String email;
	private String mobile;
	private String birthyear;
	private String birthday;
	private String postcode;
	private String roadAddress;
	private String jibunAddress;
	private String detailAddress;
	private String extraAddress;
	private int agreeCode;
	private String snsType;
	@JsonFormat(pattern = "yyyy-MM-dd")
	private Date joinDate;
	private Date pwModifyDate;
	@JsonFormat(pattern = "yyyy-MM-dd")
	private Date infoModifyDate;
	private String sessionId;
	private Date sessionLimitDate;
	private int blackCnt;
	private int userState; //일반회원(1) / 제재회원(0) 구분 not null
	@JsonFormat(pattern = "yyyy-MM-dd")
	private Date lastLoginDate;
	private AccessLogDTO accessLogDTO;
	private SleepUserDTO sleepUserDTO;
}
