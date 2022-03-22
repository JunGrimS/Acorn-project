package pack.controller.member;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import pack.model.member.MemberDaoInter;

@Controller
public class LoginController {
	@Autowired
	private MemberDaoInter daoInter;
 
	@RequestMapping(value = "login", method=RequestMethod.GET)
	public String login() {
		return "loginform";
	}
	
	@RequestMapping(value = "mypage", method=RequestMethod.GET)
	public String mypage() {
		return "mypage";
	}

	@RequestMapping(value = "login", method = RequestMethod.POST)
	public String login(MemberBean bean, HttpServletRequest req, RedirectAttributes rttr) throws Exception {

		HttpSession session = req.getSession();
		MemberBean res = daoInter.login(bean);

		if (res != null) {
			session.setAttribute("res", res);
			return "redirect:/index.jsp";
		} else {
			session.setAttribute("res", null);
			rttr.addFlashAttribute("msg", false);
			return "redirect:/login";
		}
		
	}
	@RequestMapping(value="logout", method=RequestMethod.GET)
	public String logout(HttpSession session) {
		session.invalidate();
		
		return "redirect:/index.jsp";
	}
}
