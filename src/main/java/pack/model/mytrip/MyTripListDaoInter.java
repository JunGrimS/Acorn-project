package pack.model.mytrip;

import java.util.ArrayList;
import java.util.List;

import pack.controller.mytrip.MyTripListDetailBean;
import pack.model.content.LocationDto;
import pack.controller.mytrip.MyTripListBean;

public interface MyTripListDaoInter {
	ArrayList<MyTripListDto> getList(String user_id);  //나의 여행 글 목록 가져오기
	List<LocationDto> getTripSpotList(String ti_id);  //나의 여행 글 목록 안에서 선택한 여행지들 가져오기
	
	MyTripListDto getDetail(String ti_id);  //나의 여행 글 상세보기
	boolean myTripInsert(MyTripListBean bean);  //나의 여행 글 추가
	boolean myTripUpdate(MyTripListBean bean);  //나의 여행 글 수정
	boolean myTripDelete(String ti_id);  //나의 여행 글 삭제
	boolean deleteTripSpot(MyTripListDetailBean bean);  //나의 여행 글에 추가한 여행지역 한줄 삭제
	 
	int currentMaxnum();  //글번호를 위한 최신글 번호 조회하기
	
	boolean myTripDetailInsert(MyTripListDetailBean bean);  //나의 여행 글 안에서 선택한 여행지의 사진 글 입력
	boolean myTripDetailDelete(String ti_id);  //나의 여행 글 상세정보 삭제
	boolean myTripDetailUpdate(MyTripListDetailBean bean);  //나의 여행 글 수정
}
