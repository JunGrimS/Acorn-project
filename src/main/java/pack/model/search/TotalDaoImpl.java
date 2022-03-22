package pack.model.search;

import java.util.List;

import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.support.SqlSessionDaoSupport;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import pack.model.totalsearch.Criteria;
import pack.model.board.BoderDto;
import pack.model.content.LocationDto;
import pack.model.mytrip.MyTripListDto;
@Repository
public class TotalDaoImpl extends SqlSessionDaoSupport implements TotalDaoInter {
	
	@Autowired
	public TotalDaoImpl(SqlSessionFactory factory) {
		setSqlSessionFactory(factory);
	}
	
	@Override
	public List<LocationDto> getTotalList(Criteria cri) {
		// 컨텐츠 검색 리스트
		return getSqlSession().selectList("pack.resource.SearchMapper.TotalLocSearch",cri);
	}
	
	@Override
	public int locGetTotal(Criteria cri) {
		// 컨텐츠 검색 총 갯수
		return getSqlSession().selectOne("pack.resource.SearchMapper.LocGetTotal",cri);
	}
	
	@Override
	public List<MyTripListDto> getToTalTripList(Criteria cri) throws Exception {
		// 나의여행 검색 리스트
		return getSqlSession().selectList("pack.resource.SearchMapper.TotalTripSearch",cri);
	}
	
	@Override
	public int tripGetTotal(Criteria cri) {
		// 나의여행 검색 총 갯수
		return getSqlSession().selectOne("pack.resource.SearchMapper.TripGetTotal",cri);
	}
	
	@Override
	public List<BoderDto> getTotalComuList(Criteria cri) throws Exception {
		// 커뮤니티 검색 리스트
		return getSqlSession().selectList("pack.resource.SearchMapper.TotalComuSearch",cri);
	}
	@Override
	public int comugetTotal(Criteria cri) {
		// 커뮤니티 검색 총 갯수
		return getSqlSession().selectOne("pack.resource.SearchMapper.ComuGetTotal",cri);
	}
	
	
}
