package model;

import java.util.ArrayList;

public class DAOTest {

	public static void main(String[] args) {
		ProductDAO dao = new ProductDAO();
		System.out.println("데이터검색수:"+dao.total(""));
		
		
		
//		ArrayList<ProductVO> array = dao.list(1, "비스포크");
//		for(ProductVO vo:array) {
//			System.out.println(vo.toString());
//		}
	}

}
