package pack.controller.board;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.yaml.snakeyaml.tokens.DocumentEndToken;

import pack.model.board.BoderDaoInter;
import pack.model.board.BoderDto;
import pack.model.board2.ReplyDaoInter;

@Controller
public class InsertController {

	@Autowired
	private BoderDaoInter inter;

	@Autowired
	private ReplyDaoInter daoInter; 
	
	@RequestMapping(value="tb_insertPage", method = RequestMethod.GET)
	public ModelAndView insert(@RequestParam(value="tb_no", required=false) String tb_no
								, @RequestParam(value="tb_cat", required=false) String tb_cat
								, @RequestParam(value="user_id", required=false) String user_id
								, @RequestParam(value="tb_url", required=false) String tb_url
								, @RequestParam(value="searchN", required=false) String searchN
								, @RequestParam(value="searchV", required=false) String searchV,
								Model m) {
		
		// dto 객체 생성하여 상세페이지에서 수정페이지로 이동이 아닌 
		// 목록에서 작성페이지로 이동 시 임의로 객체 생성
		BoderDto dto = new BoderDto();
		
		if(!"".equals(tb_no)) {			// 상세페이지 > 수정 버튼 클릭 시 글 번호(tb_no)가 있음
			dto = inter.getDetail(Integer.parseInt(tb_no));
			
		}
		
		if(!"".equals(tb_cat)) {
			m.addAttribute("tb_cat", tb_cat);
		}
		
		m.addAttribute("tb_url",tb_url);
		
		// modelAndView(보여질 jsp파일,객체명,객체)
		return new ModelAndView("tb_insertform","dto",dto);

	}
	
	@RequestMapping(value="tb_insert", method = RequestMethod.POST)
	public String writeSubmit(BoderBean bean, @RequestParam(value="tb_url", required=false) String tb_url) {
		
		boolean b = inter.insert(bean);
		
		if(b) {
			//return "redirect:/detail?bd_no="+bean.getTb_no(); // 추가 후 해당 상세페이지 이동

			return "redirect:/"+tb_url+"page=1&tb_url="+tb_url; // 리스트로

		}else {
			return "redirect:/error";
			
		}
	}
	
	// 댓글
	@RequestMapping(value="reply_insert", method = RequestMethod.POST)
	@ResponseBody
	public String writeSubmit2(ReplyBean bean 
			, @RequestParam(value="tb_url", required=false) String tb_url
			, @RequestParam(value="tb_no", required=false) String tb_no) {
		//onum 갱신
		bean.setOnum(bean.getOnum()+1);
		daoInter.updateOnum(bean);
		
		//댓글 저장
		bean.setNested(bean.getNested()+1);
		if(daoInter.insertReply(bean)) {
			return "redirect:/tb_detail?tb_no="+tb_no+"&tb_url="+tb_url; // 새로고침
		}else {
			return "redirect:/tb_list";
		}
		
	}
	
}
