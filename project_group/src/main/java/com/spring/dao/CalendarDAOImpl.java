package com.spring.dao;

import java.util.HashMap;
import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Service;

import com.spring.vo.CalendarVO;

@Service
public class CalendarDAOImpl implements CalendarDAO{

	@Inject
	private SqlSession sqlSession;

	private static final String Namespace = "com.spring.mapper.calendarMapper";



	@Override
	public void createPlanner(String usercode) {

		HashMap map =new HashMap();

		String sql = "CREATE TABLE `planner_"+usercode+"` (";
		sql += "`pnum` INT(20) NOT NULL AUTO_INCREMENT,"
				+"`ptitle` VARCHAR(50) NULL DEFAULT 'none',"
				+"`pmemo` VARCHAR(200) NULL DEFAULT 'none',"
				+"`startDay` TIMESTAMP NOT NULL DEFAULT '0000-00-00 00:00:00',"					
				+"`endDay` TIMESTAMP NOT NULL DEFAULT '0000-00-00 00:00:00',"					
				+"`color` VARCHAR(20) NULL DEFAULT 'none',"					
				+"`allDay` VARCHAR(5) NULL,"										
				+"PRIMARY KEY (`pnum`) USING BTREE";
		sql += ")";
		sql +=" COLLATE='utf8_general_ci' ";
		sql +=" ENGINE=InnoDB ";
		sql +=" AUTO_INCREMENT=1 ";
 
		map.put("sql", sql);


		sqlSession.update(Namespace+ ".createPlanner", map);

	}

	@Override
	public List<CalendarVO> getUserPlanner(String usercode) { 
		HashMap map =new HashMap();

		String sql ="SELECT * FROM " 
				+ "`planner_"+usercode+"`";
		map.put("sql", sql);
		List<CalendarVO> result = sqlSession.selectList(Namespace+".getUserPlanner", map);
		return result;
	}

	@Override
	public void insertEvent(CalendarVO calendarVO) {

		System.out.println("[daoImpl] :"+calendarVO.toString());
		sqlSession.insert(Namespace+".insertEvent", calendarVO);

	}
	
	
	@Override
	public void updateEvent(CalendarVO calendarVO) { 
		
		HashMap map =new HashMap();

		String sql ="UPDATE `planner_"+calendarVO.getUsercode()+"` "
				+ "SET cip = 'TRUE' "
				+ "where pnum ="+calendarVO.getPnum();

		map.put("sql", sql);
		
		
		sqlSession.update(Namespace+".updateEvent",map);
		
	}
	
	@Override
	public List<CalendarVO> getAllEvent(String usercode) {
		HashMap map =new HashMap();

		String sql ="SELECT * FROM " 
				+ "`planner_"+usercode+"`";

		map.put("sql", sql);
		
		List<CalendarVO> result = sqlSession.selectList(Namespace+".getAllEvent",map);
		return result;
	}
}
