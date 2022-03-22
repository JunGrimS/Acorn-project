package pack.controller.board;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import pack.model.board.BoderDaoInter;
import pack.model.board.BoderDto;
import pack.model.board2.ReplyDto;
import pack.model.board2.ReplyDaoInter;

@Controller
public class DetailController {
	
	@Autowired
	private BoderDaoInter inter;
	
	@Autowired
	private ReplyDaoInter daoInter; 
	
	@RequestMapping("tb_detail")
	public ModelAndView detail(
			@RequestParam("tb_no") int tb_no
			, @RequestParam(value="tb_url", required=false) String tb_url,
			Model m
			) {
		
		boolean b = inter.updateReadCnt(tb_no);
		BoderDto dto=inter.getDetail(tb_no);
		
		// 글 내용
		m.addAttribute("dto",dto);
		
		// url 
		m.addAttribute("tb_url", tb_url);
		
		// 댓글 리스트
		List<ReplyDto> replyList = daoInter.selectReply(dto.getTb_no());
		m.addAttribute("replyList", replyList);
		
		return new ModelAndView("tb_detail");
//		return new ModelAndView("tb_detail","dto",dto);
	}
}
