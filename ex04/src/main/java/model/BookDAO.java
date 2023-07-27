package model;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.*;

public class BookDAO {
	//전체데이터갯수
	public int total() {
		int total=0;
		try {
			String sql = "select count(*) cnt from books";
			PreparedStatement ps = Database.CON.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			while(rs.next()) {
				total = rs.getInt("cnt");
			}
			
			
		}catch(Exception e) {
			System.out.println("도서목록:"+e.toString());
		
	}return total;
	}
	
	
	//도서목록출력
	public List<BookVO> list(int page){
		ArrayList<BookVO> array = new ArrayList<>();
		try {
			String sql = "select * from books order by seq desc limit ?,5";
			PreparedStatement ps = Database.CON.prepareStatement(sql);
			ps.setInt(1, (page-1)*5);
			ResultSet rs = ps.executeQuery();
			while(rs.next()) {
				BookVO vo = new BookVO();
				vo.setSeq(rs.getInt("seq"));
				vo.setTitle(rs.getString("title"));
				vo.setThumbnail(rs.getString("thumbnail"));
				vo.setPrice(rs.getInt("price"));
				vo.setContents(rs.getString("contents"));
				vo.setPublisher(rs.getString("publisher"));
				array.add(vo);
			}
			
			
		}catch(Exception e) {
			System.out.println("도서목록:"+e.toString());
		}
		return array;
	}
	
	
	//도서등록
	public void insert(BookVO vo) {
		try {
			String sql1= "select * from books where isbn=?";
			PreparedStatement ps1 = Database.CON.prepareStatement(sql1);
			ps1.setString(1, vo.getIsbn());
			ResultSet rs = ps1.executeQuery();
			if(!rs.next()) {
				String sql = "insert into books(isbn,title,thumbnail,price,authors,url,contents,publisher) values (?,?,?,?,?,?,?,?)";
				PreparedStatement ps = Database.CON.prepareStatement(sql);
				ps.setString(1, vo.getIsbn());
				ps.setString(2, vo.getTitle());
				ps.setString(3, vo.getThumbnail());
				ps.setInt(4, vo.getPrice());
				ps.setString(5, vo.getAuthors());
				ps.setString(6, vo.getUrl());
				ps.setString(7, vo.getContents());
				ps.setString(8, vo.getPublisher());
				ps.execute();
			}
		}catch(Exception e) {
			System.out.println("도서등록오류:"+e.toString());
		}
	}
	
	
	
	
	
	
}
