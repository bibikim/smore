package com.gdu.smore.domain.redbell;

import java.sql.Date;

import com.gdu.smore.domain.study.StudyGroupDTO;
import com.gdu.smore.domain.user.UserDTO;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
@Builder
public class GrpRedbellDTO {
	private int redNo;
	private String id; // 신고자 ID
	private int studNo;
	private String redContent;
	private Date redDate;
	private UserDTO user;
	private StudyGroupDTO studyGroup;
}
