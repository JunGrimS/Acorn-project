package pack.controller.mytrip;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import pack.controller.member.MemberBean;
import pack.model.content.LocationDto;
import pack.model.mytrip.MyTripListDaoInter;

@Controller
public class MyTripInsertDetailController {
	@Autowired
	private MyTripListDaoInter daoInter;
	
	@Autowired
	private LocationDto locDto;
	/*
	@RequestMapping(value = "insertDetail", method=RequestMethod.GET)
	public String write() {
		return "my_trip_insert"; 
	}
	*/
	@RequestMapping(value = "insertDetail", method=RequestMethod.POST)
	@ResponseBody
	public String insertDetailSubmit(MyTripListDetailBean detailbean, HttpServletRequest req) {	
		//로그인된 사용자 세션 정보 취득
		HttpSession session = req.getSession();
		MemberBean res = (MemberBean) session.getAttribute("res");
		String id = res.getUser_id();
		System.out.println("작성자 아이디는"+id);
		
		//글 ID
		int tiNum = (daoInter.currentMaxnum() + 1);  //글번호: 현재 레코드에서 가장 큰번호를 구해 +1
		String tiNumString = Integer.toString(tiNum);
		detailbean.setTi_id(id+tiNumString); //작성자id + 글번호
		System.out.println("글 아이디는"+id+tiNumString);
		
		//장소 ID
		//detailbean.setLoc_id(loc_id);
		
		System.out.println("장소아이디는 "+detailbean.getLoc_id()
				+"글아이디는 "+detailbean.getTi_id()
				+"사진 url은 "+detailbean.getTi_pic_url()
				+"글내용은 "+detailbean.getTi_content());
		
		daoInter.myTripDetailInsert(detailbean);
		
		System.out.println(detailbean.getTi_content());
		System.out.println(detailbean.getTi_pic_url());
		
		return "성공";
	}
}
