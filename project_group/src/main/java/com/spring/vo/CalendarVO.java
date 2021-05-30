package com.spring.vo;

import java.sql.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString(callSuper=true)
public class CalendarVO {
	private int pnum;	
	private String cip;
	private String plantitle;	
	private String plan;
	private Date start;
	private Date end;
	private String color;
	private Date startTime;
	private Date endTime;
	private String usercode;
}
