package com.spring.vo;

import java.sql.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString(callSuper=true)
public class UserVO {
	
	private int unum;
	private String usercode;
	private String userid;
	private String userpw;
	private String username;
	
	private String strBirth;
	private Date birth;
	private String gender;
	
	private String email;
	private String loginsort;
	private Date regday;
	private String profile_img;
	private String thumnail_img;
	
	
}
