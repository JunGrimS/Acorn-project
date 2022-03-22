package pack.controller.search;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import pack.model.board.BoderDto;
import pack.model.content.LocationDto;
import pack.model.mytrip.MyTripListDto;
import pack.model.search.TotalDaoInter;
import pack.model.totalsearch.Criteria;
import pack.model.totalsearch.PageDto;

@Controller
public class TotalSearchController {
	@Autowired
	private TotalDaoInter daoInter;
	
	@RequestMapping(value = "/searchtotal", method = RequestMethod.GET)
	public String searchListGET(Model model, Criteria cri) throws Exception {
		
		List<LocationDto> list =daoInter.getTotalList(cri);

		if(!list.isEmpty()) {
			model.addAttribute("list", list);
		} else {
			model.addAttribute("listcheck", "empty");
			
			return "searchtotal";
		}
		
		model.addAttribute("list", list);
		model.addAttribute("pageMaker", new PageDto(cri, daoInter.locGetTotal(cri)));
		
		
		return "searchtotal";
	}
}
