package pack.model.mytrip;

import org.springframework.stereotype.Component;

@Component
public class MyTripDetailDto {
	
	private String ti_id, loc_id, ti_content, ti_pic_url;
	private String loc_name, loc_region, loc_addr, loc_tel, loc_worktime;
	
	public String getLoc_id() {
		return loc_id;
	}
	public void setLoc_id(String loc_id) {
		this.loc_id = loc_id;
	} 
	public String getTi_id() {
		return ti_id;
	}
	public void setTi_id(String ti_id) {
		this.ti_id = ti_id;
	}
	public String getTi_content() {
		return ti_content;
	}
	public void setTi_content(String ti_content) {
		this.ti_content = ti_content;
	}
	public String getTi_pic_url() {
		return ti_pic_url;
	}
	public void setTi_pic_url(String ti_pic_url) {
		this.ti_pic_url = ti_pic_url;
	}
	
	
	public String getLoc_name() {
		return loc_name;
	}
	public void setLoc_name(String loc_name) {
		this.loc_name = loc_name;
	}
	public String getLoc_region() {
		return loc_region;
	}
	public void setLoc_region(String loc_region) {
		this.loc_region = loc_region;
	}
	public String getLoc_addr() {
		return loc_addr;
	}
	public void setLoc_addr(String loc_addr) {
		this.loc_addr = loc_addr;
	}
	public String getLoc_tel() {
		return loc_tel;
	}
	public void setLoc_tel(String loc_tel) {
		this.loc_tel = loc_tel;
	}
	public String getLoc_worktime() {
		return loc_worktime;
	}
	public void setLoc_worktime(String loc_worktime) {
		this.loc_worktime = loc_worktime;
	}
	
}
