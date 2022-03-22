package pack.model.content;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.support.SqlSessionDaoSupport;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import pack.controller.content.LocationBean;
import pack.controller.content.LocationPhBean;

@Repository
public class ContentDaoImpl extends SqlSessionDaoSupport implements ContentDaoInter {

	@Autowired
	public ContentDaoImpl(SqlSessionFactory factory) {
		setSqlSessionFactory(factory);

	}

	@Override
	public boolean locInsert(LocationBean bean) {
		// 새 장소 입력 (기본 정보)
		int re = getSqlSession().insert("loc_insert", bean);

		if (re > 0)
			return true;
		else
			return false;
	}

	@Override
	public boolean locDetailInsert(LocationBean bean) {
		// 입력된 장소 세부사항 입력
		int re = getSqlSession().insert("loc_insertDetail", bean);

		if (re > 0)
			return true;
		else
			return false;
	}

	@Override
	public int getMaxId() {
		// 테이블에 아무것도 없을 경우
		if (getSqlSession().selectOne("loc_maxId") == null)
			return 0;
		// 1개 이상 있을경우
		return getSqlSession().selectOne("loc_maxId");
	}

	// 전체 리스트 가져오기
	@Override
	public List<LocationDto> getListAll() {
		// 그냥 다 가져오기
		return getSqlSession().selectList("loc_selectAll");
	}

	// 지역이든 cat이든 선택 리스트 가져오기
	@Override
	public List<LocationDto> getListSelected(String searchType, String searchValue) {
		// 빈 map을 만들고 각각 parm을 집어넣기
		Map<String, String> paramMap = new HashMap<String, String>();
		paramMap.put("searchType", searchType);
		paramMap.put("searchValue", searchValue);

		// 파람을 주고 넘겨 받은 List<LocationDto>를 리턴
		return getSqlSession().selectList("loc_selectType", paramMap);
	}

	// 한 location detail 가져오기
	@Override
	public LocationDto getLocDetail(String loc_id) {
		// 파람을 주고 넘겨 받은 해당 id LocationDto를 리턴
		return getSqlSession().selectOne("loc_selectOne", loc_id);
	}

	@Override
	public boolean locInsertPh(LocationPhBean bean) {
		// 새 장소 사진 입력 (1장씩)

		int re = getSqlSession().insert("loc_insertPh", bean);

		if (re > 0)
			return true;
		else
			return false;
	}

	@Override
	public List<LocationPhDto> getLocPh(String loc_id) {
		// 사진정보 다 가져오기
		List<LocationPhDto> list = getSqlSession().selectList("loc_selectPh", loc_id);

		return list;
	}

	@Override
	public boolean loc_ph_delete(String loc_id) {
		// 삭제 작업
		try {
			int re = getSqlSession().delete("loc_deletePh", loc_id);

			if (re > 0)
				return true;
			else
				return false;
		} catch (Exception e) {
			System.out.println(e);
		}
		return false;
	}

	@Override
	public boolean locDelete(String loc_id) {

		// 삭제 작업
		try {
			int re = getSqlSession().delete("loc_delete", loc_id);

			if (re > 0)
				return true;
			else
				return false;
		} catch (Exception e) {
			System.out.println(e);
		}
		return false;
	}

	@Override
	public boolean locUpdate(LocationBean bean) {//기본정보 update
		int re=getSqlSession().update("loc_update",bean);
		
		if(re>0) {
			return true;
		}else {
			return false;
		}
	}

	@Override
	public boolean locUpdateDetail(LocationBean bean) {//모든정보 update
		int re=getSqlSession().update("loc_updateDeatil",bean);
		
		if(re>0) {
			return true;
		}else {
			return false;
		}
	}

	@Override
	public int getTotNum() {
		
		int totNum=getSqlSession().selectOne("loc_TotNum");
		
		
		return totNum;
	}

}
