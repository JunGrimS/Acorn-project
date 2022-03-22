package pack.controller.content;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import pack.model.content.ContentDaoInter;
import pack.model.content.LocationDto;

@Controller
@RequestMapping("/content")
public class ContentDetailController {

	@Autowired
	private ContentDaoInter daointer;

	@RequestMapping(value = "/detail",method = RequestMethod.GET)
	public ModelAndView detail(@RequestParam("loc_id") String loc_id) {
		ModelAndView andView=new ModelAndView("/content/loc_detail");
		//관광지 정보 첨부
		andView.addObject("locDto", daointer.getLocDetail(loc_id));
		//있다면 사진 url 리스트 첨부
		andView.addObject("locPh",daointer.getLocPh(loc_id));
		return andView;
	}

	/*
	//detail_region2.jsp 파일에서 /content/list/detail/for_trip 주소를통해서 ajax 요청을 json으로 돌려주는 부분
	//다중선택이 가능하게 만들수 있을듯???
	@RequestMapping(value = "/list/temp", method = RequestMethod.POST)
	public HashMap<String, Object> ajaxTest(@RequestParam("loc_id") String loc_id) {

		LocationDto loc_dto = daointer.getLocDetail(loc_id);
		HashMap<String, Object> map= new HashMap<String, Object>();
		map.put("loc_dto", loc_dto);
		
		return map;
	}
	*/
	//꼭 jacson lib core가 아닌지 확인하기...
	//detail_region2.jsp 파일에서 /content/list/detail/for_trip 주소를통해서 ajax 요청을 json으로 돌려주는 부분
	//다중선택이 가능하게 만들수 있을듯???
	//requestmapping이랑 같은 주소로 값을 반환하기 때문에 ajax를 요청할때 같은 페이지로 요청해야한다.
	@RequestMapping(value = "/list/temp", method = RequestMethod.POST)
	@ResponseBody
	public LocationDto ajaxTest(@RequestParam("loc_id") String loc_id) {
		LocationDto loc_dto = daointer.getLocDetail(loc_id);
		return loc_dto;
	}

}
