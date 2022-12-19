package com.gdu.smore.domain.free;


import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
@Builder
public class FreeCommentDTO {
	private int cmtNo;
	private int freeNo;
	private String nickname;
	private String cmtContent;
	private Date createDate;
	private Date modifyDate;
	private int state;
	private int depth;
	private String ip;
	private int groupNo;
}
