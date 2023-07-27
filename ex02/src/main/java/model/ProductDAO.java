package model;
import java.sql.*;
import java.util.*;

public class ProductDAO {
	//전체상품수
	public int total() {
		int total=0;
		try {
			String sql="select count(*) cnt from products";
			PreparedStatement ps=Database.CON.prepareStatement(sql);
			ResultSet rs=ps.executeQuery();
			while(rs.next()) {
				total=rs.getInt("cnt");
			}
		}catch(Exception e) {
			System.out.println("상품전체수:" + e.toString());
		}
		return total;
	}
	
	//상품수정
	public void update(ProductVO vo) {
		try {
			String sql="update products set name=?,price=?,rdate=now() where code=?";
			PreparedStatement ps=Database.CON.prepareStatement(sql);
			ps.setString(1, vo.getName());
			ps.setInt(2, vo.getPrice());
			ps.setInt(3, vo.getCode());
			ps.execute();
		}catch(Exception e) {
			System.out.println("상품수정:" + e.toString());
		}
	}
	
	//상품삭제
	public void delete(String code) {
		try {
			String sql="delete from products where code=?";
			PreparedStatement ps=Database.CON.prepareStatement(sql);
			ps.setString(1, code);
			ps.execute();
		}catch(Exception e) {
			System.out.println("상품삭제:" + e.toString());
		}
	}
	//상품정보
	public ProductVO read(String code) {
		ProductVO vo=new ProductVO();
		try {
			String sql="select * from products where code=?";
			PreparedStatement ps=Database.CON.prepareStatement(sql);
			ps.setInt(1, Integer.parseInt(code));
			ResultSet rs=ps.executeQuery();
			while(rs.next()) {
				vo.setCode(rs.getInt("code"));
				vo.setName(rs.getString("name"));
				vo.setPrice(rs.getInt("price"));
				vo.setRdate(rs.getTimestamp("rdate"));
			}
		}catch(Exception e) {
			System.out.println("상품정보:" + e.toString());
		}
		return vo;
	}
	
	//상품등록
	public void insert(ProductVO vo) {
		try {
			String sql="insert into products(name, price) values(?,?)";
			PreparedStatement ps=Database.CON.prepareStatement(sql);
			ps.setString(1, vo.getName());
			ps.setInt(2, vo.getPrice());
			ps.execute();
		}catch(Exception e) {
			System.out.println("상품등록:" + e.toString());
		}
	}
	
	//상품목록
	public ArrayList<ProductVO> list(int page){
		ArrayList<ProductVO> array=new ArrayList<>();
		try {
			String sql="select * from products order by code desc limit ?,5";
			PreparedStatement ps=Database.CON.prepareStatement(sql);
			ps.setInt(1, (page-1)*5);
			ResultSet rs=ps.executeQuery();
			while(rs.next()) {
				ProductVO vo=new ProductVO();
				vo.setCode(rs.getInt("code"));
				vo.setName(rs.getString("name"));
				vo.setPrice(rs.getInt("price"));
				vo.setRdate(rs.getTimestamp("rdate"));
				array.add(vo);
			}
		}catch(Exception e) {
			System.out.println("상품목록:" + e.toString());
		}
		return array;
	}
}
