package com.spring.service;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Service;

import com.spring.helper.LoginType;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class LoginTypeService {
	
	private final List<OauthInterface> OauthList;
	private final HttpServletResponse response;
	
	public void loginRequest(LoginType loginType) throws IOException {
	
			OauthInterface oauthInterface = this.findOauthByType(loginType);
			String redirectURL = oauthInterface.getRedirectURL();
			System.out.println("redirectURL :" +redirectURL);
			
			
			response.sendRedirect(redirectURL);
			
	}
	
	
	public String requestAccessToken(LoginType loginType, String code) {
		OauthInterface oauthInterface = this.findOauthByType(loginType);
		return oauthInterface.requestAccessToken(code);
	} 
	
	public HashMap<String, Object> getUserInfo(LoginType loginType, String access_Token) {
		OauthInterface oauthInterface = this.findOauthByType(loginType);
		return oauthInterface.getUserinfo(access_Token);
		
	}
	
	
	

	private OauthInterface findOauthByType(LoginType loginType) {
        return OauthList.stream()
                .filter(x -> x.type() == loginType)
                .findFirst()
                .orElseThrow(() -> new IllegalArgumentException("알 수 없는 SocialLoginType 입니다."));
    }



	

	

}
