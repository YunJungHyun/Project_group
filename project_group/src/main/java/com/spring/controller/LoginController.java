package com.spring.controller;

import java.util.HashMap;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.login.service.KakaoAPI;
import com.spring.service.UserService;
import com.spring.vo.UserVO;

@Controller
public class LoginController {
	
	
	@Autowired
	private KakaoAPI kakao;
	
	@Inject
	UserService userService;
	
	HttpSession session;
	
	@RequestMapping(value="/login" , method =RequestMethod.POST )
	@ResponseBody
	public String login(
			
			@RequestParam(value="with", required= false) String with,
			UserVO userVO,
			HttpServletRequest request
		
			) {
		
		String result = null;
	
		if(with.equals("this")) {
			
			
			result =userService.login(userVO);
			
			if(result.equals("loginSuccess")) {
				
				UserVO gui =userService.getUserInfo(userVO);
				session =request.getSession(true);
				session.setAttribute("gui", gui);
				
			}
			
			
		}
		return result;
	}
	
	@RequestMapping(value="/login" ,method =  RequestMethod.GET )
	public String withAPILogin(
			
			@RequestParam(value="with", required= false) String with
			) {
		
		if(with.equals("kakao")) {
			
			StringBuffer loginUrl = new StringBuffer(); //문자열을 추가하거나 변결 할 때 주로 사용하는 자료형.
			loginUrl.append("https://kauth.kakao.com/oauth/authorize?client_id=");
			loginUrl.append("78553ffd86a12678fb1148721501f748"); //카카오 앱에 있는 REST KEY
			loginUrl.append("&redirect_uri=");
			loginUrl.append("http://localhost:8081/kakaoLogin"); //카카오 앱에 등록한 redirect URL
			loginUrl.append("&response_type=code");
		
			System.out.println("loginUrl.toString() :"+loginUrl.toString());
		return "redirect:"+loginUrl.toString();
		}else if(with.equals("google")) {
			
			
		
		}
		
		return null;
	}
	
	
	@RequestMapping(value="/kakaoLogin")
	public String kakaoLogin(@RequestParam("code") String code, HttpSession session) {
		
		System.out.println("인가 코드 code : "+code);
		String access_Token = kakao.getAccessToken(code);
	    
		HashMap<String, Object> userInfo = kakao.getUserInfo(access_Token);
	    
	    System.out.println("login Controller : " + userInfo.toString());
	    
	    if(userInfo.get("kakaoReg") == "yes") {
	    	
	    	int kakaoRegResult =userService.kakaoReg((UserVO)userInfo.get("userVO"));
	    	
	    }
	    
	    
	    
	    //클라이언트의 이메일이 존재할 때 세션에 해당 이메일과 토큰 등록
	    if (userInfo.get("userVO") != null) {
	    	UserVO gui=(UserVO)userInfo.get("userVO");
	    	
	    	session.setAttribute("gui", gui);
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
	@RequestMapping(value="/unlink")
	public String unlink(HttpSession session) {
		
		System.out.println("kakao unlink");
		
		kakao.unlink((String)session.getAttribute("access_Token"));
		
		return "sign.page";
	}
	@RequestMapping(value="/kakaoWithLogout")
	public String kakaoWithLogout(HttpSession session) {
		
		
		kakao.kakaoWithLogout();
		return "sign.page";
	}
	
	
}

