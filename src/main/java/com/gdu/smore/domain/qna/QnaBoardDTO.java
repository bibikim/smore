package com.gdu.smore.domain.qna;


import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor 
@Data
@Builder
public class QnaBoardDTO {
	private int rowNum;
	private int qaNo;
	private String nickname;
	private String title;
	private String content;
	private int pw;
	@JsonFormat(pattern = "yyyy-MM-dd")
	private String createDate;
	@JsonFormat(pattern = "yyyy-MM-dd")
	private String modifyDate;
	private int hit;
	private String ip;
	private int answer;
}
