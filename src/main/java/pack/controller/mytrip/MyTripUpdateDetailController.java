package pack.controller.mytrip;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import pack.model.content.LocationDto;
import pack.model.mytrip.MyTripListDaoInter;

@Controller
public class MyTripUpdateDetailController {
	@Autowired
	private MyTripListDaoInter daoInter;
	
	@Autowired
	private LocationDto locDto;
	/*
	@RequestMapping(value = "updateDetail", method=RequestMethod.GET)
	public String write() {
		return "my_trip_insert";
	}
	*/
	@RequestMapping(value = "updateDetail", method=RequestMethod.POST)
	@ResponseBody
	public String insertDetailSubmit(MyTripListDetailBean detailbean, 
			HttpServletRequest req, 
			@RequestParam("ti_id") String ti_id, 
			@RequestParam("loc_id") String loc_id) {
		//글 ID
		detailbean.setTi_id(ti_id);
		//장소 ID
		detailbean.setLoc_id(loc_id);
		
		System.out.println("장소아이디는 "+detailbean.getLoc_id()
				+"글아이디는 "+detailbean.getTi_id()
				+"사진 url은 "+detailbean.getTi_pic_url()
				+"글내용은 "+detailbean.getTi_content());
		
		daoInter.myTripDetailUpdate(detailbean);
		
		return "성공";
	}
}
