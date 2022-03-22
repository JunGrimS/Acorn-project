package pack.controller.content;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import pack.model.content.ContentDaoInter;
import pack.model.content.LocationDto;
import pack.model.content.LocationRegionVO;

@Controller
@RequestMapping("/content/list")
public class ContentListController {

	@Autowired
	private ContentDaoInter daoInter;

	@Autowired
	private LocationRegionVO locResource;
	
	
	private int PAGE_DISPLAY_COUNT= 5; // 보여줄 페이지 리스트 갯수
	private int tot; // 전체 레코드 수
	private int plist = 10; // 한 페이지 당 출력 행 수
	private int pageSu; // 전체 페이지 수
	
	//페이징에 필요한 모든 값이 들어가는 map
	public Map<String, Integer> pagingNumCal(int pageNum, int PAGE_DISPLAY_COUNT, int pageSu){
		
		Map<String, Integer> pagingNumMap= new HashMap<String, Integer>();
		
		//한페이지에 들어가는 글 갯수
		pagingNumMap.put("PAGE_DISPLAY_COUNT", PAGE_DISPLAY_COUNT);
		//하단 페이지 첫번호
		int startPageNum= 1 + ((pageNum-1)/PAGE_DISPLAY_COUNT)*PAGE_DISPLAY_COUNT;
		
		//하단 페이지 마지막 번호 + 보정
		int endPageNum=startPageNum+PAGE_DISPLAY_COUNT-1;
		if(endPageNum > pageSu){
		       endPageNum=pageSu; //보정해 준다. 
		    }
		
		//현재 페이지 번호
		pagingNumMap.put("pageNum", pageNum);
		//시작 페이지 번호
		pagingNumMap.put("startPageNum", startPageNum);
		//마지막 페이지 번호
		pagingNumMap.put("endPageNum", endPageNum);
		//전채 페이지 번호
		pagingNumMap.put("totalPageCount",pageSu);
		//한페이지에 들어가는 글 갯수
		pagingNumMap.put("PAGE_DISPLAY_COUNT", PAGE_DISPLAY_COUNT);
		
		
		return pagingNumMap;
	}
	
	
	
	public ArrayList<LocationDto> getListData(List<LocationDto> list, int page) { // 12, 1
		ArrayList<LocationDto> result = new ArrayList<LocationDto>();

		int start = (page - 1) * plist; // 0, 5, 10...
		//System.out.println("start"+start);
		int size = plist <= list.size() - start ? plist : list.size() - start; // 삼항연산자
		//System.out.println("size:"+size);
		for (int i = 0; i < size; i++) {
			result.add(i, list.get(start + i));
		}

		return result;
	}

	public int getPageSu() { // 총 페이지 수 얻기
		pageSu = tot / plist;

		if (tot % plist > 0)
			pageSu += 1; // 자투리 페이지 연산

		return pageSu;
	}

