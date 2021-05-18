package com.spring.controller;

import java.io.IOException;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.spring.service.UserService;
import com.spring.vo.ProfileImgVO;

@Controller
public class UserController {
	
	@Inject
	UserService userService;
	
	@RequestMapping(value="profile/upload" , method= RequestMethod.POST)
	@ResponseBody
	public void photoUpload(ProfileImgVO profileImgVO, HttpSession session) throws IOException {
		
		System.out.println("profileImgVO.toString : " +profileImgVO.toString());
		MultipartFile mfile = profileImgVO.getFile();  
		
		
		profileImgVO.setProfileName(mfile.getOriginalFilename());
		profileImgVO.setProfileSize(mfile.getSize());
		profileImgVO.setProfileContentType( mfile.getContentType());
		profileImgVO.setProfileData(mfile.getBytes());
		
		System.out.println("mfile.toString : "+ mfile.toString());
		//userService.insertUserImg(profileImgVO);
		
	}
}
