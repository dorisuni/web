package model;
import java.util.*;
import java.sql.*;

public class ProDAO {

	//모든 교수목록
	public ArrayList<ProVO> all(){
		ArrayList<ProVO> array=new ArrayList<ProVO>();
		try {
			String sql="select * from professors order by pname asc";
			PreparedStatement ps = Database.CON.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			while(rs.next()){
				ProVO vo = new ProVO();
				vo.setPcode(rs.getString("pcode"));
				vo.setPname(rs.getString("pname"));
				vo.setDept(rs.getString("dept"));
				vo.setHiredate(rs.getString("hiredate"));
				vo.setTitle(rs.getString("title"));
				vo.setSalary(rs.getInt("salary"));
				array.add(vo);
			}
			
			
		}catch(Exception e) {
			System.out.println("교수목록"+e.toString());
		}


		return array;
	}
	
	public void update(ProVO vo) {
		
		try {
			String sql="update professors set pname=?,dept=?,title=?,salary=?,hiredate=?";
					sql+=" where pcode=?";
			PreparedStatement ps = Database.CON.prepareStatement(sql);
					
			ps.setString(1, vo.getPname());
			ps.setString(2, vo.getDept());
			ps.setString(3, vo.getTitle());
			ps.setInt(4, vo.getSalary());
			ps.setString(5, vo.getHiredate().toString());
			ps.setString(6, vo.getPcode());
			ps.execute();
			
		}catch(Exception e) {
			System.out.println("교수수정"+e.toString());
		}
		
	}
	
	//교수정보읽기
	public ProVO read(String pcode) {
		ProVO vo = new ProVO();
		try {
			String 	sql ="select * from professors";
					sql+=" where pcode=?";
			PreparedStatement ps=Database.CON.prepareStatement(sql);
			ps.setString(1,  pcode);
			
			ResultSet rs=ps.executeQuery();
			while(rs.next()) {
				vo.setPcode(rs.getString("pcode"));
				vo.setPname(rs.getString("pname"));
				vo.setDept(rs.getString("dept"));
				vo.setHiredate(rs.getString("hiredate"));
				vo.setTitle(rs.getString("title"));
				vo.setSalary(rs.getInt("salary"));
			}
		}catch(Exception e) {
			System.out.println("교수정보읽기:" + e.toString());
		}
		
		
		return vo;
				
	}
	
	
	
	//교수입력
	
	public void insert(ProVO vo) {
		try {
			int ncode = 0;
			String sql="select max(pcode)+1 ncode from professors";
			PreparedStatement ps = Database.CON.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			if(rs.next()) {
				ncode=rs.getInt("ncode");
			}
			
			sql="insert into professors(pcode,pname,dept,title,salary,hiredate)";
			sql+=" values(?,?,?,?,?,?)";
			ps = Database.CON.prepareStatement(sql);
			
			ps.setInt(1, ncode);
			ps.setString(2, vo.getPname());
			ps.setString(3, vo.getDept());
			ps.setString(4, vo.getTitle());
			ps.setInt(5, vo.getSalary());
			ps.setString(6, vo.getHiredate().toString());
			ps.execute();
			
		}catch(Exception e) {
			System.out.println("교수입력오류"+e.toString());
		}
		
	}
	
	
	
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
				vo.setHiredate(rs.getString("hiredate"));
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
