package controller;

import java.util.ArrayList;

import model.ProDAO;
import model.ProVO;
import model.StuDAO;
import model.StuVO;

public class DAOtest {

	public static void main(String[] args) {
		StuDAO dao = new StuDAO();
		
		
		
//		System.out.println("검색수:"+dao.total(""));
		
		
		
		ArrayList<StuVO> array= dao.list(1,"4","year");
		
		for(StuVO vo : array) {
			System.out.println(vo.toString());
		}
		System.out.println("검색수:"+dao.total("4", "year"));
}

}
