package pack.model.mytrip;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.support.SqlSessionDaoSupport;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import pack.controller.mytrip.MyTripListBean;
import pack.controller.mytrip.MyTripListDetailBean;
import pack.model.content.LocationDto;

@Repository
public class MyTripListDaoImpl extends SqlSessionDaoSupport implements MyTripListDaoInter{
	
	@Autowired
	public MyTripListDaoImpl(SqlSessionFactory factory) {
		setSqlSessionFactory(factory);
	} 
	
	@Override
	public ArrayList<MyTripListDto> getList(String user_id) {
		//나의 여행 리스트 읽어오기
		return (ArrayList)getSqlSession().selectList("myTripList", user_id);
	}
	
	@Override
	public int currentMaxnum() {
		// insert시 번호 자동 증가를 위해 현재 테이블에서 가장 큰 번호 얻기
		if(getSqlSession().selectOne("currentMaxnum") == null) return 0;
		return getSqlSession().selectOne("currentMaxnum");
	}

	@Override
	public MyTripListDto getDetail(String ti_id) {
		// 나의 여행 상세보기
		return getSqlSession().selectOne("selectOneMyTrip", ti_id);
	}

	@Override
	public boolean myTripInsert(MyTripListBean bean) {
		// 새 글 입력
		int re = getSqlSession().insert("insertMyTripData", bean);
		
		if(re > 0) 
			return true;
		else
			return false;
	}

	@Override
	public boolean myTripUpdate(MyTripListBean bean) {
		// 수정 작업
		int re = getSqlSession().update("updateMyTripData", bean);
		
		if(re > 0) 
			return true;
		else
			return false;
	}

	@Override
	public boolean myTripDelete(String ti_num) {
		// 삭제 작업
		try {
			int re = getSqlSession().delete("deleteMyTripData", ti_num);
			
			if(re > 0) 
				return true;
			else
				return false;			
		} catch (Exception e) {
			return false;
		}
	}

	@Override
	public boolean myTripDetailInsert(MyTripListDetailBean bean) {
		// 사진, 글 등 상세정보 입력
		int re = getSqlSession().insert("insertDetailData", bean);
		
		if(re > 0) 
			return true;
		else
			return false;
	}

	@Override
	public List<LocationDto> getTripSpotList(String ti_id) {
		//여행지들 리스트 읽어오기
		return getSqlSession().selectList("tripSpotSelectList", ti_id);
	}

	@Override
	public boolean myTripDetailDelete(String ti_id) {
		//나의 여행 상세정보 삭제
		try {
			int re = getSqlSession().delete("deleteDetailData", ti_id);
			
			if(re > 0) 
				return true;
			else
				return false;			
		} catch (Exception e) {
			return false;
		}
	}

	@Override
	public boolean myTripDetailUpdate(MyTripListDetailBean bean) {
		// 나의 여행 글 사진 글 수정 작업
		int re = getSqlSession().update("updateDetailData", bean);
		
		if(re > 0) 
			return true;
		else
			return false;

	}

	@Override
	public boolean deleteTripSpot(MyTripListDetailBean bean) {
		//나의 여행 상세정보 삭제
		try {
			int re = getSqlSession().delete("deleteTripSpot", bean);
			
			if(re > 0) 
				return true;
			else
				return false;			
		} catch (Exception e) {
			return false;
		}
	}

}
