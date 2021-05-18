package com.spring.controller;

import java.sql.Date;
import java.text.ParseException;
import java.text.SimpleDateFormat;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.register.service.MailSendService;
import com.spring.service.UserService;
import com.spring.vo.UserVO;

@Controller
public class RegisterController {

	
	@Autowired
	private MailSendService mss;
	
	@Inject
	private UserService userService;
	
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
	
	@RequestMapping(value="/idCheck" , method = RequestMethod.POST)
	@ResponseBody
	public String useridChk(
			@RequestParam(value="userid") String userid
			) {
		
		
		System.out.println(userid);
		 
		int result =userService.idCheck(userid);
		
		System.out.println("result :" +result);
		String data = null;
		if (result >= 1 ) {
			
			data = "fail";
		
		}else {
			data = "success";
			
		}
		return data;
	}
	@RequestMapping(value="/signUp" , method = RequestMethod.POST)
	@ResponseBody
	public String signUp(
			
			UserVO userVO,
			HttpSession session
			) {
			System.out.println("/signUp? userVO.toString : "+userVO.toString());
			String with = userVO.getLoginsort();
			if(with != null) {
			
				UserVO gui =(UserVO)session.getAttribute("gui");
				userVO.setUserpw("none");
				
				if(with.equals("kakao")) {
					userVO.setGender(gui.getGender());
				}
				userVO.setUserid(gui.getUserid());
				userVO.setUsercode(gui.getUsercode());
		    	userVO.setProfile_img(gui.getProfile_img());
		    	userVO.setThumnail_img(gui.getThumnail_img());
		    	userVO.setLoginsort(with);
				
			}else {
				
				userVO.setLoginsort("SP");
			}
			
			// 생일 날짜 변환
			SimpleDateFormat beforeFormat = new SimpleDateFormat("yyyymmdd");
	        // Date로 변경하기 위해서는 날짜 형식을 yyyy-mm-dd로 변경해야 한다.
	        SimpleDateFormat afterFormat = new SimpleDateFormat("yyyy-mm-dd");
	        
	        java.util.Date tempDate = null;
	        
	        try {
	           
	        	// 현재 yyyymmdd로된 날짜 형식으로 java.util.Date객체를 만든다.
	            tempDate = beforeFormat.parse(userVO.getStrBirth());
	       
	        } catch (ParseException e) {
	            e.printStackTrace();
	        }
	        
	        // java.util.Date를 yyyy-mm-dd 형식으로 변경하여 String로 반환한다.
	        String transDate = afterFormat.format(tempDate);
	        
	        // 반환된 String 값을 Date로 변경한다.
	        Date birth = Date.valueOf(transDate);
	        
	        userVO.setBirth(birth);
	       
	        int result =userService.signUp(userVO);
				
			session.setAttribute("gui", userVO);
			
		return "redirect:/plannerHome"; 
	}
	
}
