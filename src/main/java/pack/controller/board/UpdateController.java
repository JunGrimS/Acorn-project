package pack.controller.board;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.context.request.SessionScope;
import org.springframework.web.servlet.ModelAndView;

import pack.controller.member.MemberBean;
import pack.model.board.BoderDaoInter;
import pack.model.board.BoderDto;
import pack.model.board2.ReplyDaoInter;

@Controller
public class UpdateController {
	
	@Autowired
	private BoderDaoInter inter;
	
	@Autowired
	private ReplyDaoInter daoInter; 
	
//	@RequestMapping(value="tb_update", method = RequestMethod.GET)
//	public ModelAndView update(
//			@RequestParam("tb_no")int tb_no) {
//		//수정 자료 읽기
//		BoderDto dto=inter.getDetail(tb_no);
//		
//		ModelAndView andView=new ModelAndView("insertform");
//		andView.addObject("dto", dto);
//		return andView;
//		
//	}
	
	@RequestMapping(value="tb_update", method = RequestMethod.POST)
	public ModelAndView editSubmit(BoderBean bean
			, @RequestParam(value="tb_url", required=false) String tb_url) {
		
		ModelAndView view=new ModelAndView();
			//수정 작업을 진행
			boolean b = inter.update(bean);
			if(b) {
				view.setViewName("redirect:tb_detail?tb_no="+bean.getTb_no()+"&tb_url="+tb_url);	
			}else {
				view.setViewName("redirect:error");		
			}
		return view;
	}
	
	// 댓글 수정
	@RequestMapping(value="reply_update", method = RequestMethod.POST)
	public ModelAndView updateReply(ReplyBean bean,
			@RequestParam("tb_url") String tb_url,
			HttpServletRequest request, 
			HttpServletResponse response) {
			
			HttpSession session = request.getSession(); 
			boolean u = daoInter.updateReply(bean);
			
			
			MemberBean res = (MemberBean)session.getAttribute("res");
			String auth_code = res.getUser_auth();
			String user_id = res.getUser_id();
			
			ModelAndView aa=new ModelAndView();
			
			if(auth_code.equals("3")) {
				// 관리자는 다수정가능
				// updateReply
				
			}else {
				// 관리자가아닐경우 본인아이디일때만 수정
				if(user_id.equals(bean.getUser_id())) { // 유저일 경우
					
					
				}else {
					System.out.println("본인이 등록하지 않은 댓글은 수정불가능합니다.");
				}
			}
			
			
//			if(auth_code.equals("3")) { // 관리자 일경우
//				
//				
//			}else if(user_id.equals(bean.getUser_id())) { // 유저일 경우
//				
//				
//			}else { // 모두 아닐경우
//				
//				
//			}
		
			return aa;
	}
	
}
