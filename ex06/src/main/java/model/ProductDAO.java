package model;

import java.util.*;
import java.sql.*;

public class ProductDAO {
	//상품수
	public int total(String query) {
		int total = 0;

		try {
			String sql = "select count(*) cnt from products where name like ?";
			PreparedStatement ps = Database.CON.prepareStatement(sql);
			ps.setString(1, "%" + query + "%");
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				total = rs.getInt("cnt");
			}

		} catch (Exception e) {
			System.out.println("상품수:" + e.toString());
		}

		return total;
	}

	// 상품목록
	public ArrayList<ProductVO> list(int page, String query) {
		ArrayList<ProductVO> array = new ArrayList<ProductVO>();
		try {
			String sql = "select * from products where name like ? order by code desc limit ?,5";
			PreparedStatement ps = Database.CON.prepareStatement(sql);
			ps.setString(1, "%" + query + "%");
			ps.setInt(2, (page - 1) * 5);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				ProductVO vo = new ProductVO();
				vo.setCode(rs.getInt("code"));
				vo.setName(rs.getString("name"));
				vo.setPrice(rs.getInt("price"));
				vo.setRdate(rs.getTimestamp("rdate"));
				array.add(vo);

			}

		} catch (Exception e) {
			System.out.println("상품목록:" + e.toString());
		}

		return array;
	}

}
