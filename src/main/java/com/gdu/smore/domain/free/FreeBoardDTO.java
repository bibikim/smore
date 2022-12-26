package com.gdu.smore.domain.free;

import java.util.Date;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
@Builder
public class FreeBoardDTO {
	private int rowNum;
	private int freeNo;
	private String nickname;
	private String title;
	private String content;
	@JsonFormat(pattern = "yyyy-MM-dd")
	private Date createDate;
	@JsonFormat(pattern = "yyyy-MM-dd")
	private Date modifyDate;
	private int hit;
	private String ip;
	
}
