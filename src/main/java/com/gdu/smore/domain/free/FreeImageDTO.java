package com.gdu.smore.domain.free;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
@Builder
public class FreeImageDTO {
	private int fNo;
	private String fileSystem;
}
