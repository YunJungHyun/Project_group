package com.spring.vo;

import org.springframework.web.multipart.MultipartFile;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString(callSuper=true)
public class ProfileImgVO {

	private MultipartFile file;
	private String profileName;
	private long profileSize;
	private String profileContentType;
	private byte[] profileData;

}
