package com.gdu.smore.domain.code;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
@Builder
public class CodeCommentDTO {
	private int cmtNo;
	private int coNo;
	private String nickname;
	private String cmtContent;
	private Date createDate;
	private Date omdifyDate;
	private int state;
	private int depth;
	private String ip;
	private int groupNo;
}
