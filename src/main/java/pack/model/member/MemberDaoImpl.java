package pack.model.member;

import java.util.ArrayList;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.support.SqlSessionDaoSupport;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.zaxxer.hikari.util.ClockSource.Factory;

import pack.controller.member.MemberBean;

@Repository
public class MemberDaoImpl extends SqlSessionDaoSupport implements MemberDaoInter {
	@Autowired
	public MemberDaoImpl(SqlSessionFactory factory) {
		setSqlSessionFactory(factory);
	} 
	@Autowired
	public MemberDaoInter daoInter;

	@Override
	public boolean insert(MemberBean bean) {
		// 회원 가입
		int re = getSqlSession().insert("SignUp", bean);

		if (re > 0)
			return true;
		else
			return false;
	}
	
	@Override
	public int checkid(MemberBean bean) throws Exception {
		// 아이디 중복 확인
		int result =getSqlSession().selectOne("checkid",bean);
		return result;
	}

	@Override
	public MemberBean login(MemberBean bean) {
		// 로그인
		MemberBean res = null;
		try {
			res = getSqlSession().selectOne("Login", bean);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return res;
	}

	@Override
	public void memberUpdate(MemberBean bean) throws Exception {
		// 회원 정보 수정
		getSqlSession().update("MemberUpdate", bean);
	}
	
	@Override
	public void memberDelete(MemberBean bean) {
		// 회원 탈퇴
		try {
			getSqlSession().delete("MemberDelete", bean);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}
	
	@Override
	public MemberBean findpwd(String email) {
		// 비밀번호찾기
		return getSqlSession().selectOne("Findpwd",email);
	}
	
	
	@Override
	public void changepwd(MemberBean bean) throws Exception {
		// 비밀번호 변경
		getSqlSession().update("Updatepwd", bean);
		
	}
	
}	
