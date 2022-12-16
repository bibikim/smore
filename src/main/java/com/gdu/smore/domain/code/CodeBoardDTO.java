package com.gdu.smore.domain.code;



import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
@Builder
public class CodeBoardDTO {
	private int coNo;
	private String nickname;
	private String title;
	private String content;
	private Date createDate;
	private Date modifyDate;
	private int hit;
	private String ip;
}
