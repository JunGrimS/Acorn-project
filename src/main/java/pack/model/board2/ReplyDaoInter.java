package pack.model.board2;

import java.util.List;

import org.springframework.stereotype.Component;

import pack.controller.board.ReplyBean;

public interface ReplyDaoInter {
	
	List<ReplyDto> selectReply(int num);		//댓글 읽어오기
	List<ReplyDto> selectReply2(ReplyDto dto); 	// 답글 리스트 읽어오기
	
	
	boolean updateOnum(ReplyBean bean);			//onum 갱신
	boolean insertReply(ReplyBean bean);		//댓글 추가
	boolean updateReply(ReplyBean bean);		//댓글 수정
	boolean deleteReply(ReplyBean bean);		//댓글 삭제
}
