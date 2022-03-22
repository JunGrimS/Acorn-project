package pack.controller.mytrip;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import pack.controller.member.MemberBean;
import pack.model.mytrip.MyTripListDaoInter;
import pack.model.mytrip.MyTripListDto;

@Controller
public class MyTripListController {
	@Autowired
	private MyTripListDaoInter daoInter;
	
	public ArrayList<MyTripListDto> getListData(ArrayList<MyTripListDto> list){
		ArrayList<MyTripListDto> result = new ArrayList<MyTripListDto>();
		 
		return result;
	}
	
	@RequestMapping("my_trip")
	public String my_trip() {
		
		return "my_trip";
	}
	
	@RequestMapping("my_trip_list")
	public Model process(Model model, HttpServletRequest request) {
		//로그인된 사용자 세션 정보 취득 
		HttpSession session = request.getSession();
		MemberBean res = (MemberBean) session.getAttribute("res");
		String id = res.getUser_id();
		System.out.println(id);
		
		ArrayList<MyTripListDto> list = daoInter.getList(id);	
		model.addAttribute("data", list);
		
		return model;
	}
	
}
