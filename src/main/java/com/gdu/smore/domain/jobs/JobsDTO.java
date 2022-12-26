package com.gdu.smore.domain.jobs;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Builder
@Data
public class JobsDTO {

	private int jobNo;
	private String title;
	private String nickname;
	private String companyName;
	private String contact;
	private String homepage;
	private String profile;
	private String hrName;
	private String hrContact;
	private String hrEmail;
	private String position;
	private String location;
	private String jobType;
	private String content;
	private Date createDate;
	private String career;
	private int status;
	private String skillStack;
	private int hit;
	
}
