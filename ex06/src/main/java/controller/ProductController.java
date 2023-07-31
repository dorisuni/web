package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;


import model.ProductDAO;
import model.ProductVO;

@WebServlet(value = { "/pro/list", "/pro/list.json","/pro/total" })
public class ProductController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	ProductDAO dao = new ProductDAO();
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	DecimalFormat df = new DecimalFormat("#,###");

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();
		RequestDispatcher dis = request.getRequestDispatcher("/home.jsp");
		switch (request.getServletPath()) {
		case "/pro/list":
			request.setAttribute("pageName", "/pro/list.jsp");
			dis.forward(request, response);
			break;
		case "/pro/list.json":// /pro/list.json?page=1&query=냉장고
			int page = Integer.parseInt(request.getParameter("page"));
			String query = request.getParameter("query");
			
			ArrayList<ProductVO> array = dao.list(page, query);
			JSONArray jArray = new JSONArray();
			for (ProductVO vo : array) {
				JSONObject obj = new JSONObject();
				obj.put("code", vo.getCode());
				obj.put("name", vo.getName());
				obj.put("price", vo.getPrice());
				obj.put("fprice", df.format(vo.getPrice()));
				obj.put("fdate", sdf.format(vo.getRdate()));
				jArray.add(obj);
			}
			out.print(jArray);
			break;
		case "/pro/total":
			String query1 = request.getParameter("query");
			out.print(dao.total(query1));
			
			break;
			
		}

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
	}

}
