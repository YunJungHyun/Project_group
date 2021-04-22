package com.spring.service;

import com.spring.vo.UserVO;

public interface UserService {

	int idCheck(String inputId);

	int signUp(UserVO userVO);


}
