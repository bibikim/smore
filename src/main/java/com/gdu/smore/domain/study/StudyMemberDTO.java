package com.gdu.smore.domain.study;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
@Builder
public class StudyMemberDTO {
	private String nickname;
	private int studNo;
	private Date applyDate;
	private int applyGubun;
}
