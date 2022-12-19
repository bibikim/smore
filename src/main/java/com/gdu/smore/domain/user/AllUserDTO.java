package com.gdu.smore.domain.user;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
public class AllUserDTO {
	private int rowNum;
	private UserDTO userDTO;
	private SleepUserDTO sleepUserDTO;
}
