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
public class QnaBoardDTO {
	private int qNo;
	private String nickname;
	private String qTitle;
	private String qContent;
	private int qPw;
	private Date qCreateDate;
	private Date qModifyDate;
	private int qHit;
	private String qIp;
}
