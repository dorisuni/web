package model;

import java.sql.PreparedStatement;

public class PurchaseDAO {
	//구매(주문)등록
	public void insert(PurchaseVO vo) {
		try {
			String sql = "insert into purchase(pid,uid,raddress1,raddress2,rphone,purSum) values(?,?,?,?,?,?)";
			PreparedStatement ps = Database.CON.prepareStatement(sql);
			ps.setString(1, vo.getPid());
			ps.setString(2, vo.getUid());
			ps.setString(3, vo.getRaddress1());
			ps.setString(4, vo.getRaddress2());
			ps.setString(5, vo.getRphone());
			ps.setInt(6, vo.getPurSum());
			ps.execute();
		}catch(Exception e) {
			System.out.println("구매등록오류:"+e.toString());
		}
	}
}
