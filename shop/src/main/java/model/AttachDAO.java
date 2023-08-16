package model;
import java.sql.*;
import java.util.*;

public class AttachDAO {
	public void insert(AttachVO vo) {
		try {
			String sql="insert into attatch(gid, image) values(?, ?)";
			PreparedStatement ps=Database.CON.prepareStatement(sql);
			ps.setString(1, vo.getGid());
			ps.setString(2, vo.getImage());
			ps.execute();
		}catch(Exception e) {
			System.out.println("첨부파일등록:" + e.toString());
		}
	}

	public ArrayList<AttachVO> list(String gid){
		ArrayList<AttachVO> array=new ArrayList<AttachVO>();
		try {
			String sql="select * from attatch where gid=?";
			PreparedStatement ps=Database.CON.prepareStatement(sql);
			ps.setString(1, gid);
			ResultSet rs=ps.executeQuery();
			while(rs.next()) {
				AttachVO vo=new AttachVO();
				vo.setAid(rs.getInt("aid"));
				vo.setGid(rs.getString("gid"));
				vo.setImage(rs.getString("image"));
				array.add(vo);
			}
		}catch(Exception e) {
			System.out.println("첨부파일목록:" + e.toString());
		}
		return array;
	}
}
