package com.gdu.smore.domain.code;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
@Builder

public class CodeAttachDTO {
	private int attachNo;
	private int cNo;
	private String path;
	private String origin;
	private String fileSystem;
	private int downloadCnt;
}
