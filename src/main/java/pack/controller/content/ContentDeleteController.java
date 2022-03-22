package pack.controller.content;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import pack.model.content.ContentDaoInter;

@Controller
@RequestMapping("/content")
public class ContentDeleteController {

	@Autowired
	ContentDaoInter daoInter;
	
	@RequestMapping(value = "/deleteDetail", method = RequestMethod.POST)
	public String locDelete(
			@RequestParam("loc_id")String loc_id,
			//혹시나 권한 더블 체크가 필요할시 대비
			@RequestParam(value = "user_auth", required = false)String user_auth
			) {
		boolean isSuccess=false;
		
		isSuccess=daoInter.locDelete(loc_id);
			
		//성공시 리스트 실패시 에러 페이지
		if(isSuccess) {
			return "redirect:/content/list?region=all";
		}else {
			return "error";
		}
	}
	
	
}
