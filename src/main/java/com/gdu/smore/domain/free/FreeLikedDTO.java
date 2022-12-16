package com.gdu.smore.domain.free;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
@Builder
public class FreeLikedDTO {
	private int freeNo;
	private String nickname;
}
