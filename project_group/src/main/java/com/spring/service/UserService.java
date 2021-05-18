package com.spring.service;

import com.spring.vo.ProfileImgVO;
import com.spring.vo.UserVO;

public interface UserService {

	int idCheck(String userid);

	int signUp(UserVO userVO);

	String login(UserVO userVO);

	UserVO getUserInfo(UserVO userVO);

	int kakaoReg(UserVO userVO);

	int googleReg(UserVO userVO);

	//int insertUserImg(ProfileImgVO profileImgVO);


}
