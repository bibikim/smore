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
	private int qaNo;
	private String nickname;
	private String title;
	private String content;
	private int pw;
	private Date createDate;
	private Date modifyDate;
	private int hit;
	private String ip;
}
