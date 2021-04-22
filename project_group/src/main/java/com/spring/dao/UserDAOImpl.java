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
	public int idCheck(String inputId) {
		
			int result = sqlSession.selectOne(Namespace+".idCheck", inputId);
		
		return result;
	}
	
	@Override
	public int signUp(UserVO userVO) {
		int result = sqlSession.insert(Namespace+".signUp", userVO);
		return result;
	}
	
} 
