package com.gdu.smore.domain.free;

import java.sql.Date;

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
	private int fNo;
	private String nickname;
	private String fTitle;
	private String fContent;
	private Date fCreateDate;
	private Date fModifyDate;
	private int fHit;
	private String fIp;
}
