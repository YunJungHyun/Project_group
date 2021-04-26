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
	public int idCheck(String userid) {
		
		return userDAO.idCheck(userid); 
	}
	@Override
	public int signUp(UserVO userVO) {
		return userDAO.signUp(userVO); 
	}
	
	@Override
	public String login(UserVO userVO) {
	
		return userDAO.login(userVO);
	}
	
	@Override
	public UserVO getUserInfo(UserVO userVO) {
		// TODO Auto-generated method stub
		return userDAO.getUserInfo(userVO);
	}
	
	@Override
	public int kakaoReg(UserVO userVO) {
		// TODO Auto-generated method stub
		return userDAO.kakaoReg(userVO);
	}
}
