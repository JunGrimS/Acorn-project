package pack.controller.member;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import pack.model.member.MemberDaoInter;

@Controller
public class SignupController {
	@Autowired
	private MemberDaoInter daoInter;
	 
	@RequestMapping(value = "signup", method=RequestMethod.GET)
	public String signup() {
		return "signupform2";
	}
	@ResponseBody
	@RequestMapping(value="checkid", method=RequestMethod.POST)
	public int checkid(MemberBean bean) throws Exception {
		int result = daoInter.checkid(bean);
		return result;
	}
	
	@RequestMapping(value = "signup", method=RequestMethod.POST)
	public String signupSubmit(MemberBean bean) {
		boolean a = daoInter.insert(bean);
		
		if(a)
			return "redirect:/login";
		else
			return "redirect:/error";
	}
}
