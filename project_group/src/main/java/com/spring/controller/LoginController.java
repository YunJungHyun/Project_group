package com.spring.controller;

import java.util.HashMap;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.login.service.GoogleAPI;
import com.spring.login.service.KakaoAPI;
import com.spring.service.UserService;
import com.spring.vo.UserVO;

@Controller
public class LoginController {


	@Autowired
	private KakaoAPI kakao;

	@Autowired
	private GoogleAPI google;

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
		System.out.println("/login POST");
		String result = null;

		if(with.equals("this")) {


			result =userService.login(userVO);

			if(result.equals("loginSuccess")) {

				UserVO gui =userService.getUserInfo(userVO);
				session =request.getSession(true);
				session.setAttribute("gui", gui);
				session.setAttribute("REG", "NO");

			}


		} 
		return result;
	}

	@RequestMapping(value="/login" ,method =  RequestMethod.GET )
	public String withAPILogin(
			@RequestParam(value="with", required= false) String with
			) {
		System.out.println("/login GET");
		
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

			StringBuffer loginUrl = new StringBuffer(); //문자열을 추가하거나 변결 할 때 주로 사용하는 자료형.
			loginUrl.append("https://accounts.google.com/o/oauth2/v2/auth");
			loginUrl.append("?scope=email%20profile"); 
			loginUrl.append("%20https://www.googleapis.com/auth/user.birthday.read"); 
			loginUrl.append("%20https://www.googleapis.com/auth/user.gender.read"); 
			//loginUrl.append("&include_granted_scopes=true"); 
			loginUrl.append("&response_type=code");  
			loginUrl.append("&redirect_uri=http://localhost:8081/googleLogin"); 
			loginUrl.append("&client_id=351044074609-1jm81l8d3bvst0v67cm6ifq31nfmrft6.apps.googleusercontent.com"); 
			loginUrl.append("&access_type=offline"); 
			loginUrl.append("&approval_prompt=force"); 

			System.out.println("loginUrl.toString() :"+loginUrl.toString());

			return "redirect:"+loginUrl.toString();
		}

		return null;
	}


	@RequestMapping(value="/kakaoLogin")
	public String kakaoLogin(@RequestParam("code") String code, 
			
			HttpSession session, Model model) {
		System.out.println("/kakaoLogin");
		System.out.println("[kakao] 인가 코드 code : "+code);
		String access_Token = kakao.getAccessToken(code);
		
		if(access_Token.equals("")) {
			System.out.println("새로고침");

			return "sign.page";
		}else {

			HashMap<String, Object> userInfo = kakao.getUserInfo(access_Token);
			UserVO userVO = (UserVO)userInfo.get("userVO");


			//클라이언트의 이메일이 존재할 때 세션에 해당 이메일과 토큰 등록
			if (userInfo.get("userVO") != null) {
				int idCheckResult= userService.idCheck(userVO.getUserid());
				
				UserVO gui=(UserVO)userInfo.get("userVO");

				System.out.println("kakao gui : "+gui.toString());
				session.setAttribute("gui", gui);
				session.setAttribute("access_Token", access_Token);

				if(idCheckResult != 1) { //아이디가 없다면
					session.setAttribute("REG", "YES");
				}else {
					session.setAttribute("REG", "NO");
				}

			}

			return "between.page";
		}
	}


	@RequestMapping(value="/googleLogin")
	public String googleLogin(@RequestParam("code") String code, HttpSession session) {

		System.out.println("[google] 인가 code : " + code);
		String access_Token = google.getAccessToken(code);


		if(access_Token.equals("")) {
			System.out.println("새로고침");

			return "sign.page";

		}else {
			HashMap<String, Object> userInfo = google.getUserInfo(access_Token);

			UserVO userVO = (UserVO)userInfo.get("userVO");
			int idCheckResult = userService.idCheck(userVO.getUserid());

			//클라이언트의 이메일이 존재할 때 세션에 해당 이메일과 토큰 등록
			if (userInfo.get("userVO") != null) {
				UserVO gui=(UserVO)userInfo.get("userVO");
				session.setAttribute("gui", gui);
				session.setAttribute("access_Token", access_Token);

				if(idCheckResult != 1) {
					session.setAttribute("REG", "YES");
				}else {
					session.setAttribute("REG", "NO");
				}

			}
			return "between.page";
		}
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

