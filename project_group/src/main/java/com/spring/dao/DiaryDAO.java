package com.spring.dao;

import java.util.List;
import java.util.Map;

import com.spring.vo.DiaryVO;

public interface DiaryDAO {

	void createDiary(String usercode);

	int insertDiary(DiaryVO diaryVO);

	List<DiaryVO> getAllDiaryList(String usercode,String sort);

	int todayWriteCheck(DiaryVO diaryVO);

	int diaryDelete(DiaryVO diaryVO);

	int diaryUpdate(DiaryVO diaryVO);

	List<DiaryVO> getDiaryList(Map<String, String> map);


}
