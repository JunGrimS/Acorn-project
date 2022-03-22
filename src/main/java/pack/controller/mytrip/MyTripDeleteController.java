package pack.controller.mytrip;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import pack.model.mytrip.MyTripListDaoInter;

@Controller
public class MyTripDeleteController {
	@Autowired
	private MyTripListDaoInter daoInter;
	  
	@RequestMapping("delete")
	public String del(@RequestParam("ti_id") String ti_id) {
		daoInter.myTripDelete(ti_id);
		daoInter.myTripDetailDelete(ti_id);
		
		return "redirect:/my_trip_list";

	}
}
