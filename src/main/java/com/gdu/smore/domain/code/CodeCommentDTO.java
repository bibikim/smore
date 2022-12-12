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
	private int cCmtNo;
	private int cNo;
	private String nickname;
	private String cCmtContent;
	private Date cCmtCreateDate;
	private Date cCmtModifyDate;
	private int cState;
	private int cDepth;
	private String cIp;
}