	// get 방식으로 도시 이름 받아오게 하기 (나중엔 ajax로 해보자 만들었다)
	// 기본은 위와 같다 하지만 list 를 받을때 param을 loc_city 와 city로 바꾸자
	// 변수 region 지역일때도 있고 도시일때도 있다.
	@RequestMapping(method = RequestMethod.GET)
	public ModelAndView cityList(@RequestParam(value = "city", required = false) String city,
			@RequestParam("region") String region, @RequestParam(value = "pageNum", required = false) String page) {

		/* ------- 리스트 받아오기 -------------- */
		ModelAndView andView = new ModelAndView();
		List<LocationDto> list = new ArrayList<LocationDto>();

		// 지역이름과 도시 이름을 집어넣을 map 만들기
		Map<String, String[]> regionCityMap = locResource.getRegionCityMap();
		// 지역 전체 이름
		List<String> regions = new ArrayList<String>(regionCityMap.keySet());
		String[] cities = null;

		// 전체로 선택해서 들어오면
		if (region.equals("all") || region.isEmpty() || region.equals("전체")) {
			// region 변수는 all 집어넣어 전체 리스트 페이지로 보내기
			andView.addObject("region", "전체");

			// 가져온 리스트 list에 집어넣기
			list = daoInter.getListAll();

		} else {// 들어있으면 해당지역 변수 전달
			andView.addObject("region", region);

			// 도시가 비어있으면
			if (city.equals("none") || city.isEmpty()||city==null) {
				// 지역만 선택한거니깐 지역기준으로 가져오기
				list = daoInter.getListSelected("loc_region", region);
				// 해당지역 소속 도시 cities array 담아보내기
				cities = regionCityMap.get(region);
				//그리고 도시는 none을 전달한다.
				andView.addObject("city", "none");

			} else {// 도시 이름이 none이 아니라면 도시기준으로 가져와서 대입
				list = daoInter.getListSelected("loc_city", city);
				// 해당지역 소속 도시 cities array 담아보내기
				cities = regionCityMap.get(region);
				//해당 도시 이름도 전달한다.
				andView.addObject("city", city);
			}

		}

		/*
		 * // 가져온 list data 확인 for (int j = 0; j < list.size(); j++) { LocationDto
		 * dto=list.get(j); System.out.println(dto.getLoc_name());
		 * System.out.println(dto.getLoc_cat()); System.out.println(dto.getLoc_city());
		 * }
		 */

		/*
		 * 지역 선택시 소속도시 출력 테스트 완료 String[] arr=regionCityMap.get(region);
		 * 
		 * for(String c:arr) { System.out.println(c); }
		 */

		/* ------- 리스트 받아오기 end -------------- */
		
		
		/* ------- 페이징 처리 start -------------- */
		//reguestParam 에서 받아올것
		int pageNum = 0;

		// 요청 페이지 위치 page
		if (page!=null) {
			try {
				// pageNum을 숫자로 바꿔주고
				pageNum = Integer.parseInt(page);
				// 0또는 음수값
				if (pageNum <= 0)
					pageNum = 1;
			} catch (Exception e) {
				// 문자가 넘어오는경우
				System.out.println("page 문자가 넘어옴:" + e);
				pageNum = 1;
			}
		}else {//페이지가 들어오지 않는경우
			pageNum=1;
		}

		// 전채 래코드 갯수 계산 시작
		// 선생님은 totalcnt을 가져오셨는데... list 가 있는데 굳이 필요한가..???
		tot = list.size();
		ArrayList<LocationDto> result =getListData((ArrayList<LocationDto>)list, pageNum);

		// 전체 페이지 수
		pageSu = getPageSu();
		
		/* 
		 * 밑의 pagingNumMap에 들어가 있는 것들. 
		//현재 페이지 번호
		pagingNumMap.put("pageNum", pageNum);
		//시작 페이지 번호
		pagingNumMap.put("startPageNum", startPageNum);
		//마지막 페이지 번호
		pagingNumMap.put("endPageNum", endPageNum);
		//전채 페이지 번호
		pagingNumMap.put("totalPageCount",pageSu);
		//한페이지에 들어가는 글 갯수
		pagingNumMap.put("PAGE_DISPLAY_COUNT", PAGE_DISPLAY_COUNT);
		*/
		Map<String, Integer> pagingNumMap= pagingNumCal(pageNum, PAGE_DISPLAY_COUNT, pageSu);
		
		//현재 페이지수 
		
		andView.addObject("pagingNumMap", pagingNumMap);

		/* ------- 페이징 처리 end -------------- */

		// 전체 지역 이름 add 해주고
		andView.addObject("regions", regions);
		// 위에 if절에서 해당 region 변수 add 했고
		// 해당 region cities 이름 add
		andView.addObject("cities", cities);
		// list안의 총 location 갯수 add
		andView.addObject("totalNum", tot);
		// 해당 region안의 페이징 처리된 location list add
		andView.addObject("list", result);
		
		
		
		
		andView.setViewName("content/list_region");
		return andView;
	}

	
	
	
	
