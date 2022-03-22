package pack.model.board;

import java.util.List;

import pack.controller.board.BoderBean;

public interface BoderDaoInter {
 
	List<List<BoderDto>> getList(int page);			// 글 목록
	boolean insert(BoderBean bean);					// 새글 작성
	boolean update(BoderBean bean);					// 수정
	boolean delete(int num);						// 삭제
	BoderDto getDetail(int num);					// 상세보기
	List<BoderDto> getList2(int cate,int page, String searchN, String searchV);		// 분류 글 목록
	int getList2Total(int cate);					// 종류별 글 합계
	
	boolean updateReadCnt(int num );				// 조회수 수정
	List<BoderDto> getSearch(BoderBean bean); 		// 검색

}
