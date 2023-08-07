package model;

public class PurchaseVO {
	private String pid;
	private String uid;
	private String raddress1;
	private String raddress2;
	private String rphone;
	private int purSum;
	private int status;
	private String purDate;
	public String getPid() {
		return pid;
	}
	public void setPid(String pid) {
		this.pid = pid;
	}
	public String getUid() {
		return uid;
	}
	public void setUid(String uid) {
		this.uid = uid;
	}
	public String getRaddress1() {
		return raddress1;
	}
	public void setRaddress1(String raddress1) {
		this.raddress1 = raddress1;
	}
	public String getRaddress2() {
		return raddress2;
	}
	public void setRaddress2(String raddress2) {
		this.raddress2 = raddress2;
	}
	public String getRphone() {
		return rphone;
	}
	public void setRphone(String rphone) {
		this.rphone = rphone;
	}
	public int getPurSum() {
		return purSum;
	}
	public void setPurSum(int purSum) {
		this.purSum = purSum;
	}
	public int getStatus() {
		return status;
	}
	public void setStatus(int status) {
		this.status = status;
	}
	public String getPurDate() {
		return purDate;
	}
	public void setPurDate(String purDate) {
		this.purDate = purDate;
	}
	@Override
	public String toString() {
		return "PurchaseVO [pid=" + pid + ", uid=" + uid + ", raddress1=" + raddress1 + ", raddress2=" + raddress2
				+ ", rphone=" + rphone + ", purSum=" + purSum + ", status=" + status + ", purDate=" + purDate + "]";
	}
}
