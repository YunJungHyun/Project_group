package com.spring.service;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.spring.dao.DiaryDAO;

@Service
public class DiaryServiceImpl implements DiaryService{
	
	@Inject
	DiaryDAO diaryDAO;
	
	@Override
	public void createDiary(String usercode) {
	 
		
		diaryDAO.createDiary(usercode);
	}
}
