package com.spring.dao;

import com.spring.vo.UserVO;

public interface UserDAO {

	int idCheck(String userid);

	int signUp(UserVO userVO);

	String login(UserVO userVO);

	UserVO getUserInfo(UserVO userVO);

	

}
