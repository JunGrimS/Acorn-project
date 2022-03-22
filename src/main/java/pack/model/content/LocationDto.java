package pack.model.content;

import org.springframework.stereotype.Component;

import lombok.Data;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Component
public class LocationDto {
	 
	public String getLoc_id() {
		return loc_id;
	}

	public void setLoc_id(String loc_id) {
		this.loc_id = loc_id;
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

	public String getLoc_city() {
		return loc_city;
	}

	public void setLoc_city(String loc_city) {
		this.loc_city = loc_city;
	}

	public String getLoc_addr() {
		return loc_addr;
	}

	public void setLoc_addr(String loc_addr) {
		this.loc_addr = loc_addr;
	}

	public String getLoc_cat() {
		return loc_cat;
	}

	public void setLoc_cat(String loc_cat) {
		this.loc_cat = loc_cat;
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

	public String getLoc_nonwork() {
		return loc_nonwork;
	}

	public void setLoc_nonwork(String loc_nonwork) {
		this.loc_nonwork = loc_nonwork;
	}

	public String getLoc_parking() {
		return loc_parking;
	}

	public void setLoc_parking(String loc_parking) {
		this.loc_parking = loc_parking;
	}

	private String loc_id,loc_name,loc_region,loc_city,loc_addr,loc_cat,loc_lat,loc_long,loc_tel,loc_worktime,loc_nonwork,loc_parking,loc_desc,loc_ph_url;
	
}
