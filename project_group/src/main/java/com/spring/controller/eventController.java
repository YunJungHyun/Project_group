package com.spring.controller;

import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.spring.service.CalendarService;
import com.spring.vo.CalendarVO;

@Controller
@RequestMapping(value = "/event" , produces = "application/text; charset=UTF-8")
public class eventController {

	@Inject
	private CalendarService calendarService;

	@PostMapping("/insertEvent/{usercode}")
	@ResponseBody
	public String insertEvent(@PathVariable(name = "usercode") String usercode, CalendarVO calendarVO)
			throws ParseException {
		
		
		Timestamp startDay= calendarVO.getStartDay();
		Timestamp endDay= calendarVO.getEndDay();
		if(calendarVO.getAllDay().equals("false")) {
			
			String startTimeStr = calendarVO.getStartTime();
			String endTimeStr = calendarVO.getEndTime();
			
			String[] startTimeArr =startTimeStr.split(":");
			String[] endTimeArr =endTimeStr.split(":");
			startDay.setHours(Integer.parseInt(startTimeArr[0]));
			startDay.setMinutes(Integer.parseInt(startTimeArr[1]));
			
			endDay.setHours(Integer.parseInt(endTimeArr[0]));
			endDay.setMinutes(Integer.parseInt(endTimeArr[1]));
			calendarVO.setStartDay(startDay);
			calendarVO.setEndDay(endDay);
			
			System.out.println("시간넣음 시작 :"+calendarVO.getStartDay());
			System.out.println("시간넣음 끝 :"+calendarVO.getEndDay());
		}else {
			
			startDay.setHours(0);
			startDay.setMinutes(0);
			endDay.setHours(0);
			endDay.setMinutes(0);
			
			calendarVO.setStartDay(startDay);
			calendarVO.setEndDay(endDay);
			
			System.out.println("시간 안 넣음 시작 :"+calendarVO.getStartDay());
			System.out.println("시간 안 넣음 끝 :"+calendarVO.getEndDay());
		}
	
		calendarService.insertEvent(calendarVO);
		return "";
	}
	@PostMapping("/updateEvent/{usercode}")
	@ResponseBody
	public String updateEvent(
			@PathVariable(name = "usercode") String usercode,
			CalendarVO calendarVO
			) {
		Timestamp startDay= calendarVO.getStartDay();
		Timestamp endDay= calendarVO.getEndDay();
		
		if(calendarVO.getAllDay().equals("false")) {
			
			String startTimeStr = calendarVO.getStartTime();
			String endTimeStr = calendarVO.getEndTime();
			
			
			String[] startTimeArr =startTimeStr.split(":");
			String[] endTimeArr =endTimeStr.split(":");
			startDay.setHours(Integer.parseInt(startTimeArr[0]));
			startDay.setMinutes(Integer.parseInt(startTimeArr[1]));
			
			endDay.setHours(Integer.parseInt(endTimeArr[0]));
			endDay.setMinutes(Integer.parseInt(endTimeArr[1]));
			calendarVO.setStartDay(startDay);
			calendarVO.setEndDay(endDay);
			
			System.out.println("시간넣음 시작 :"+calendarVO.getStartDay());
			System.out.println("시간넣음 끝 :"+calendarVO.getEndDay());
		}else {
			
			startDay.setHours(0);
			startDay.setMinutes(0);
			endDay.setHours(0);
			endDay.setMinutes(0);
			
			calendarVO.setStartDay(startDay);
			calendarVO.setEndDay(endDay);
			
			System.out.println("시간 안 넣음 시작 :"+calendarVO.getStartDay());
			System.out.println("시간 안 넣음 끝 :"+calendarVO.getEndDay());
		}
		
		calendarService.updateEvent(calendarVO);
		System.out.println("calendarVO.toString() :" +calendarVO.toString());
		return "";
	}
	
	@PostMapping("/deleteEvent/{usercode}")
	@ResponseBody
	public String deleteEvent(
			@PathVariable(name="usercode") String usercode,
			@RequestParam(value ="pnum") String pnum
			) {
		
		System.out.println("pnum : "+pnum +", usercode : "+usercode);
		
		HashMap<String, String > map = new HashMap<String, String>();
		map.put("usercode", usercode);
		map.put("pnum", pnum);
		calendarService.deleteEvent(map);
		return "";
	}

	@PostMapping("/getAllEvent/{usercode}")
	@ResponseBody
	public String getAllEvent(@PathVariable(name = "usercode") String usercode) {

		List<CalendarVO> calendarList = calendarService.getAllEvent(usercode);
		//System.out.println("이벤트 갯수 : " + calendarList.size());
		JsonObject jsonobject = new JsonObject();

		JsonArray infoArray = new JsonArray();
		
		
		
		for (int i = 0; i < calendarList.size(); i++) {

			SimpleDateFormat transFormat = null;
			SimpleDateFormat timeFormat = null;
			String startday =null;
			String endday =null;
			CalendarVO calendarVO = calendarList.get(i);
			transFormat = new SimpleDateFormat("yyyy-MM-dd");
			timeFormat = new SimpleDateFormat("HH:mm:ss");
			Timestamp end  = calendarVO.getEndDay();
			
			
			
			boolean allDay= true;
			
		
			
			if(calendarVO.getAllDay().equals("false")) {
				
				startday = transFormat.format(calendarVO.getStartDay())+"T"+timeFormat.format(calendarVO.getStartDay());
				endday = transFormat.format(end)+"T"+timeFormat.format(end);
					
				allDay= false;
			
			}else {
					
				end.setDate(end.getDate()+1);	
				startday = transFormat.format(calendarVO.getStartDay());
				endday = transFormat.format(end);
				
				
				allDay= true;

			}
				
			
			JsonObject calendarRow = new JsonObject();
			
			calendarRow.addProperty("id", calendarVO.getPnum());
			calendarRow.addProperty("title", calendarVO.getPtitle());
			calendarRow.addProperty("start", startday);
			calendarRow.addProperty("end", endday);
			calendarRow.addProperty("color", calendarVO.getColor());
			calendarRow.addProperty("allDay", allDay);
			calendarRow.addProperty("memo", calendarVO.getPmemo());
			
			
			infoArray.add(calendarRow);
		}

		jsonobject.add("events", infoArray);
		//System.out.println(jsonobject);

		Gson gson = new GsonBuilder().setPrettyPrinting().create();
		String json = gson.toJson(jsonobject);

		return json;
	}

}
