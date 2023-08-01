package model;

import java.util.*;
import java.sql.*;

public class StuDAO {
	
	
	
	//학생검색수
	public int total(String query,String key) {
		int total = 0;
		try {
			String sql = "select count(*) cnt from view_stu";
			sql += " where " + key + " like ?";
	

			PreparedStatement ps = Database.CON.prepareStatement(sql);
			ps.setString(1, "%" + query + "%");
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				total=rs.getInt("cnt");
			}

		} catch (Exception e) {
			System.out.println("학생검색출력:" + e.toString());
		}
		return total;
	}
	
	
	// 목록출력하기
	public ArrayList<StuVO> list(int page, String query, String key) {
		ArrayList<StuVO> array = new ArrayList<StuVO>();
		try {
			String sql = "select * from view_stu";
			sql += " where " + key + " like ?";
			sql += "limit ?,5";

			PreparedStatement ps = Database.CON.prepareStatement(sql);
			ps.setString(1, "%" + query + "%");
			ps.setInt(2, (page - 1) * 5);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				StuVO vo = new StuVO();
				vo.setScode(rs.getString("scode"));
				vo.setSname(rs.getString("sname"));
				vo.setDept(rs.getString("dept"));
				vo.setYear(rs.getInt("year"));
				vo.setBirthday(rs.getDate("birthday"));
				vo.setAdvisor(rs.getString("advisor"));
				vo.setPname(rs.getString("pname"));
				array.add(vo);

			}

		} catch (Exception e) {
			System.out.println("학생목록출력:" + e.toString());
		}

		return array;

	}

}
