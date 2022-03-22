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
public class BoardSearchController {
	@Autowired
	private TotalDaoInter daoInter;
	
	@RequestMapping(value = "/searchboard", method = RequestMethod.GET)
	public String searchListGET(Model model, Criteria cri) throws Exception {
		
		List<BoderDto> list=daoInter.getTotalComuList(cri);
		
		
		if(!list.isEmpty()) {
			model.addAttribute("list", list);
		} else {
			model.addAttribute("listcheck", "empty");
			
			return "searchboard";
		}
		

		model.addAttribute("pageMaker", new PageDto(cri, daoInter.comugetTotal(cri)));
		
		
		return "searchboard";
	}
}
