package pack.model.search;

import java.util.List;

import pack.model.board.BoderDto;
import pack.model.content.LocationDto;
import pack.model.mytrip.MyTripListDto;
import pack.model.totalsearch.Criteria;

public interface TotalDaoInter {
	// 컨텐츠 검색
	public List<LocationDto> getTotalList(Criteria cri) throws Exception;

	public int locGetTotal(Criteria cri);

	// 나의여행 검색
	public List<MyTripListDto> getToTalTripList(Criteria cri) throws Exception;

	public int tripGetTotal(Criteria cri);

	// 커뮤니티 검색
	public List<BoderDto> getTotalComuList(Criteria cri) throws Exception;

	public int comugetTotal(Criteria cri);
}
