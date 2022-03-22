package pack.controller.mytrip;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import pack.model.mytrip.MyTripListDaoInter;

@Controller
public class MyTripDetailController {
	@Autowired
	private MyTripListDaoInter daoInter;
	
	@RequestMapping("my_trip_detail")
	public ModelAndView myTripList(
			@RequestParam("ti_id") String ti_id) {
		ModelAndView andView = new ModelAndView("my_trip_detail");  //jsp 리턴
		//방문날짜, 작성일, 제목 등 불러오기
		andView.addObject("data", daoInter.getDetail(ti_id));
		//추가한 여행지 불러오기
		andView.addObject("locData", daoInter.getTripSpotList(ti_id));
		
		return andView;
	}
	
}
