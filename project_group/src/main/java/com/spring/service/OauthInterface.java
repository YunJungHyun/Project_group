package com.spring.service;

import java.util.HashMap;

import com.spring.helper.LoginType;

public interface OauthInterface {

	String getRedirectURL();


	default LoginType type() {
		if(this instanceof GoogleOauth) {
			return LoginType.GOOGLE;
		}	
		else if (this instanceof KakaoOauth) {
			return	LoginType.KAKAO;
		} else {
			return null;
		}
	}


	 String requestAccessToken(String code);


	 HashMap<String, Object> getUserinfo(String access_Token);


	
		

	 
	
}
