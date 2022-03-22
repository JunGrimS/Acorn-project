package pack.controller.content;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import pack.model.content.ContentDaoInter;
import pack.model.content.LocationDto;
import pack.model.content.LocationRegionVO;

@Controller
@RequestMapping("/content")
public class ContentUpdateController {

	@Autowired
	LocationRegionVO getRegionClass;

	@Autowired
	private ContentDaoInter daoInter;

	@RequestMapping(value = "/updateForm", method = RequestMethod.POST)
	public ModelAndView updateForm(
			@RequestParam("loc_id")String loc_id,
			//혹시나 권한 더블 체크가 필요할시 대비
			@RequestParam(value = "user_auth", required = false)String user_auth) {
		
		ModelAndView andView=new ModelAndView("/content/insertForm");
		
		String[] regionList = getRegionClass.getRegionList();
		Map<String, String[]> listMap = getRegionClass.getRegionCityMap();

		andView.addObject("regionList", regionList);
		andView.addObject("listMap", listMap);
		
		//관광지 정보 첨부
		andView.addObject("locDto", daoInter.getLocDetail(loc_id));
		//있다면 사진 url 리스트 첨부
		andView.addObject("locPh", daoInter.getLocPh(loc_id));
		andView.addObject("function", "update");
		
		return andView;
	}
	
	@RequestMapping(value = "/updateDetail", method = RequestMethod.POST)
	public String update(LocationBean bean) {
		

		boolean locSuccess = false;
		boolean deatilSuccess = false;
		boolean phoSuccess = false;
		// 지역 리스트 정보 받기

		// bean을 loc_update (기본정보 insert sql)로 수정 
		locSuccess = daoInter.locUpdate(bean);
		System.out.println("loc_update success:"+locSuccess);

		// loc_insert가 성공하면 loc_insertDetail 도 실행.
		if (locSuccess) {
			deatilSuccess = daoInter.locUpdateDetail(bean);
			System.out.println("loc_updateDetail success:"+deatilSuccess);
		}

		// loc_insert가 성공하면 사진 등록도 실행 (1장씩)
		if (locSuccess) {
			
			// 사진정보 String을 array에 나누기
			String urlString = bean.getLoc_ph_url();

			// 잘 들어왔는지 확인
			System.out.println("사진 uri 확인" + urlString);
			
			String[] urlArr=null;
			
			if (!urlString.isEmpty()) {// url data가 들어왔다면
				//기존에 존제하던 사진 리스트를 날리기
				boolean phDeleteSuccess = daoInter.loc_ph_delete(bean.getLoc_id());
				//원래는 사진 db에서 리스트를 가져와서 틀린것들은 삭제하고 새로운것만 추가하는 방법이 좋을거 같으나
				//귀찮기도 하고 복잡해보여서 다 날리고 시작한다.
				System.out.println("loc_deletePh success:"+phDeleteSuccess);
				try {
					urlArr = urlString.split(","); // , 로 잘라서 배열에 보관
				} catch (Exception e) {
					System.out.println("url 문자열 split오류"+e);
				}
				
				for (int i = 0; i < urlArr.length; i++) {// 이제 하나씩 db에 저장
					// Bean을 만든다음
					LocationPhBean phBean = new LocationPhBean();
					phBean.setLoc_ph_id_cnt(Integer.toString(i+1));
					// loc_id를 집어넣고
					phBean.setLoc_id(bean.getLoc_id());
					// 주소도 집어넣어준다
					phBean.setLoc_ph_url("'" + urlArr[i] + "'");
					// 최종적으로 db등록 +확인
					System.out.println("사진 등록?: " + daoInter.locInsertPh(phBean));

				}
			}

		}

		// return "content/detail";
		if (locSuccess) {
			return "redirect:/content/detail?loc_id=" + bean.getLoc_id();
		} else {
			return "redirect:/content/list?region=all";
		}

	}



	// 설계 1.detail을 다 불러온다.

	// 2.insertfrom에 다 집어 넣는다

	// 수정 버튼 클릭후
	// 3.사진리스트는 다 지우고 새로운 리스트를 집어 넣는다.

	// 4.

