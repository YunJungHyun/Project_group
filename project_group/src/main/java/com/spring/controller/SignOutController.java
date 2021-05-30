package com.spring.controller;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.vo.UserVO;

import lombok.RequiredArgsConstructor;

@Controller
@CrossOrigin
@RequiredArgsConstructor
public class SignOutController {

	private final HttpServletResponse response;
	
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
}
