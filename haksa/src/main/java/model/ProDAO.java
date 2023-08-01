package model;
import java.util.*;
import java.sql.*;

public class ProDAO {
	//교수수
	public int total(String query, String key) {
		int total=0;
		try {
			String 	sql ="select count(*) total from professors";
					sql+=" where " + key + " like ?";
			PreparedStatement ps=Database.CON.prepareStatement(sql);
			ps.setString(1, "%" + query + "%");
			ResultSet rs=ps.executeQuery();
			while(rs.next()) {
				total=rs.getInt("total");
			}
		}catch(Exception e) {
			System.out.println("교수수:" + e.toString());
		}
		return total;
	}
	//교수목록
	public ArrayList<ProVO> list(int page, String query, String key){
		ArrayList<ProVO> array=new ArrayList<ProVO>();
		try {
			String 	sql ="select * from professors";
					sql+=" where " + key + " like ?";
					sql+=" limit ?,5";
			PreparedStatement ps=Database.CON.prepareStatement(sql);
			ps.setString(1, "%" + query + "%");
			ps.setInt(2, (page-1)*5);
			
			ResultSet rs=ps.executeQuery();
			while(rs.next()) {
				ProVO vo=new ProVO();
				vo.setPcode(rs.getString("pcode"));
				vo.setPname(rs.getString("pname"));
				vo.setDept(rs.getString("dept"));
				vo.setHiredate(rs.getDate("hiredate"));
				vo.setTitle(rs.getString("title"));
				vo.setSalary(rs.getInt("salary"));
				array.add(vo);
			}
		}catch(Exception e) {
			System.out.println("교수목록:" + e.toString());
		}
		return array;
	}
}
