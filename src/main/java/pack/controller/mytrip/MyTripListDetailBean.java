package pack.controller.mytrip;

import org.springframework.stereotype.Component;

import lombok.Data;

@Component
@Data
public class MyTripListDetailBean {
	
	private String ti_id, loc_id, ti_content, ti_pic_url;
	
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

}