	// 임시 리스트 주소 ajax용
	// get 방식으로 지역 이름 받아오게 하기
	@RequestMapping(value = "/temp", method = RequestMethod.GET)
	public ModelAndView listTemp(@RequestParam(value = "city", required = false) String city,
			@RequestParam("region") String region, @RequestParam(value = "pageNum", required = false) String page) {
		ModelAndView andView = new ModelAndView();
		ArrayList<LocationDto> list = new ArrayList<LocationDto>();

		// 지역이름과 도시 이름을 집어넣을 map 만들기
		Map<String, String[]> regionCityMap = locResource.getRegionCityMap();
		// 지역 전체 이름
		List<String> regions = new ArrayList<String>(regionCityMap.keySet());
		String[] cities = null;
		/* ------- 리스트 받아오기 -------------- */
		// 전체로 선택해서 들어오면
		if (region.equals("all") || region.isEmpty() || region.equals("전체")) {
			// region 변수는 all 집어넣어 전체 리스트 페이지로 보내기
			andView.addObject("region", "전체");
			
			// 가져온 리스트 list에 집어넣기
			list = (ArrayList<LocationDto>) daoInter.getListAll();

		} else {// 들어있으면 해당지역 변수 전달
			andView.addObject("region", region);

			// 도시가 비어있으면
			if (city.equals("none") || city.isEmpty()||city==null) {
				// 지역만 선택한거니깐 지역기준으로 가져오기
				list = (ArrayList<LocationDto>) daoInter.getListSelected("loc_region", region);
				//그리고 도시는 none을 전달한다.
				andView.addObject("city", "none");

			} else {// 도시 이름이 none이 아니라면 도시기준으로 가져와서 대입
				list = (ArrayList<LocationDto>) daoInter.getListSelected("loc_city", city);
				//도시 이름을 다시 돌려준다
				andView.addObject("city", city);
			}

			// 해당지역 소속 도시 cities array 담아보내기
			cities = regionCityMap.get(region);
			
			/*
			 * 지역 선택시 소속도시 출력 테스트 완료 String[] arr=regionCityMap.get(region);
			 * 
			 * for(String c:arr) { System.out.println(c); }
			 */
		}
		
		/*
		 * // 가져온 list data 확인 for (int j = 0; j < list.size(); j++) { LocationDto
		 * dto=list.get(j); System.out.println(dto.getLoc_name());
		 * System.out.println(dto.getLoc_cat()); System.out.println(dto.getLoc_city());
		 * }
		 */
		/* ------- 리스트 받아오기 end -------------- */
		
		/* ------- 페이징 처리 start -------------- */
		//reguestParam 에서 받아올것
		int pageNum = 0;

		// 요청 페이지 위치 page
		if (page!=null) {
			try {
				// pageNum을 숫자로 바꿔주고
				pageNum = Integer.parseInt(page);
				// 0또는 음수값
				if (pageNum <= 0)
					pageNum = 1;
			} catch (Exception e) {
				// 문자가 넘어오는경우
				System.out.println("page 문자가 넘어옴:" + e);
				pageNum = 1;
			}
		}else {//페이지가 들어오지 않는경우
			pageNum=1;
		}

		// 전채 래코드 갯수 계산 시작
		// 선생님은 totalcnt을 가져오셨는데... list 가 있는데 굳이 필요한가..???
		tot = list.size();
		ArrayList<LocationDto> result = getListData((ArrayList<LocationDto>)list, pageNum);

		// 전체 페이지 수
		pageSu = getPageSu();
		
		/* 
		 * 밑의 pagingNumMap에 들어가 있는 것들. 
		//현재 페이지 번호
		pagingNumMap.put("pageNum", pageNum);
		//시작 페이지 번호
		pagingNumMap.put("startPageNum", startPageNum);
		//마지막 페이지 번호
		pagingNumMap.put("endPageNum", endPageNum);
		//전채 페이지 번호
		pagingNumMap.put("totalPageCount",pageSu);
		//한페이지에 들어가는 글 갯수
		pagingNumMap.put("PAGE_DISPLAY_COUNT", PAGE_DISPLAY_COUNT);
		*/
		Map<String, Integer> pagingNumMap= pagingNumCal(pageNum, PAGE_DISPLAY_COUNT, pageSu);
		
		//현재 페이지수 
		
		andView.addObject("pagingNumMap", pagingNumMap);

		/* ------- 페이징 처리 end -------------- */
		
		
		
		// 전체 지역 이름 add 해주고
		andView.addObject("regions", regions);
		// 위에 if절에서 해당 region 변수 add 했고
		// 해당 region cities 이름 add
		andView.addObject("cities", cities);
		// list안의 총 location 갯수 add
		andView.addObject("totalNum", tot);
		// 해당 region안의 location list add
		andView.addObject("list", result);

		andView.setViewName("content/list/temp");
		return andView;
	}
}
