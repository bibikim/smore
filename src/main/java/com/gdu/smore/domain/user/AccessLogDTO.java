package com.gdu.smore.domain.user;

import java.sql.Date;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
@Builder
public class AccessLogDTO {
	private int accessLogNo;
	private String id;
	@JsonFormat(pattern = "yyyy-MM-dd")
	private Date lastLoginDate;
}
