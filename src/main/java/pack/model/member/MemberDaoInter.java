package pack.model.member;

import java.util.ArrayList;

import pack.controller.member.MemberBean;

public interface MemberDaoInter {
	boolean insert(MemberBean bean);
	public MemberBean login(MemberBean bean);
	public void memberUpdate(MemberBean bean) throws Exception;
	public void memberDelete(MemberBean bean) throws Exception;
	public void changepwd(MemberBean bean) throws Exception;
	public int checkid(MemberBean bean) throws Exception;
	MemberBean findpwd(String email);
}
 