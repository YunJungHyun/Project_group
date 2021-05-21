package com.spring.service;

import com.spring.vo.UserVO;

public interface UserService {

	int idCheck(String userid);

	int signUp(UserVO userVO);

	int loginPwChk(UserVO userVO);

	String loginSortChk(UserVO userVO);

	UserVO getUserInfo(UserVO userVO);

	int userCodeChk(String usercode);

	int oauthSignUp(UserVO userVO);
	
}
