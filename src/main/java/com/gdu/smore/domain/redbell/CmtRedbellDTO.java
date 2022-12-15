package com.gdu.smore.domain.redbell;

import java.sql.Date;

import com.gdu.smore.domain.study.StudyCommentDTO;
import com.gdu.smore.domain.user.UserDTO;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
@Builder
public class CmtRedbellDTO {
	private int rNo;
	private String id;
	private int sCmtNo;
	private String rContent;
	private Date rDate;
	private UserDTO user;
	private StudyCommentDTO studyComment;
}
