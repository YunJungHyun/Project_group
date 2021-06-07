package com.spring.controller;

import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.spring.service.CalendarService;
import com.spring.vo.CalendarVO;
import com.spring.vo.UserVO;

@Controller
public class ViewController {
	
	@Inject
	private CalendarService calendarService;
	
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
			Model model
			) {
		
		UserVO gui = (UserVO)session.getAttribute("gui");
		
		if(gui == null) {
			
			return "redirect:/YooNPlanner";
		}else {
			
			//List<CalendarVO> gup =calendarService.getUserPlanner(gui.getUsercode());
			//System.out.println("gup.size():"+gup.size());
			//session.setAttribute("gup", gup);
			model.addAttribute("title","HOME");
			return "main.page";
		}
		
		
	}
	
	@RequestMapping(value="/addInfo")
	public String between(Model model) {
		System.out.println("between");
		
		model.addAttribute("title","MEMBER");
		
		return "between.page";
	}
	
	@RequestMapping(value="/calendar")
	public String month(
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
			model.addAttribute("title","CALENDAR");
			return "calendar.page";
		}
		
		
	}
	@RequestMapping(value="/diary")
	public String diary(
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
			return "diary.page";
		}
		
		
	}
	
	
}
