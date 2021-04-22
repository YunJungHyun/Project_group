package com.spring.service;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.spring.dao.UserDAO;
import com.spring.vo.UserVO;

@Service
public class UserServiceImpl implements UserService{
	
	
	@Inject
	UserDAO userDAO;
	
	@Override
	public int idCheck(String inputId) {
		
		return userDAO.idCheck(inputId); 
	}
	@Override
	public int signUp(UserVO userVO) {
		// TODO Auto-generated method stub
		return userDAO.signUp(userVO); 
	}
	
}
