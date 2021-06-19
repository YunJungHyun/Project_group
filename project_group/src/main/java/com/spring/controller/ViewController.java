package com.spring.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.service.CalendarService;
import com.spring.service.DiaryService;
import com.spring.vo.DiaryVO;
import com.spring.vo.UserVO;

@Controller
public class ViewController {
	
	@Inject
	private CalendarService calendarService;
	
	@Inject
	private DiaryService diaryService;
	
	@RequestMapping(value="/YooNPlanner")
	public String YooNPlanner(
			Model model,
			HttpSession session
			) {
		
		System.out.println("YooNPlanner : "+ session.getAttribute("gui"));
		
		UserVO gui =(UserVO)session.getAttribute("gui");
		if(gui == null) {
			
			System.out.println("유저정보가 없습니다.");
			System.out.println("access_token :"+ session.getAttribute("access_token"));
		}else {
			
			session.invalidate();
		}
		
		model.addAttribute("title","LOGIN");
			
		return "sign.page";
	}
	

	
	
	@RequestMapping(value="/plannerHome") 
	public String plannerHome(
			HttpSession session,
			Model model,
			@RequestParam(value="viewName", required = false) String viewName
			) {
		
		UserVO gui = (UserVO)session.getAttribute("gui");
		
		if(gui == null) {
			
			return "redirect:/YooNPlanner";
		}else {
			
			
			if(viewName == null) {
				
				viewName = "dayGridMonth";
			}
			model.addAttribute("viewName",viewName);
			model.addAttribute("title","HOME");
			
			
			return "calendar.page";
		}
		
		
	}
	
	@RequestMapping(value="/addInfo")
	public String between(Model model) {
		System.out.println("between");
		
		model.addAttribute("title","MEMBER");
		
		return "between.page";
	}
	
	@RequestMapping(value="/diaryWrite")
	public String diaryWrite(
			HttpSession session,
			Model model
			) {
		
		UserVO gui = (UserVO)session.getAttribute("gui");
		
		if(gui == null) {
			
			return "redirect:/YooNPlanner";
		}else {
			
			//List<CalendarVO> gup =calendarService.getUserPlanner(gui.getUsercode());
			//System.out.println("gup.size():"+gup.size());
			//session.setAttribute("gup", gup);
			model.addAttribute("title","DIARY");
			return "diaryWrite.page";
		}
		
		
	}
	
	
	@RequestMapping(value="/diaryList")
	public String diaryList(
			HttpSession session,
			Model model
			) {
		
		UserVO gui = (UserVO)session.getAttribute("gui");
		
		if(gui == null) {
			
			return "redirect:/YooNPlanner";
		}else {
			model.addAttribute("title","DIARY");
			
			return "diaryList.page";
		}

	}
	
	@RequestMapping(value="getDiaryList" , method= RequestMethod.POST)
	@ResponseBody
	public List<DiaryVO> getDiaryList(
			HttpSession session,
			@RequestParam(value="yearMonth", required = true) String yearMonth,
			@RequestParam(value="sort", required = true) String sort
			){
	
		
		UserVO gui=(UserVO)session.getAttribute("gui");
		
		String usercode = gui.getUsercode();
		
		Map<String,String> map = new HashMap<String,String>();
		
		map.put("usercode", usercode);
		map.put("yearMonth", yearMonth);
		map.put("sort", sort);
		
		List<DiaryVO> dlist =diaryService.getDiaryList(map);
		// System.out.println("dlist :" + dlist.size());
		return dlist;
	}
	
}
