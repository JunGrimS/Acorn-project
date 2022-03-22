package pack.controller.board;


public class BoderBean {
	private int tb_no, tb_cat, tb_readcnt;
	private String tb_region, tb_title, tb_content, tb_id, tb_date;
	//검색기능 필드
	private String searchN, searchV;
	 
	public int getTb_no() {
		return tb_no;
	}
	public void setTb_no(int tb_no) {
		this.tb_no = tb_no;
	}
	public int getTb_cat() {
		return tb_cat;
	}
	public void setTb_cat(int tb_cat) {
		this.tb_cat = tb_cat;
	}
	public int getTb_readcnt() {
		return tb_readcnt;
	}
	public void setTb_readcnt(int tb_readcnt) {
		this.tb_readcnt = tb_readcnt;
	}
	public String getTb_region() {
		return tb_region;
	}
	public void setTb_region(String tb_region) {
		this.tb_region = tb_region;
	}
	public String getTb_title() {
		return tb_title;
	}
	public void setTb_title(String tb_title) {
		this.tb_title = tb_title;
	}
	public String getTb_content() {
		return tb_content;
	}
	public void setTb_content(String tb_content) {
		this.tb_content = tb_content;
	}
	public String getTb_id() {
		return tb_id;
	}
	public void setTb_id(String tb_id) {
		this.tb_id = tb_id;
	}
	public String getTb_date() {
		return tb_date;
	}
	public void setTb_date(String tb_date) {
		this.tb_date = tb_date;
	}
	
	
}
