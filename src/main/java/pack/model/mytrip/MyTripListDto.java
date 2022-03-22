package pack.model.mytrip;

public class MyTripListDto {
	
	private int ti_num;
	private String ti_id, user_id, ti_trip_name, ti_visit_date, ti_reg_write;
	
	public String getTi_id() {
		return ti_id;
	} 
	public void setTi_id(String ti_id) {
		this.ti_id = ti_id;
	}
	public int getTi_num() {
		return ti_num;
	}
	public void setTi_num(int ti_num) {
		this.ti_num = ti_num;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public String getTi_trip_name() {
		return ti_trip_name;
	}
	public void setTi_trip_name(String ti_trip_name) {
		this.ti_trip_name = ti_trip_name;
	}
	public String getTi_visit_date() {
		return ti_visit_date;
	}
	public void setTi_visit_date(String ti_visit_date) {
		this.ti_visit_date = ti_visit_date;
	}
	public String getTi_reg_write() {
		return ti_reg_write;
	}
	public void setTi_reg_write(String ti_reg_write) {
		this.ti_reg_write = ti_reg_write;
	}
	
}
