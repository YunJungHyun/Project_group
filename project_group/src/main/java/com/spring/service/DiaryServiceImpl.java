package com.spring.service;

import java.util.List;
import java.util.Map;

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
	public List<DiaryVO> getAllDiaryList(String usercode, String sort) {
		// TODO Auto-generated method stub
		return diaryDAO.getAllDiaryList(usercode, sort);
	}
	 
	@Override
	public int todayWriteCheck(DiaryVO diaryVO) {
		// TODO Auto-generated method stub
		return diaryDAO.todayWriteCheck(diaryVO);
	}
	@Override
	public int diaryDelete(DiaryVO diaryVO) {
		// TODO Auto-generated method stub
		return diaryDAO.diaryDelete(diaryVO);
	}
	
	@Override
	public int diaryUpdate(DiaryVO diaryVO) {
		// TODO Auto-generated method stub
		return  diaryDAO.diaryUpdate(diaryVO);
	}
	
	@Override
	public List<DiaryVO> getDiaryList(Map<String, String> map) {
		// TODO Auto-generated method stub
		return diaryDAO.getDiaryList(map);
	}
	
	@Override
	public List<DiaryVO> getDiaryWriteDay(String usercode) {
		// TODO Auto-generated method stub
		return diaryDAO.getDiaryWriteDay(usercode);
	}
}
