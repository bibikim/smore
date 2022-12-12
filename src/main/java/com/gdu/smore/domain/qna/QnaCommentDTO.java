package com.gdu.smore.domain.qna;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
@Builder
public class QnaCommentDTO {
	private int qCmtNo;
	private int qNo;
	private String qCmtContent;
	private Date qCmtCreateDate;
	private Date qCmtModifyDate;
	private int qState;
	private String qIp;
}
