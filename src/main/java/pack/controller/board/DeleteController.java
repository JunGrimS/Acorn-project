package pack.controller.board;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import pack.model.board.BoderDaoInter;
import pack.model.board2.ReplyDaoInter;

@Controller
public class DeleteController {

	 
		@Autowired
		private BoderDaoInter inter;

		@Autowired
		private ReplyDaoInter daoInter; 
		
		@RequestMapping("tb_delete")
		public String del(
				@RequestParam(value="tb_no", required=false) int tb_no,
				@RequestParam(value="tb_url", required=false) String tb_url,
				@RequestParam(value="tb_cat", required=false) String tb_cat
				) {

			//제대로 하려면 비번 비교후 삭제해야 한다. 수정코드를 참조
			boolean b = inter.delete(tb_no);
			String url = tb_url+"?page=1";
			if(b) {
				//return "redirect:/detail?bd_no="+bean.getTb_no(); // 추가 후 해당 상세페이지 이동
				if(tb_url.equals("tb_list2")) {
					url += "&tb_cat="+tb_cat;
				}
				return "redirect:/"+url;// 리스트로

			}else {
				return "redirect:/error";
				
			}

			
			
		
		}
	
}
