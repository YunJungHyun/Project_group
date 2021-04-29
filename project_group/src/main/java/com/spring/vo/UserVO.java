package com.spring.vo;

import java.sql.Date;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class UserVO {
	
	private int unum;
	private String usercode;
	private String userid;
	private String userpw;
	private String username;
	private String nickname;
	private String strBirth;
	private Date birth;
	private String gender;
	private String phn;
	private String email;
	private String loginsort;
	private Date regday;
	
	
	
}
