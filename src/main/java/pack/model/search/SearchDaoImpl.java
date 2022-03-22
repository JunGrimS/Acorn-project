package pack.model.search;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.support.SqlSessionDaoSupport;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import pack.controller.content.LocationBean;
import pack.model.content.LocationDto;
@Repository
public class SearchDaoImpl extends SqlSessionDaoSupport implements SearchDaoInter {
	@Autowired
	public SearchDaoImpl(SqlSessionFactory factory) {
		setSqlSessionFactory(factory);
	}
	
	@Override
	public List<LocationDto> getList() {
		// TODO Auto-generated method stub
		return getSqlSession().selectList("ListLoc");
	}
	
	@Override
	public List<LocationDto> getListPaging(Criteria cri) {
		// 페이징 리스트
		return getSqlSession().selectList("ListLocPaging",cri);
	}
	
	@Override
	public int getTotal(Criteria cri) {
		// 총 갯수
		return getSqlSession().selectOne("SearchLocTotal",cri);
	}
}
