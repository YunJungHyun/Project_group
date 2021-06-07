package com.spring.service;

import java.util.HashMap;
import java.util.List;

import com.spring.vo.CalendarVO;

public interface CalendarService {

	void createPlanner(String usercode);

	List<CalendarVO> getUserPlanner(String usercode);

	void insertEvent(CalendarVO calendarVO);

	

	void updateEvent(CalendarVO calendarVO);

	List<CalendarVO> getAllEvent(String usercode);

	void deleteEvent(HashMap<String, String> map);

}
 