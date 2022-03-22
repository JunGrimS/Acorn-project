package pack.model.board;


import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.support.SqlSessionDaoSupport;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import pack.controller.board.BoderBean;




@Repository
public class BoderDaoImpl extends SqlSessionDaoSupport implements BoderDaoInter{
	 
	@Autowired
	public BoderDaoImpl(SqlSessionFactory factory) {
		setSqlSessionFactory(factory);
	}
	
	//전체 자료 읽기	
	@Override
	public List<List<BoderDto>> getList(int page) {
		// 종류별 리스트 번호 설정(1:공지,2:문의,3:자유)
		HashMap<String, Integer> hm = new HashMap<String, Integer>();
		hm.put("PAGE",page);
		
		// 실제 리스트를 담을 객체(공지,문의,자유 리스트를 또 리스트 안에 담기)
		List<List<BoderDto>> tot_list = new ArrayList<List<BoderDto>>();
		
		for(int i=1;i<4;i++) { //  1:공지,2:문의,3:자유
			hm.put("TB_CAT",i);
			List<BoderDto> list = getSqlSession().selectList("selectList",hm);
			tot_list.add(list);
		}
		return tot_list;
	}
	
	//상세 보기
	@Override
	public BoderDto getDetail(int tb_no) {
		
		return getSqlSession().selectOne("selectOne", tb_no);
	}
	
	//새글 작성
	@Override
	public boolean insert(BoderBean bean) {
		int re=getSqlSession().insert("insertData", bean);
		
		if(re>0) {//새행이 추가 된다면 1을 반환 
			return true;
		}else {//새행이 추가 되지 않으면 0을 반환
			return false;
			
		}
		
	}
	
	//수정
	@Override
	public boolean update(BoderBean bean) {
		int re=getSqlSession().update("updateData",bean);
		if(re>0) {
			return true;
		}else {
			return false;
		}
	}
	
	//검색
	@Override
	public List<BoderDto> getSearch(BoderBean bean) {
		return (List)getSqlSession().selectList("searchList", bean);
	}
	
	//삭제
	@Override
	public boolean delete(int num) {
		
		int re=getSqlSession().update("deleteData", num);
		if(re>0) {
			return true;			
		}else {
			return false;			
		}
	}
	
	//상세보기 조회수
	@Override
	public boolean updateReadCnt(int num) {
		int tb_no = num;
		int re=getSqlSession().update("updateReadCnt",tb_no);
		
		if(re>0) {
			return true;
		}else {
			return false;
		}
		
	}
	
	// 종류별 리스트
	@Override
	public List<BoderDto> getList2(int cate, int page, String searchN, String searchV) {
		
		HashMap<String, Object> hm = new HashMap<String, Object>();
		hm.put("TB_CAT",cate);
		hm.put("PAGE",page);
		hm.put("searchN",searchN);
		hm.put("searchV",searchV);
		
		List<BoderDto> list1 = getSqlSession().selectList("selectList",hm);
		
		return list1;
	}
	
	// 페이지 총 갯수
	@Override
	public int getList2Total(int tb_cat) {
		return getSqlSession().selectOne("selectTotal", tb_cat);

	}

}








