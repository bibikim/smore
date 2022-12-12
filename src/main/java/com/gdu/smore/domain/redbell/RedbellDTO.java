package com.gdu.smore.domain.redbell;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
@Builder
public class RedbellDTO {
	private int rNo;
	private String id;
	private String rContent;
	private Date rDate;
	private int rGuBun;
	private int rTarget;
	private int sNo;
	private int sCmtNo;
}
