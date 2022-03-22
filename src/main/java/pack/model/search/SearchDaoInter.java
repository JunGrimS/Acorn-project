package pack.model.search;

import java.util.List;
	
import pack.model.content.LocationDto;

public interface SearchDaoInter {
	// 컨텐츠 목록
	public List<LocationDto> getList();
	// 컨텐츠 목록(페이징)
	public List<LocationDto> getListPaging(Criteria cri);
	// 총 컨텐츠 갯수
	public int getTotal(Criteria cri);
}	
