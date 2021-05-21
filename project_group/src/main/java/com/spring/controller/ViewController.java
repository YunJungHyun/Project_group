package com.spring.controller;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.spring.vo.UserVO;

@Controller
public class ViewController {
	
	@RequestMapping(value="/StudyPlanner")
	public String StudyPlanner(
			Model model,
			HttpSession session
			) {
		
		System.out.println("StudyPlanner : "+ session.getAttribute("gui"));
		
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
			
			return "redirect:/StudyPlanner";
		}else {
			
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
	
	
	
}
