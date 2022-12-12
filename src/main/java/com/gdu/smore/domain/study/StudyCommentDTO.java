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
	private int sCmtNo;
	private int sNo;
	private String nickname;
	private String sCmtContent;
	private Date sCmtCreateDate;
	private int sState;
	private int sDepth;
	private String sIp;
}
