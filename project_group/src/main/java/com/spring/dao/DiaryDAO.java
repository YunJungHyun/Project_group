package com.spring.dao;

import java.util.List;

import com.spring.vo.DiaryVO;

public interface DiaryDAO {

	void createDiary(String usercode);

	int insertDiary(DiaryVO diaryVO);

	List<DiaryVO> getAllDiaryList(String usercode);

	int todayWriteCheck(DiaryVO diaryVO); 


}
