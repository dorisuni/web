package model;

import java.util.*;
import java.sql.*;


public class LocalDAO {
	
	
	//검색수
	public int total(String query) {
		int total=0;
		try {
			String sql="select count(*) cnt from local where lname like ?";
			PreparedStatement ps=Database.CON.prepareStatement(sql);
			ps.setString(1, "%" + query + "%");
			ResultSet rs=ps.executeQuery();
			while(rs.next()) {
				total=rs.getInt("cnt");
			}
		}catch(Exception e) {
			System.out.println("지역수:" + e.toString());
		}
		return total;
	}
	
	
	
	
	public ArrayList<LocalVO> list(int page, String query){
		ArrayList<LocalVO> array=new ArrayList<LocalVO>();
		try {
			String sql="select * from local where lname like ? or laddress like ? or lphone like ?";
			sql+=" order by id desc limit ?,5";
			PreparedStatement ps=Database.CON.prepareStatement(sql);
			ps.setString(1, "%" + query + "%");
			ps.setString(2, "%" + query + "%");
			ps.setString(3, "%" + query + "%");
			ps.setInt(4, (page-1) * 5);
			ResultSet rs=ps.executeQuery();
			while(rs.next()) {
				LocalVO vo=new LocalVO();
				vo.setId(rs.getInt("id"));
				vo.setLid(rs.getString("lid"));
				vo.setLname(rs.getString("lname"));
				vo.setLaddress(rs.getString("laddress"));
				vo.setLphone(rs.getString("lphone"));
				array.add(vo);
			}
		}catch(Exception e) {
			System.out.println("지역목록:" + e.toString());
		}
		return array;
	}
	
	
	
	
	
}
