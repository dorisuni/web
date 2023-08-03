package controller;

import java.util.ArrayList;
import java.util.Date;

import model.CouDAO;
import model.CourseVO;
import model.ProDAO;
import model.ProVO;
import model.StuDAO;
import model.StuVO;

public class DAOtest {

	public static void main(String[] args) {
		
		
		CouDAO dao = new CouDAO();
		
		System.out.println(dao.getCode());
		
		
		
		
//		ProVO vo = new ProVO();
//		vo.setDept("전자");
//		vo.setPname("이몽룡");
//		vo.setTitle("조교수");
//		vo.setHiredate("2023-08-02");
//		dao.insert(vo);
		
		
		
//		CouDAO dao = new CouDAO();
//		ArrayList<CourseVO> array = dao.list(1, "pname", "이병렬");
//		
//		for(CourseVO vo: array) {
//			System.out.println(vo.toString());
//		}
//		System.out.println("검색수:"+dao.total("pname", "이병렬"));
	}
		
		
//		System.out.println("검색수:"+dao.total(""));
		
		
		
//		ArrayList<StuVO> array= dao.list(1,"4","year");
//		
//		for(StuVO vo : array) {
//			System.out.println(vo.toString());
//		}
//		System.out.println("검색수:"+dao.total("4", "year"));
//}

}
