package com.gdu.smore.domain.code;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
@Builder
public class CodeImageDTO {
	private int coNo;
	private String filesystem;
}
