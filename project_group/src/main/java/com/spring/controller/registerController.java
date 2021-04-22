package com.spring.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.register.service.MailSendService;

@Controller
public class registerController {

	
	@Autowired
	private MailSendService mss;
	
	@RequestMapping(value="/emailCheck")
	@ResponseBody
	public String emailCheck(
			@RequestParam(value="inputEmail") String inputEmail
			) {
		System.out.println(inputEmail);
		//임의의 authKey 생성 & 이메일 발송
        String authKey = mss.sendAuthMail(inputEmail);
        System.out.println(authKey +": 발송성공");
        return authKey;
	}
}
