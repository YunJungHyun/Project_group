package com.spring.controller;

import java.io.IOException;
import java.util.HashMap;

import javax.inject.Inject;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.spring.helper.LoginType;
import com.spring.service.LoginTypeService;
import com.spring.service.UserService;
import com.spring.vo.UserVO;

import lombok.RequiredArgsConstructor;

@RestController
@RequiredArgsConstructor
@CrossOrigin
@RequestMapping("/signin")
public class SignInController {

	private final LoginTypeService loginTypeService;
	
	
	@Inject
	private UserService userService;
	
	private final HttpServletResponse response;
	private final HttpSession session;
	
	@GetMapping(value = "/SP")
	public String login(
			UserVO userVO
			
			) {
		int idCheckResult = 0;
		int pwCheckResult = 0;
		String sortCheckResult = null;
		String inputUserId =userVO.getUserid();
		System.out.println("inputUserId :"+inputUserId);

		idCheckResult  = userService.idCheck(inputUserId);

		userVO.setLoginsort("SP");

		if(idCheckResult >= 1) {

			pwCheckResult =userService.loginPwChk(userVO);
			
			if(pwCheckResult >=1) {

				sortCheckResult = userService.loginSortChk(userVO);
				
				switch (sortCheckResult) {

				case "SP" : 
					UserVO gui = userService.getUserInfo(userVO);
					
					session.setAttribute("gui", gui);
					return "loginSuccess";
					
				case "GOOGLE" :
					return "GOOGLE";
					
				case "KAKAO" : 
					return "KAKAO";
				
				default : 
					return "error";
					
				}

			}else {

				return "pwChkFail";

			}
		}else {

			return "idChkFail";
		}


	}
	
	@GetMapping(value="/{loginType}")
	public void oauthLogin(
			@PathVariable(name="loginType") LoginType loginType) throws IOException {
		
		loginTypeService.loginRequest(loginType);
	}
	
	
	@GetMapping(value="/{loginType}/oauth")
	public void kakaoRedirect(
			@PathVariable(name="loginType") LoginType loginType,
            @RequestParam(name = "code") String code
				) throws IOException {
		//System.out.println("["+loginType+"] 인가 code :"+code);
		String access_Token = loginTypeService.requestAccessToken(loginType, code);
		session.setAttribute("access_Token", access_Token);
		//System.out.println("["+loginType+"] access_Token :"+access_Token);
		
		HashMap<String, Object> userInfo =loginTypeService.getUserInfo(loginType,access_Token);
		
		UserVO userVO = (UserVO)userInfo.get("userVO");
		
		//DB에 회원으로 있는지
		int usercodeChkResult = userService.userCodeChk(userVO.getUsercode());
		
		
		if(usercodeChkResult >=1) {
			UserVO gui=userService.getUserInfo(userVO);
			System.out.println("gui "+gui.toString());
			session.setAttribute("gui", gui);
			response.sendRedirect("/plannerHome");
		}else {
			session.setAttribute("gui", userVO);
			response.sendRedirect("/addInfo");
		}
		
		
	}
	
	
}