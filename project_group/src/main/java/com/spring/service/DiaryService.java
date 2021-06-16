package com.spring.service;

import java.util.List;

import com.spring.vo.DiaryVO;

public interface DiaryService {

	void createDiary(String usercode);

	 int insertDiary(DiaryVO diaryVO);

	List<DiaryVO> getAllDiaryList(String usercode);

	int todayWriteCheck(DiaryVO diaryVO); 

}
