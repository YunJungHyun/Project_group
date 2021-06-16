package com.spring.dao;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Service;

import com.spring.vo.DiaryVO;

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
 
	@Override
	public int insertDiary(DiaryVO diaryVO) {

 

		int result = sqlSession.insert(Namespace+ ".insertDiary", diaryVO);
		
		return result;
	}
	
	@Override
	public List<DiaryVO> getAllDiaryList(String usercode) {
		
		//System.out.println("getAllDiaryList :" +usercode);
		
		HashMap map = new HashMap();
		
		String sql = "SELECT * FROM `diary_"+usercode+"` ORDER BY  writeDay desc";
		map.put("sql", sql);
		List<DiaryVO> result = sqlSession.selectList(Namespace+".getAllDiaryList", map);
		return result;
	}
	
	@Override
	public int todayWriteCheck(DiaryVO diaryVO) {
		HashMap map = new HashMap();
		Timestamp writeDay =diaryVO.getWriteDay();
		 

		SimpleDateFormat sdf = new SimpleDateFormat( "yyyy-MM-dd"  );
		String str = sdf.format(writeDay);
		String sql = "SELECT COUNT(*) FROM `diary_"+diaryVO.getUsercode()+"` WHERE writeDay LIKE '"+str+"%'";
		
		map.put("sql", sql);
		int result = sqlSession.selectOne(Namespace+".todayWriteCheck", map);
		return result;
	}
}
