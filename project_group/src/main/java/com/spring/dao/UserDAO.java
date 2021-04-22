package com.spring.dao;

import com.spring.vo.UserVO;

public interface UserDAO {

	int idCheck(String inputId);

	int signUp(UserVO userVO);

	

}
