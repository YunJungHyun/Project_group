package com.spring.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
import java.text.ParseException;
import java.text.SimpleDateFormat;

import javax.inject.Inject;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.register.service.MailSendService;
import com.spring.service.CalendarService;
import com.spring.service.UserService;
import com.spring.vo.UserVO;

@Controller
public class SignUpController {


	@Autowired
	private MailSendService mss;

	@Inject
	private UserService userService;

	@Inject
	private CalendarService calendarService;
	
	private HttpSession session;

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
	public void signUp(
			UserVO userVO,
			HttpServletResponse response
			) {


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

		String usercode =random();
		
		userVO.setUsercode(usercode);
		int result =userService.signUp(userVO);


		response.setContentType("text/html; charset=UTF-8");

		PrintWriter out = null; 
		try {
			out = response.getWriter();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		if(result > 0) {
			
			
			calendarService.createPlanner(usercode);
			
			out.println("<script>alert('회원가입 완료 되었습니다'); location.href='/StudyPlanner'</script>");

			out.flush();
		}else{

			out.println("<script>alert('회원가입 실패하였습니다.' ); location.href='/StudyPlanner'</script>");

			out.flush();

		}
	} 
	
	public String random() {
		//랜덤 숫자 발생
		String usercode ="s-";
				
		for(int i = 0 ; i < 10 ; i++) {

			int randomNumber =(int)((Math.random()*10000)%10);
			String strNumber = Integer.toString(randomNumber);
			usercode += strNumber;
		}
		
		int x= userService.userCodeChk(usercode);
		
		if(x >=1 ) {
			return random();
		}else {
			return usercode;
		}
	
	}

	@RequestMapping(value="/oauthSignUp" , method=RequestMethod.POST)
	public void oauthSignUp(
			UserVO userVO,
			HttpServletResponse response,
			HttpSession session
			) {



		//System.out.println("oauthSignUp userVO.toString : "+ userVO.toString());


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


		int result =userService.oauthSignUp(userVO);

		response.setContentType("text/html; charset=UTF-8");

		PrintWriter out = null;
		try {
			out = response.getWriter();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}


		if(result >= 1) {
			

			
			calendarService.createPlanner(userVO.getUsercode());
			
			session.setAttribute("gui", userVO);
			
			out.println("<script>alert('회원가입 완료 되었습니다'); location.href='/plannerHome'</script>");

			out.flush();
		}else{

			out.println("<script>alert('회원가입 실패하였습니다.' ); location.href='/StudyPlanner'</script>");
 
			out.flush();

		}
	}
}
