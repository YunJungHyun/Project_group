package com.spring.vo;

import java.sql.Date;
import java.sql.Timestamp;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString(callSuper=true)
public class CalendarVO {
	private int pnum;	
	/* private String cip; */
	private String ptitle;	
	private String pmemo;
	private String allDay;
	private Timestamp startDay;
	private String startTime;
	private Timestamp endDay;
	private String endTime;
	private String color;
	private String usercode;
}
