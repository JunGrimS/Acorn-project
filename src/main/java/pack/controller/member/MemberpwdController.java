package pack.controller.member;

import java.io.IOException;
import java.util.Random;

import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import pack.model.member.MemberDaoInter;

@Controller
public class MemberpwdController {
	@Autowired
	private MemberDaoInter daoInter;
	@Autowired
	private JavaMailSender mailSender;
 
	@RequestMapping(value = "findpwd", method = RequestMethod.GET)
	public String findpwd() throws Exception {
		return "pwd_find";
	}

	// 인증번호 이메일 발송
	@RequestMapping(value = "pwd_auth", method = RequestMethod.POST)
	public ModelAndView find_pwd(HttpServletRequest request, HttpSession session, HttpServletResponse response_email)
			throws IOException {
		String email = (String) request.getParameter("user_email");
		String id = (String) request.getParameter("user_id");

		MemberBean bean = daoInter.findpwd(email);

		if (bean != null) {
			Random r = new Random();
			int num = r.nextInt(999999); // 랜덤난수설정

			if (bean.getUser_id().equals(id)) {
				session.setAttribute("user_email", bean.getUser_email());

				String setfrom = "acorn3test@gmail.com";
				String tomail = email; // 받는사람
				String title = "비밀번호변경 인증 이메일 입니다";
				String content = System.getProperty("line.separator") + "안녕하세요 회원님"
						+ System.getProperty("line.separator") + "비밀번호찾기(변경) 인증번호는 " + num + " 입니다."
						+ System.getProperty("line.separator"); //

				try {
					MimeMessage message = mailSender.createMimeMessage();
					MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "utf-8");

					messageHelper.setFrom(setfrom);
					messageHelper.setTo(tomail);
					messageHelper.setSubject(title);
					messageHelper.setText(content);

					mailSender.send(message);
				} catch (Exception e) {
					System.out.println(e.getMessage());
				}

				ModelAndView mv = new ModelAndView();
				mv.setViewName("pwd_auth");
				mv.addObject("num", num);
				return mv;
			} else {
				ModelAndView mv = new ModelAndView();
				mv.setViewName("pwd_find");
				return mv;
			}
		} else {
			ModelAndView mv = new ModelAndView();
			mv.setViewName("pwd_find");
			return mv;
		}

	}

	@RequestMapping(value = "pwd_change", method = RequestMethod.POST)
	public String pw_set(@RequestParam(value = "email_injeung") String email_injeung,
			@RequestParam(value = "num") String num) throws IOException {

		if (email_injeung.equals(num)) {
			return "pwd_change";
		} else {
			return "pwd_find";
		}
	}

	@RequestMapping(value = "pwd_new", method = RequestMethod.POST)
	public String pw_new(MemberBean bean, HttpSession session) throws Exception {
		
		daoInter.changepwd(bean);
		
		return "loginform";
	}

}