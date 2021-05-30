package com.spring.controller;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.service.CalendarService;
import com.spring.vo.CalendarVO;

@Controller
@RequestMapping(value="/event")
public class eventController {

	@Inject
	private CalendarService calendarService;
	
	@PostMapping("/insertEvent/{usercode}")
	@ResponseBody
	public String insertEvent(
			@PathVariable(name = "usercode") String usercode
			
			) {
		System.out.println("[inserEvent]usercode : "+usercode);
		calendarService.insertEvent(usercode);
		CalendarVO calendarVO = null;
		//calendarVO.setCip("ING");
		calendarVO =calendarService.selectING(usercode);
		
		//System.out.println("calendarVO :" +calendarVO.toString());
		String pnumStr = Integer.toString(calendarVO.getPnum());
		return pnumStr;
	}
	@PostMapping("/updateEvent/{usercode}")
	@ResponseBody
	public String updateEvent(
			@PathVariable(name = "usercode") String usercode,
			CalendarVO calendarVO
			) {
		
		
		calendarVO.setUsercode(usercode);
		System.out.println("calendarVO.getPnum() :" +calendarVO.getPnum());
		
		calendarService.updateEvent(calendarVO);
		
		return "";
	}
}
