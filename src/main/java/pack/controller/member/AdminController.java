package pack.controller.member;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import pack.model.member.MemberDaoInter;

@Controller
public class AdminController {
	@Autowired
	private MemberDaoInter daoInter;
	 
	@RequestMapping(value="admin",method=RequestMethod.GET)
	public String adminpage() {
		
		return "adminpage";
	}
}
