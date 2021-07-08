package com.spring.controller;

import java.io.IOException;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.service.UserService;
import com.spring.vo.UserVO;

import lombok.RequiredArgsConstructor;

@Controller
@CrossOrigin
@RequiredArgsConstructor
public class SignOutController {

	private final HttpServletResponse response;

	@Inject
	UserService userService;

	@RequestMapping("/logout")
	@ResponseBody
	public String logout(

			HttpSession session,
			HttpServletRequest request

			) throws IOException {

		UserVO gui =(UserVO)session.getAttribute("gui");

		String loginsort = gui.getLoginsort();

		System.out.println("loginsort:"+loginsort);

		session.invalidate();



		return "logoutSuccess";
	}



	@RequestMapping("/secessionPwChk")
	@ResponseBody
	public String secessionPwChk(

			@RequestParam(value="inputpw") String inputpw,
			HttpSession session 

			) throws IOException {

		UserVO gui =(UserVO)session.getAttribute("gui");

		String userid = gui.getUserid();

		int result = userService.secessionPwChk(inputpw , userid);

		System.out.println("회원 탈퇴 :" + result);
		String resultStr = "";


		if (result > 0) {

			resultStr = "pwChkSuccess";
		}else {


			resultStr = "pwChkFail";
		}
		return resultStr;
	}
	@RequestMapping("/userDelete")
	@ResponseBody
	public String userDelete(


			HttpSession session 

			) throws IOException {

		UserVO gui = (UserVO)session.getAttribute("gui");
		
		userService.userDelete(gui);
		
//		String loginSort = gui.getLoginsort();
//		
//		switch (loginSort) {
//			case "KAKAO" :
//					
//			case "GOOGLE" :
//			
//			default :
//					
//		
//		}
		session.invalidate();
		return "";


	}



}
