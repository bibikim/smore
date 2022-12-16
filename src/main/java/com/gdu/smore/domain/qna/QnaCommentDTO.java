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
	private int cmtNo;
	private int qaNo;
	private String cmtContent;
	private Date createDate;
	private Date modifyDate;
	private int state;
	private String ip;
}
