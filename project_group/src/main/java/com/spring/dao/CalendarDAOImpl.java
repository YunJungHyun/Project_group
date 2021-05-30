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
		HashMap map2 =new HashMap();

		String sql = "CREATE TABLE `planner_"+usercode+"` (";
		sql += "`pnum` INT(20) NOT NULL AUTO_INCREMENT,"
				+"`plantitle` VARCHAR(50) NULL DEFAULT 'none',"
				+"`plan` VARCHAR(200) NULL DEFAULT 'none',"
				+"`start` TIMESTAMP  DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,"					
				+"`end` TIMESTAMP  DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,"					
				+"`color` VARCHAR(20) NULL DEFAULT 'none',"					
				+"`starttime` TIMESTAMP  DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,"					
				+"`endtime` TIMESTAMP  DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,"					
				+"`cip` VARCHAR(10) NULL DEFAULT 'FALSE',"
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
	public void insertEvent(String usercode) {



		HashMap map =new HashMap();

		String sql ="INSERT INTO " 
				+ "`planner_"+usercode+"`"
				+ "(cip)"
				+ "VALUES('ING')"; // 1 > 진행중

		map.put("sql", sql);

		sqlSession.insert(Namespace+".insertEvent", map);

	}
	
	@Override
	public CalendarVO selectING(String usercode) {
		HashMap map =new HashMap();

		String sql ="SELECT * FROM " 
				+ "`planner_"+usercode+"` "
				+ "WHERE cip = 'ING' ";

		map.put("sql", sql);
		
		CalendarVO result=sqlSession.selectOne(Namespace+".selectING",map);
		return result;
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
}
