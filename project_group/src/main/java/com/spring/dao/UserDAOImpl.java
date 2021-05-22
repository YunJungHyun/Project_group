package com.spring.dao;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Service;

import com.spring.vo.UserVO;

@Service
public class UserDAOImpl implements UserDAO {

	@Inject
	private SqlSession sqlSession;

	private static final String Namespace = "com.spring.mapper.userMapper";


	@Override
	public int idCheck(String userid) {
		
		//System.out.println("userDAOImpl :"+userid);
		int result = sqlSession.selectOne(Namespace+".idCheck", userid);
		
		return result;
	}

	@Override
	public int signUp(UserVO userVO) {
		int result = sqlSession.insert(Namespace+".signUp", userVO);
		return result;
	}
	
	@Override
	public int loginPwChk(UserVO userVO) {
		int result = sqlSession.selectOne(Namespace+".loginPwChk",userVO);
		return result;
	}
	
	@Override
	public String loginSortChk(UserVO userVO) {
		String result = sqlSession.selectOne(Namespace+".loginSortChk",userVO);
		return result;
	}
	
	@Override
	public UserVO getUserInfo(UserVO userVO) {
		UserVO result = sqlSession.selectOne(Namespace+".getUserInfo",userVO);
		return result;
	}
	
	@Override
	public int userCodeChk(String usercode) {
		int result = sqlSession.selectOne(Namespace+".userCodeChk",usercode);
		return result;
	}
	
	@Override
	public int oauthSignUp(UserVO userVO) {
		int result = sqlSession.insert(Namespace+".oauthSignUp", userVO);
		return result;
	}
	
	@Override
	public int profileUpdate(UserVO userVO) {
		
		int result =sqlSession.update(Namespace+".profileUpdate",userVO);
		return result;
	}
	
	@Override
	public UserVO getUserInfoCode(String usercode) {
		UserVO result =sqlSession.selectOne(Namespace+".getUserInfoCode",usercode);
		return result;
	}
	
	@Override
	public int beforePwChk(UserVO userVO) {
		int result =sqlSession.selectOne(Namespace+".beforePwChk",userVO);
		return result;
	}
	
	@Override
	public int pwUpdate(UserVO userVO) {
		int result =sqlSession.update(Namespace+".pwUpdate",userVO);
		return result;
	}
}
