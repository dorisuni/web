package model;
import java.util.*;

import java.sql.*;

public class ProductDAO {
	//메소드 만들기
	
	//목록출력메소드
	public List<ProductVO> list(){
		List<ProductVO> array= new ArrayList<ProductVO>();
		try {
			String sql = "select * from products order by code desc";
			PreparedStatement ps = Database.CON.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			while(rs.next()) {
				ProductVO vo = new ProductVO();
				vo.setCode(rs.getInt("code"));
				vo.setName(rs.getString("name"));
				vo.setPrice(rs.getInt("price"));
				vo.setRdate(rs.getTimestamp("rdate"));
				array.add(vo);
			}
			
			
		}catch(Exception e) {
			System.out.println("상품목록출력오류:"+e.toString());
		}
		
		
		
		return array;
		
	}
	
	
	
}
