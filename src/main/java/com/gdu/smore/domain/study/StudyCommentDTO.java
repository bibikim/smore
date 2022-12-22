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
public class StudyCommentDTO {
	private int cmtNo;
	private int studNo;
	private String nickname;
	private String cmtContent;
	private Date createDate;
	private int state;
	private int depth;
	private int groupNo;
	private String ip;
}
