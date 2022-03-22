package pack.model.content;

import java.util.List;

import pack.controller.content.LocationBean;
import pack.controller.content.LocationPhBean;

public interface ContentDaoInter {
	 
	//전체 리스트
	List<LocationDto> getListAll();
	//선택 리스트
	List<LocationDto> getListSelected(String searchType, String searchValue);
	//한 location 선택 
	LocationDto getLocDetail(String loc_id);
	
	//loc_id 값 destination table 지우기
	boolean locDelete(String loc_id);
	
	//loc_id값 사진 지우기
	boolean loc_ph_delete(String loc_id);
	
	
	//LocationDto getLocDetail(String ti_num);
	
	boolean locInsert(LocationBean bean);
	boolean locDetailInsert(LocationBean bean);
	//boolean locUpdate(LocationBean bean);
	
	int getMaxId();
	
	int getTotNum();
	
	// 사진 입력 관련
	boolean locInsertPh(LocationPhBean bean);
	
	//사진 url 가져오기
	List<LocationPhDto> getLocPh(String loc_id);
	
	//업데이트
	boolean locUpdate(LocationBean bean);
	
	//상세 정보 업데이트
	boolean locUpdateDetail(LocationBean bean);
	
	
	
}
