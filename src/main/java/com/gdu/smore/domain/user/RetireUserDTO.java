package com.gdu.smore.domain.user;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
@Builder
public class RetireUserDTO {
	private int userNo;
	private String id;
	private Date joinDate;
	private Date retireDate;
}
