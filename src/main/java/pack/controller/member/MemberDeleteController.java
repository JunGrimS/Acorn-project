package pack.controller.member;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import pack.model.member.MemberDaoInter;

@Controller
public class MemberDeleteController {
	@Autowired
	public MemberDaoInter daoInter;
	 
	@RequestMapping(value="memberdelete", method=RequestMethod.GET)
	public String memberDelete() throws Exception {
		
		return "memberdeleteform";
	}
	
	@RequestMapping(value="memberdelete", method=RequestMethod.POST)
	public String memberDelete(MemberBean bean, HttpSession session, RedirectAttributes rttr) throws Exception {
		// 세션에 있는 회원정보 가져오기
		MemberBean bean2 = (MemberBean) session.getAttribute("res");
		// 세션에 있는 비밀번호
		String sessionpwd = bean2.getUser_pwd();
		// bean으로 받는 비밀번호
		String beanpwd= bean.getUser_pwd();
		
		if(!(sessionpwd.equals(beanpwd))) {
			rttr.addAttribute("msg",false);
			return "redirect:/memberdelete";
		}
		
		daoInter.memberDelete(bean);
		session.invalidate();
		
		return "redirect:/login";
	}
}