package com.spring.dao;

import java.util.HashMap;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Service;

@Service
public class DiaryDAOImpl implements DiaryDAO{

	
	@Inject
	private SqlSession sqlSession;

	private static final String Namespace = "com.spring.mapper.diaryMapper";
	
	@Override
	public void createDiary(String usercode) {
		
		HashMap map = new HashMap();
		

		String sql = "CREATE TABLE `diary_"+usercode+"` (";
		sql += "`dnum` INT(20) NOT NULL AUTO_INCREMENT,"
				+"`dtitle` VARCHAR(50) NULL DEFAULT 'none',"
				+"`dcontents` VARCHAR(300) NULL DEFAULT 'none',"
				+"`writeDay` TIMESTAMP NOT NULL DEFAULT '0000-00-00 00:00:00',"					
				+"`picture` VARCHAR(100) NULL,"										
				+"PRIMARY KEY (`dnum`) USING BTREE";
		sql += ")";
		sql +=" COLLATE='utf8_general_ci' ";
		sql +=" ENGINE=InnoDB ";
		sql +=" AUTO_INCREMENT=1 ";
 
		map.put("sql", sql);


		sqlSession.update(Namespace+ ".createDiary", map);
	}
}
