package com.spring.service;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.spring.dao.UserDAO;
import com.spring.vo.UserVO;

@Service
public class UserServiceImpl implements UserService {

	@Inject
	UserDAO userDAO;
	
	@Override
	public int idCheck(String userid) {
		
		return userDAO.idCheck(userid); 
	}
	@Override
	public int signUp(UserVO userVO) {
		// TODO Auto-generated method stub
		return userDAO.signUp(userVO);
	}
	
	@Override
	public int loginPwChk(UserVO userVO) {
		
		return userDAO.loginPwChk(userVO);
	}
	
	@Override
	public String loginSortChk(UserVO userVO) {
		// TODO Auto-generated method stub
		return userDAO.loginSortChk(userVO);
	}
	
	@Override
	public UserVO getUserInfo(UserVO userVO) {
		// TODO Auto-generated method stub
		return userDAO.getUserInfo(userVO);
	}
	
	@Override
	public int userCodeChk(String usercode) {
		// TODO Auto-generated method stub
		return userDAO.userCodeChk(usercode);
	} 
	@Override
	public int oauthSignUp(UserVO userVO) {
		// TODO Auto-generated method stub
		return userDAO.oauthSignUp(userVO);
	}
}	
