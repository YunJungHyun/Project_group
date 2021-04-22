package com.spring.controller;

import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.spring.login.service.KakaoAPI;

@Controller
public class LoginController {
	
	
	@Autowired
	private KakaoAPI kakao;
	
	@RequestMapping(value="/login")
	public String login(
			
			@RequestParam(value="with", required= false) String with
		
			) {
		
		if(with.equals("kakao")) {
			
			
			StringBuffer loginUrl = new StringBuffer();
			loginUrl.append("https://kauth.kakao.com/oauth/authorize?client_id=");
			loginUrl.append("78553ffd86a12678fb1148721501f748"); //카카오 앱에 있는 REST KEY
			loginUrl.append("&redirect_uri=");
			loginUrl.append("http://localhost:8081/kakaoLogin"); //카카오 앱에 등록한 redirect URL
			loginUrl.append("&response_type=code");
			
			
			
			return "redirect:"+loginUrl.toString();
		}
		
		return null;
	}
	
	
	@RequestMapping(value="/kakaoLogin")
	public String kakaoLogin(@RequestParam("code") String code, HttpSession session) {
		
		String access_Token = kakao.getAccessToken(code);
	    HashMap<String, Object> userInfo = kakao.getUserInfo(access_Token);
	    System.out.println("login Controller : " + userInfo);
	    
	    //    클라이언트의 이메일이 존재할 때 세션에 해당 이메일과 토큰 등록
	    if (userInfo.get("email") != null) {
	        session.setAttribute("userId", userInfo.get("email"));
	        session.setAttribute("access_Token", access_Token);
	    }
		
        return "test.page";
	}
	
	
	@RequestMapping(value="/logout")
	public String logout(HttpSession session) {
		System.out.println("logout");
	    kakao.kakaoLogout((String)session.getAttribute("access_Token"));
	    session.removeAttribute("access_Token");
	    session.removeAttribute("userId");
	    return "sign.page";
	}
}

