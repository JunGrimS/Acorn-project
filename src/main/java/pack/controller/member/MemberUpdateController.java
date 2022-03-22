package pack.controller.member;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import pack.model.member.MemberDaoInter;

@Controller
public class MemberUpdateController {
	@Autowired
	private MemberDaoInter daoInter;
	
	@RequestMapping(value="memberupdate", method=RequestMethod.GET)
	public String memberUpdate() throws Exception{
	  	
		return "memberupdateform";
	}
	
	@RequestMapping(value="memberupdate", method=RequestMethod.POST)
	public String memberupdate(MemberBean bean, HttpSession session) throws Exception {
		daoInter.memberUpdate(bean);
		
		session.invalidate();
		
		return "redirect:/login";
	}
}
