package com.spring.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class ViewController {
	
	@RequestMapping(value="/StudyPlanner")
	public String StudyPlanner(
			Model model
			) {
		
		System.out.println("StudyPlanner");
		
		model.addAttribute("title","LOGIN");
		
		return "sign.page";
	}
	
	@RequestMapping(value="/plannerHome")
	public String plannerHome(
			
			Model model
			) {
		
		System.out.println("plannerHome");
		
		model.addAttribute("title","HOME");
		
		return "main.page";
	}
	
	
	
}
