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
public class SleepUserDTO {
	private int rowNum;
	private int userNo;
	private String id;
	private String nickname;
	private String pw;
	private String name;
	private int grade;
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
	private int userState;
	@JsonFormat(pattern = "yyyy-MM-dd")
	private Date joinDate;
	@JsonFormat(pattern = "yyyy-MM-dd")
	private Date lastLoginDate;
	@JsonFormat(pattern = "yyyy-MM-dd")
	private Date sleepDate;
}
