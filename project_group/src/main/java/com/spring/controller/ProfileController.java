package com.spring.controller;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.spring.service.UserService;
import com.spring.vo.UserVO;

@Controller
@RequestMapping(value="/update")
public class ProfileController {


	@Inject
	private UserService userService;

	@PostMapping(value="/profileImg")
	@ResponseBody
	public void profileImg(
			MultipartHttpServletRequest request,
			HttpSession session) {

		
		
	}

	@PostMapping(value="/profileUpdate")
	@ResponseBody
	public String profileUpdate(
			UserVO userVO, HttpSession session
			) { 

		System.out.println("profileUpdate : "+userVO.toString());

		int result = userService.profileUpdate(userVO);
		String message = null;
		if(result >=1 ) {

			System.out.println("회원 정보 업데이트");
			UserVO gui = userService.getUserInfoCode(userVO.getUsercode());
			System.out.println("gui toString : "+ gui.toString());
			session.setAttribute("gui", gui);
			message = "updateSuccess";
		}else {
			System.out.println("회원 정보 업데이트 실패");
			message = "updateFail";
		}


		return message;
	}

	@PostMapping(value="/beforePwChk")
	@ResponseBody
	public String beforePwChk(
			UserVO userVO, HttpSession session
			) { 

		//System.out.println("beforePwChk : "+userVO.toString());

		int result = userService.beforePwChk(userVO);

		//System.out.println("beforePwChk result : "+result);
		String message = null;
		if(result >= 1) {

			System.out.println("기존 비밀번호 같음 ");
			message = "beforePwSuccess";
		}else {

			System.out.println("기존 비밀번호 다름");
			message = "beforePwfail";
		}

		return message;
	}
	@PostMapping(value="/pwUpdate")
	@ResponseBody
	public String pwUpdate(
			UserVO userVO, HttpSession session
			) { 

		System.out.println("pwUpdate : "+userVO.toString());

		int result = userService.pwUpdate(userVO);

		String message=null;

		if(result >=1 ) {

			System.out.println("회원 정보 업데이트");
			UserVO gui = userService.getUserInfoCode(userVO.getUsercode());
			System.out.println("gui toString : "+ gui.toString());
			session.setAttribute("gui", gui);
			message = "updateSuccess";
		}else {
			System.out.println("회원 정보 업데이트 실패");
			message = "updateFail";
		}
		return message;
	}
}
