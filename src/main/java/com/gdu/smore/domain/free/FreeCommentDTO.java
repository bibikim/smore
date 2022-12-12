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
public class FreeCommentDTO {
	private int fCmtNo;
	private int fNo;
	private String nickname;
	private String fCmtContent;
	private Date fCmtCreateDate;
	private Date fCmtModifyDate;
	private int fState;
	private int fDepth;
	private String fIp;
}
