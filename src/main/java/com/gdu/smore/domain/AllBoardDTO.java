package com.gdu.smore.domain;

import java.util.Date;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.gdu.smore.domain.code.CodeBoardDTO;
import com.gdu.smore.domain.free.FreeBoardDTO;
import com.gdu.smore.domain.qna.QnaBoardDTO;
import com.gdu.smore.domain.study.StudyGroupDTO;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
public class AllBoardDTO {
	private int rowNum;
	private int freeNo;
	private int qaNo;
	private int studNo;
	private int coNo;
	private String nickname;
	private String title;
	private String content;
	@JsonFormat(pattern = "yyyy-MM-dd")
	private Date createDate;
	@JsonFormat(pattern = "yyyy-MM-dd")
	private Date modifyDate;
	private int hit;
	private String ip;
//	private FreeBoardDTO freeBoardDTO;
//	private CodeBoardDTO codeBoardDTO;
//	private QnaBoardDTO qnaBoardDTO;
//	private StudyGroupDTO studyGroupDTO;
}
