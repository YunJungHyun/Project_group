package com.spring.dao;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Service;

import com.spring.vo.UserVO;

@Service
public class UserDAOImpl  implements UserDAO{

	
	@Inject
	private SqlSession sqlSession;
	
	private static final String Namespace = "com.spring.mapper.userMapper";
	
	
	@Override
	public int idCheck(String userid) {
		
			int result = sqlSession.selectOne(Namespace+".idCheck", userid);
		
		return result;
	}
	
	@Override
	public int signUp(UserVO userVO) {
		int result = sqlSession.insert(Namespace+".signUp", userVO);
		
		//System.out.println("userVO : "+userVO.toString());
		return result;
	}
	
	@Override
	public String login(UserVO userVO) {
		
		int idChk =sqlSession.selectOne(Namespace+".idCheck", userVO.getUserid());
		
		String result = null;
		if(idChk == 1) {
			
			
			int pwChk =sqlSession.selectOne(Namespace +".loginPwChk", userVO);
			
			if(pwChk ==1) {
				
			
					result="loginSuccess";
			}else {
				
				
				
				result ="pwChkFail";
			}
						
		}else {
			
			
			result ="idChkFail";
		}
		
		return result;
	}
	
	
	@Override
	public UserVO getUserInfo(UserVO userVO) {
		
		UserVO result = sqlSession.selectOne(Namespace+".getUserInfo", userVO);
		
		return result;
	}
	
	
	@Override
	public int kakaoReg(UserVO userVO) {
		
		int result = sqlSession.insert(Namespace+".kakaoReg", userVO);
		return result;
	}
	
	@Override
	public int googleReg(UserVO userVO) {
		int result = sqlSession.insert(Namespace+".googleReg", userVO);
		return result;
	}
} 
