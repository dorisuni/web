package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.UUID;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.PurchaseDAO;
import model.PurchaseVO;


@WebServlet(value={"/purchase/insert"})
public class PurchaseController extends HttpServlet {
	private static final long serialVersionUID = 1L;
    PurchaseDAO dao = new PurchaseDAO();

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		switch(request.getServletPath()) {
		case "/purchase/insert":
			PurchaseVO vo = new PurchaseVO();
			UUID uuid = UUID.randomUUID();
			String pid = uuid.toString().substring(0,13);
			vo.setPid(pid);
			vo.setUid(request.getParameter("uid"));
			vo.setRaddress1(request.getParameter("address1"));
			vo.setRaddress2(request.getParameter("address2"));
			vo.setRphone(request.getParameter("phone"));
			vo.setPurSum(Integer.parseInt(request.getParameter("sum")));
			System.out.println(vo.toString());
//			dao.insert(vo);
			out.print(pid);
			break;
		}
	}

}
