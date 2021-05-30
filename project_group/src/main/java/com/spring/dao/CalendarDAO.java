package com.spring.dao;

import java.util.List;

import com.spring.vo.CalendarVO;

public interface CalendarDAO {

	void createPlanner(String usercode);

	List<CalendarVO> getUserPlanner(String usercode);

	void insertEvent(String usercode);

	CalendarVO selectING(String usercode);

	void updateEvent(CalendarVO calendarVO);

	
}
