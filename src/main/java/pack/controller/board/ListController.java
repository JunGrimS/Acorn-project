package pack.controller.board;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import pack.model.board.BoderDaoInter;
import pack.model.board.BoderDto;
import pack.model.board2.ReplyDaoInter;
import pack.model.board2.ReplyDto;

@Controller
public class ListController {
	
	@Autowired
	private BoderDaoInter inter;
	private int plist = 10;  // 한 페이지당 출력 행수
	

	@Autowired
	private ReplyDaoInter daoInter; 
	 
//	public ArrayList<BoderDto> getListData(){
//		ArrayList<BoderDto> data=new ArrayList<BoderDto>();
//		
//		return data;
//	}
	// 리스트 
	@RequestMapping("tb_list")
	public ModelAndView list(@RequestParam("page") int page) {
		
		List<List<BoderDto>> list = inter.getList(page);
		
		return new ModelAndView("tb_list","list",list);
	}
	
	//더보기 리스트
	@RequestMapping("tb_list2")
	public String list2(
			@RequestParam(value="page", required=false) int page, 
			@RequestParam(value="tb_cat", required=false) int cate, 
			@RequestParam(value="tb_url", required=false) String tb_url, 
			@RequestParam(value="searchN", required=false) String searchN, 
			@RequestParam(value="searchV", required=false) String searchV, 
			Model model) {
		
		// 종류별 글 개수
		int page_chk = inter.getList2Total(cate);
		
		// 종류별 글 리스트
		List<BoderDto> list = inter.getList2(cate,page,searchN,searchV);
		
		// 페이지별 글 리스트
		ArrayList<BoderDto> result = new ArrayList<BoderDto>();
		// 주석테스트
//		// 글 번호 시작 위치
//		int start = (page-1)*plist;
//		//삼항연산자 사용
//		int size = plist <= (list.size() - start)?plist:list.size() - start; 
//		
		// 한페이지당 출력하는 행보다 적게 result에 넣기
		for(int i=0; i<list.size(); i++) {
			result.add(i, list.get(i));
		}
		int pageArr[] = new int[5];
		
		if(page <= 3) {					// page 1,2,3 클릭 시 1,2,3,4,5 번호 출력
			for(int i=0; i<5; i++) {	// 배열 번호를 맞춘것
				pageArr[i] = i+1;		// 해당 배열에 값 넣기
			}
		}else {							// page 4이상의 번호 클릭 시 해당 번호가 가운데 오도록 출력 
			for(int i=0; i<5;i++) {
				pageArr[i] = page - 2 + i;
			}
		}
		
		// 글 목록
		model.addAttribute("result",result);
		
		// 페이지 번호
		model.addAttribute("pageArr",pageArr);
		
		// 페이지 체크 개수 >> 번호가 체크개수보다 적은지 체크 용도로 사용(1페이지까지 존재 시 1까지만 누를 수 있도록, 2이상의 번호를 누르면 안됨)
		model.addAttribute("page_chk", page_chk);
		
		// 페이지 종류번호
		model.addAttribute("tb_cat",cate);
		
		return "tb_list2";
	}
	
	@RequestMapping(value="/reply_list2.do")
	public List<ReplyDto> reply_list2(ReplyDto dto) {
		
		List<ReplyDto> list = daoInter.selectReply2(dto);
		
		return list;
	}

}
