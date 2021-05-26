package com.spring.controller;

import java.io.File;
import java.io.IOException;

import javax.annotation.Resource;
import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.spring.service.UserService;
import com.spring.utils.UploadFileUtils;
import com.spring.vo.UserVO;

@Controller
@RequestMapping(value="/update")
public class ProfileController {


	@Inject
	private UserService userService;
	
	@Resource(name="uploadPath")
	private String uploadPath;
	
	@PostMapping(value="/profileImg")
	@ResponseBody
	public String profileImg(
			 MultipartHttpServletRequest mtfRequest,
			 UserVO userVO,
			 
			 @RequestParam(value="basic") String basic,

			HttpSession session) throws IOException, Exception {
	
		MultipartFile file = mtfRequest.getFile("profileImgFile");
		
		boolean isc = file.isEmpty();
		String filePath = mtfRequest.getSession().getServletContext().getRealPath("/resources/imgUpload");
		String fileName = null;
		
		UserVO gui = (UserVO)session.getAttribute("gui");
		String usercode = gui.getUsercode();
		String datePath = UploadFileUtils.calcPath(filePath , usercode);

		if( isc ==true && basic.equals("yes")) {
			
			userVO.setProfile_img(null);
			userVO.setThumnail_img(null);
			userVO.setUsercode(usercode);
		}else if(isc == false && basic.equals("no")){
			
			
			String oriName = file.getOriginalFilename();
			long fileSize = file.getSize();
			String ext = oriName.substring(oriName.lastIndexOf("."));
			
			
			System.out.println("oriName : "+oriName);
			System.out.println("filePath : "+filePath); 
		    
			fileName =  UploadFileUtils.fileUpload(filePath, usercode+ext, file.getBytes(), datePath); 
			
			
			
			userVO.setProfile_img(File.separator+"resources"+File.separator + "imgUpload" + datePath + File.separator + fileName);
			userVO.setThumnail_img(File.separator+"resources"+File.separator + "imgUpload" + datePath + File.separator + "thum" + File.separator + "thum_" + fileName);
			userVO.setUsercode(usercode);
		}else {
			userVO.setProfile_img(null);
			userVO.setThumnail_img(null);
			userVO.setUsercode(usercode);
		}
		
		System.out.println("프로필 이미지 경로 : "+userVO.getProfile_img());
		System.out.println("썸네일 이미지 경로 : "+userVO.getThumnail_img());
		
		int result =userService.updateProfileImg(userVO);
		
		String msg = null;
		if(result >=1 ) {
			
			System.out.println("프로필업데이트 성공");
			UserVO newGUI =userService.getUserInfoCode(usercode);
			
			session.setAttribute("gui", newGUI);
			msg = "success";
		}else {
			
			System.out.println("실패");
			msg = "fail";
		}
		
		return msg;
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
