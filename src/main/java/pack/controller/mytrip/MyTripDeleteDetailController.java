package pack.controller.mytrip;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import pack.model.mytrip.MyTripListDaoInter;

@Controller
public class MyTripDeleteDetailController {
	@Autowired
	private MyTripListDaoInter daoInter;
	  
	@RequestMapping(value = "delete_detail", method = RequestMethod.POST)
	public String tripSpotDelete(MyTripListDetailBean detailbean,
			@RequestParam String ti_id) {
		daoInter.deleteTripSpot(detailbean);
		//detailbean.setTi_id(ti_id);
		
		//return "redirect:/my_trip_update?ti_id=" + detailbean.getTi_id();
		return "redirect:/my_trip_update?ti_id=" + ti_id;

	}
}
