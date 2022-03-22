package pack.controller.mytrip;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import pack.model.content.LocationDto;
import pack.model.mytrip.MyTripDetailDto;
import pack.model.mytrip.MyTripListDaoInter;
import pack.model.mytrip.MyTripListDto;

@Controller
public class MyTripUpdateController {
	@Autowired
	private MyTripListDaoInter daoInter;
	
	@RequestMapping(value = "my_trip_update", method = RequestMethod.GET)
	public ModelAndView edit(@RequestParam("ti_id") String ti_id) { 
		//수정할 자료 읽기
		MyTripListDto dto = daoInter.getDetail(ti_id);
		//추가한 여행지 불러오기
		List<LocationDto> list = daoInter.getTripSpotList(ti_id);
		
		ModelAndView andView = new ModelAndView("my_trip_update"); 
		
		andView.addObject("data", dto);
		andView.addObject("locData", list);
				
		return andView;
		/*
		return new ModelAndView("my_trip_update", "data", dto);
		*/
	}
	
	@RequestMapping(value = "my_trip_update", method = RequestMethod.POST)
	public ModelAndView editSubmit(MyTripListBean bean) {
		
		ModelAndView andView = new ModelAndView();
		daoInter.myTripUpdate(bean);
		
		andView.setViewName("redirect:my_trip_detail?ti_id=" + bean.getTi_id());
		
		return andView; 
	}

}
