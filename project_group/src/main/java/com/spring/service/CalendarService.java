package com.spring.service;

import java.util.List;

import com.spring.vo.CalendarVO;

public interface CalendarService {

	void createPlanner(String usercode);

	List<CalendarVO> getUserPlanner(String usercode);

}
