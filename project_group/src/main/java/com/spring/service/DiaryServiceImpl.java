package com.spring.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.spring.dao.DiaryDAO;
import com.spring.vo.DiaryVO;

@Service
public class DiaryServiceImpl implements DiaryService{

	@Inject
	DiaryDAO diaryDAO;

	@Override
	public void createDiary(String usercode) {


		diaryDAO.createDiary(usercode);
	}

	@Override
	public int insertDiary(DiaryVO diaryVO) {


		return diaryDAO.insertDiary(diaryVO);
	}
	
	@Override
	public List<DiaryVO> getAllDiaryList(String usercode) {
		// TODO Auto-generated method stub
		return diaryDAO.getAllDiaryList(usercode);
	}
	
	@Override
	public int todayWriteCheck(DiaryVO diaryVO) {
		// TODO Auto-generated method stub
		return diaryDAO.todayWriteCheck(diaryVO);
	}
}
