package com.spring.controller;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.service.DiaryService;
import com.spring.vo.DiaryVO;
import com.spring.vo.UserVO;

@Controller
public class DiaryController {

	@Inject
	private DiaryService diaryService;

	@RequestMapping(value="/diaryInsert")
	@ResponseBody
	public String diaryInsert(
			DiaryVO diaryVO
			) {

		System.out.println("diaryVO.toString : "+diaryVO.toString());

		int result = diaryService.insertDiary(diaryVO);

		String str =null;

		if(result >= 1 ) {

			str = "success";
		}else {

			str = "fail";
		}

		return str;
	}

	@RequestMapping(value="/todayWriteCheck")
	@ResponseBody
	public String todayWriteCheck(
			DiaryVO diaryVO
			) {

		System.out.println("diaryVO.toString : "+diaryVO.toString());

		int result = diaryService.todayWriteCheck(diaryVO);

		String str =null;

		if(result >= 1 ) {

			str = "fail";

		}else {

			str = "success";
		}

		return str;
	}
	@RequestMapping(value="/diaryDelete")
	@ResponseBody
	public String diaryDelete(
			DiaryVO diaryVO
			) {

		System.out.println("diaryDelete diaryVO.toString : "+diaryVO.toString());

		int result = diaryService.diaryDelete(diaryVO);

		String str =null;


		if(result >= 1 ) {

			str = "success";

		}else {

			str = "fail"; 
		}


		return str;
	}
	@RequestMapping(value="/diaryUpdate")
	@ResponseBody
	public String diaryUpdate(
			DiaryVO diaryVO
			) {
		
		System.out.println("diaryUpdate diaryVO.toString : "+diaryVO.toString());
		
		int result = diaryService.diaryUpdate(diaryVO);
		
		String str =null;
		
		
		if(result >= 1 ) {
			
			str = "success";
			
		}else {
			
			str = "fail"; 
		}
		
		
		return str;
	}
	@RequestMapping(value="/getDiaryWriteDay")
	@ResponseBody
	public List<String> getDiaryWriteDay(
		HttpSession session
		) {
		
		UserVO gui = (UserVO)session.getAttribute("gui");
	
		List<DiaryVO> wdList = diaryService.getDiaryWriteDay(gui.getUsercode());
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		List<String> chgList = new ArrayList<String>();
		for(int i = 0 ; i < wdList.size(); i++) {
			
			Timestamp writeDay = wdList.get(i).getWriteDay();
			
			String chgWriteDay =sdf.format(writeDay);
			chgList.add(chgWriteDay);
		}
		
		
		return chgList;
	}

}
