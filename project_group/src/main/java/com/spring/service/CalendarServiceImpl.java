package com.spring.service;

import java.util.HashMap;
import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.spring.dao.CalendarDAO;
import com.spring.vo.CalendarVO;

@Service
public class CalendarServiceImpl implements CalendarService{

	@Inject
	private CalendarDAO calendarDAO;
	
	@Override
	public void createPlanner(String usercode) {
		calendarDAO.createPlanner(usercode);	
	}
	
	@Override
	public List<CalendarVO> getUserPlanner(String usercode) {
		// TODO Auto-generated method stub
		return calendarDAO.getUserPlanner(usercode);	
	}
	
	@Override
	public void insertEvent(CalendarVO calendarVO) {
		// TODO Auto-generated method stub
		calendarDAO.insertEvent(calendarVO);
	}
	
	
	 
	@Override
	public void updateEvent(CalendarVO calendarVO) {
		calendarDAO.updateEvent(calendarVO);
		
	}
	
	@Override
	public List<CalendarVO> getAllEvent(String usercode) {
		
		return calendarDAO.getAllEvent(usercode);
	}
	
	@Override
	public void deleteEvent(HashMap<String, String> map) {
		
		calendarDAO.deleteEvent(map);
	}
}
