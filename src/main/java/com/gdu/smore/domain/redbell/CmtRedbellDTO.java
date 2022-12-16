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
	private int redCmtNo;
	private String id;
	private int cmtNo;
	private String redContent;
	private Date redDate;
	private UserDTO user;
	private StudyCommentDTO studyComment;
}
