package com.gdu.smore.domain.study;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
@Builder
public class StudyZzimDTO {
	private int rowNum;
	private String nickname;
	private int studNo;
	private String jang;
	private StudyGroupDTO studyGroupDTO;
}
