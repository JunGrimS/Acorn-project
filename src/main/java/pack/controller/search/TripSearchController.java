package pack.controller.search;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import pack.model.mytrip.MyTripListDaoInter;
import pack.model.mytrip.MyTripListDto;
import pack.model.search.TotalDaoInter;
import pack.model.totalsearch.Criteria;
import pack.model.totalsearch.PageDto;

@Controller
public class TripSearchController {
	@Autowired
	private TotalDaoInter daoInter;
	
	private MyTripListDaoInter daointer;
	
	@RequestMapping(value = "/searchtrip", method = RequestMethod.GET)
	public String searchListGET(Model model, Criteria cri) throws Exception {
		
		List<MyTripListDto> list =daoInter.getToTalTripList(cri);
		
		if(!list.isEmpty()) {
			model.addAttribute("list", list);
		} else {
			model.addAttribute("listcheck", "empty");
			
			return "searchtrip";
		}

		model.addAttribute("pageMaker", new PageDto(cri, daoInter.tripGetTotal(cri)));
		
		return "searchtrip";
	}
	
}

