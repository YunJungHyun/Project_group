package com.spring.vo;

import java.sql.Timestamp;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString(callSuper=true)
public class DiaryVO {
	private String usercode;
	private int dnum;
	private String dtitle;
	private String dcontents;
	private Timestamp writeDay ;//등록할 날짜
	private Timestamp regDay ;//등록한 실제 날짜
	private String picture;
	
}
