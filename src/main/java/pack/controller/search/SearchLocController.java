package pack.controller.search;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import pack.model.content.ContentDaoInter;
import pack.model.search.Criteria;
import pack.model.search.PageMakerDto;
import pack.model.search.SearchDaoInter;

@Controller
public class SearchLocController {
	@Autowired
	private SearchDaoInter daoInter;
	
	@Autowired
	private ContentDaoInter daointer;

	@RequestMapping(value = "searchloc", method = RequestMethod.GET)
	public void searchListGET(Model model, Criteria cri) {
		
		model.addAttribute("list", daoInter.getListPaging(cri));

		int total = daoInter.getTotal(cri);

		PageMakerDto pageMake = new PageMakerDto(cri, total);

		model.addAttribute("pageMaker", pageMake);
	}
	
	@RequestMapping(value = "/detail",method = RequestMethod.GET)
	public ModelAndView detail(@RequestParam("loc_id") String loc_id,Criteria cri) {
		
		ModelAndView view = new ModelAndView();
		
		view.addObject(cri); //문제점 : 받아온 값이 초기화되지 않음
		
		return new ModelAndView("/content/loc_detail", "locDto", daointer.getLocDetail(loc_id));
	}
}
