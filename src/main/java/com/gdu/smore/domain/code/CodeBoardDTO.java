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
public class CodeBoardDTO {
	private int cNo;
	private String nickname;
	private String cTitle;
	private String cContent;
	private Date cCreateDate;
	private Date cModifyDate;
	private int cHit;
	private String cIp;
}