	/*
	// 처음 get 방식으로 insert 주소로 들어온 경우
	@RequestMapping(method = RequestMethod.GET)
	public ModelAndView toInsertForm() {
		// insertForm 페이지로 포워드

		ModelAndView andView = new ModelAndView("content/insertForm");

		String[] regionList = getRegionClass.getRegionList();
		Map<String, String[]> listMap = getRegionClass.getRegionCityMap();

		andView.addObject("regionList", regionList);
		andView.addObject("listMap", listMap);

		return andView;
	}
	*/
	/*
	 * content controller 로 옮김 // ajax통해 해당지역 도시리스트 보내기
	 * 
	 * @RequestMapping(value = "/city", method = RequestMethod.GET)
	 * 
	 * @ResponseBody public String[] cityList(@RequestParam("loc_region") String
	 * loc_region) {
	 * 
	 * return getRegionClass.splitCityNames(loc_region); }
	 */
/*
	// insertForm 페이지에서 post방식으로 입력된 정보를 Bean으로 받아와서 DB에 입력
	@RequestMapping(method = RequestMethod.POST)
	public String insert(LocationBean bean) {
		// maxId를 불러온후 1을 더해서 bean의 loc_id에 삽입
		int newId = daoInter.getMaxId() + 1;
		// System.out.println(newId); // 확인완료
		bean.setLoc_id(Integer.toString(newId));

		boolean locSuccess = false;
		boolean deatilSuccess = false;
		boolean phoSuccess = false;
		// 지역 리스트 정보 받기

		// bean을 loc_insert (기본정보 insert sql)에 입력
		locSuccess = daoInter.locInsert(bean);
		// System.out.println(locSuccess); // 확인 완료

		// loc_insert가 성공하면 loc_insertDetail 도 실행.
		if (locSuccess) {
			deatilSuccess = daoInter.locDetailInsert(bean);
		}

		// loc_insert가 성공하면 사진 등록도 실행 (1장씩)
		if (locSuccess) {

			// 사진정보 String을 array에 나누기
			String urlString = bean.getLoc_ph_url();

			// 잘 들어왔는지 확인
			System.out.println("post 확인" + urlString);

			if (!urlString.isEmpty()) {// url data가 들어왔다면
				String[] urlArr = urlString.split(","); // , 로 잘라서 배열에 보관

				for (int i = 0; i < urlArr.length; i++) {// 이제 하나씩 db에 저장
					// Bean을 만든다음
					LocationPhBean phBean = new LocationPhBean();
					// loc_id를 집어넣고
					phBean.setLoc_id(bean.getLoc_id());
					// 주소도 집어넣어준다
					phBean.setLoc_ph_url("'" + urlArr[i] + "'");
					// 최종적으로 db등록 +확인
					System.out.println("사진 등록?: " + daoInter.locInsertPh(phBean));

				}
			}

		}

		// return "content/detail";
		if (locSuccess) {
			return "redirect:content/detail?loc_id=" + bean.getLoc_id();
		} else {
			return "redirect:content/list?region=all";
		}

	}
	*/
/*
	@Autowired
	private ContentDaoInter daointer;

	@RequestMapping(value = "/detail", method = RequestMethod.GET)
	public ModelAndView detail(@RequestParam("loc_id") String loc_id) {
		ModelAndView andView = new ModelAndView("/content/loc_detail");
		// 관광지 정보 첨부
		andView.addObject("locDto", daointer.getLocDetail(loc_id));
		// 있다면 사진 url 리스트 첨부
		andView.addObject("locPh", daointer.getLocPh(loc_id));
		return andView;
	}
*/
	/*
	 * //detail_region2.jsp 파일에서 /content/list/detail/for_trip 주소를통해서 ajax 요청을
	 * json으로 돌려주는 부분 //다중선택이 가능하게 만들수 있을듯???
	 * 
	 * @RequestMapping(value = "/list/temp", method = RequestMethod.POST) public
	 * HashMap<String, Object> ajaxTest(@RequestParam("loc_id") String loc_id) {
	 * 
	 * LocationDto loc_dto = daointer.getLocDetail(loc_id); HashMap<String, Object>
	 * map= new HashMap<String, Object>(); map.put("loc_dto", loc_dto);
	 * 
	 * return map; }
	 */
	// 꼭 jacson lib core가 아닌지 확인하기...
	// detail_region2.jsp 파일에서 /content/list/detail/for_trip 주소를통해서 ajax 요청을 json으로
	// 돌려주는 부분
	// 다중선택이 가능하게 만들수 있을듯???
	// requestmapping이랑 같은 주소로 값을 반환하기 때문에 ajax를 요청할때 같은 페이지로 요청해야한다.
	
	/*
	@RequestMapping(value = "/list/temp", method = RequestMethod.POST)
	@ResponseBody
	public LocationDto ajaxTest(@RequestParam("loc_id") String loc_id) {
		LocationDto loc_dto = daointer.getLocDetail(loc_id);
		return loc_dto;
	}*/

}
