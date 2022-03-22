package pack.controller.mytrip;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import java.io.File;
import java.util.Enumeration;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import pack.controller.member.MemberBean;
import pack.model.member.MemberDaoInter;
import pack.model.mytrip.MyTripListDaoInter;

import com.oreilly.servlet.MultipartRequest;

@Controller
public class MyTripInsertController {
	@Autowired
	private MyTripListDaoInter daoInter;
	 
	@RequestMapping(value = "insert", method=RequestMethod.GET)
	public String write() {
		return "my_trip_insert"; 
	}
	
	@RequestMapping(value = "insert", method=RequestMethod.POST)
	public String myTripInsertSubmit(MyTripListBean bean, 
			HttpServletRequest req) {
		//로그인된 사용자 세션 정보 취득
		HttpSession session = req.getSession();
		MemberBean res = (MemberBean) session.getAttribute("res");
		String id = res.getUser_id();
		System.out.println(id);
		
		//글번호
		bean.setTi_num(daoInter.currentMaxnum() + 1);  //현재 레코드에서 가장 큰번호를 구해 +1
		
		//글 ID
		String tiNum = Integer.toString(bean.getTi_num());
		bean.setTi_id(id+tiNum); //작성자id + 글번호
		
		//작성자 id
		bean.setUser_id(id);

		//등록날짜
		bean.setTi_reg_write();
		
		boolean b = daoInter.myTripInsert(bean);
		
		if(b) {
			return "redirect:/my_trip_list";			
		}else {
			return "redirect:/error";
		}

	}
	
}
