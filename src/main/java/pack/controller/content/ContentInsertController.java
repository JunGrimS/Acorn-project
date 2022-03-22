package pack.controller.content;

import java.awt.List;
import java.util.Map;

import org.apache.ibatis.javassist.expr.NewArray;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import pack.model.content.ContentDaoInter;
import pack.model.content.LocationPhDto;
import pack.model.content.LocationRegionVO;

@Controller
@RequestMapping("/content/insert")
public class ContentInsertController {

	@Autowired
	LocationRegionVO getRegionClass;

	@Autowired
	private ContentDaoInter daoInter;

	// 처음 get 방식으로 insert 주소로 들어온 경우
	@RequestMapping(method = RequestMethod.GET)
	public ModelAndView toInsertForm() {
		// insertForm 페이지로 포워드

		ModelAndView andView = new ModelAndView("content/insertForm");

		String[] regionList = getRegionClass.getRegionList();
		Map<String, String[]> listMap = getRegionClass.getRegionCityMap();

		andView.addObject("regionList", regionList);
		andView.addObject("listMap", listMap);
		andView.addObject("function", "insert");

		return andView;
	}
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
			//System.out.println("post 확인" + urlString);

			if (!urlString.isEmpty()) {// url data가 들어왔다면
				String[] urlArr = urlString.split(","); // , 로 잘라서 배열에 보관
				
				for (int i = 0; i < urlArr.length; i++) {//이제 하나씩 db에 저장
					//Bean을 만든다음
					LocationPhBean phBean=new LocationPhBean();
					phBean.setLoc_ph_id_cnt(Integer.toString(i+1));
					//loc_id를 집어넣고 
					phBean.setLoc_id(bean.getLoc_id());
					//주소도 집어넣어준다
					phBean.setLoc_ph_url("'"+urlArr[i]+"'");
					//최종적으로 db등록 +확인
					System.out.println("사진 등록?: "+daoInter.locInsertPh(phBean));
					
				}
			}

		}

		// return "content/detail";
		if(locSuccess) {//detail?loc_id="+bean.getLoc_id()
			return "redirect:/content/list?region=all";
		}else {
			return "redirect:/content/list?region=all";
		}
		
	}

}
