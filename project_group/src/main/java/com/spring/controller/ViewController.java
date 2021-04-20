package com.spring.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class ViewController {
	
	@RequestMapping(value="/YoonStudy")
	public String YoonStudy(
			
			Model model
			) {
		
		System.out.println("YoonStudy.go");
		
		model.addAttribute("title","LOGIN");
		
		return "sign.page";
	}
	
}
