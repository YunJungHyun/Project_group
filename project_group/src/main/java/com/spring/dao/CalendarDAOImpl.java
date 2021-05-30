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
				+"`plantitle` VARCHAR(50) NOT NULL,"
				+"`plan` VARCHAR(200) NULL DEFAULT 'none',"
				+"`start` TIMESTAMP NOT NULL,"					
				+"`end` TIMESTAMP NOT NULL,"					
				+"`color` VARCHAR(20) NOT NULL,"					
				+"`starttime` TIMESTAMP NOT NULL,"					
				+"`endtime` TIMESTAMP NOT NULL,"					
				+"PRIMARY KEY (`pnum`) USING BTREE";
		sql += ")";
		sql +=" COLLATE='utf8_general_ci' ";
		sql +=" ENGINE=InnoDB ";
		sql +=" AUTO_INCREMENT=109 ";
		
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
}
