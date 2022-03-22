package pack.model.board2;

import java.util.List;

import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.support.SqlSessionDaoSupport;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;

import pack.controller.board.ReplyBean;

@Repository
public class ReplyDaoImpl extends SqlSessionDaoSupport implements ReplyDaoInter {

	@Autowired
	public ReplyDaoImpl(SqlSessionFactory factory) {
		setSqlSessionFactory(factory);
	}
	
	// 댓글 읽어오기
	@Override
	public List<ReplyDto> selectReply(int num) {

		return getSqlSession().selectList("selectReply", num);
	}

	// 댓글 추가
	@Override
	public boolean insertReply(ReplyBean bean) {
		
		try {
			int re = getSqlSession().insert("insertReply", bean);
			if(re > 0) {
				return true;
			}else {
				return false;			
			}
			
		} catch (Exception e) {
			System.out.println("insertReply err: "+e);
			return false;
		}
	}
	
	// 댓글 수정
	@Override
	public boolean updateReply(ReplyBean bean) {
		try {
			int re = getSqlSession().update("updateReply", bean);
			if(re > 0) {
				return true;
			}else {
				return false;			
			}
			
		} catch (Exception e) {
			System.out.println("updateReply err: "+e);
			return false;
		}
	}
	
	// 댓글 삭제
	@Override
	public boolean deleteReply(ReplyBean bean) {
		try {
			int re = getSqlSession().insert("deleteReply", bean);
			if(re > 0) {
				return true;
			}else {
				return false;			
			}
			
		} catch (Exception e) {
			System.out.println("insertReply err: "+e);
			return false;
		}
	}

	@Override
	public List<ReplyDto> selectReply2(ReplyDto dto) {
	
		return getSqlSession().selectList("selectReply2", dto);
	}
	
	//onum 갱신
	@Override
	public boolean updateOnum(ReplyBean bean) {
		// 댓글에서 onum 갱신
		int re=getSqlSession().update("updateOnum", bean);
		if(re > 0) {
			return true;
		}else {
			return false;			
		}
	}


	
}
