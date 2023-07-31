package controller;

import java.io.IOException;
import java.io.PrintWriter;
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
import java.text.*;

@WebServlet(value={"/pro/list", "/pro/list.json", "/pro/insert", "/pro/delete", "/pro/update"})
public class ProductController extends HttpServlet {
	private static final long serialVersionUID = 1L;
    ProductDAO dao=new ProductDAO();
    
    SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    DecimalFormat df=new DecimalFormat("#,###원");
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out=response.getWriter(); //json 데이터를 출력하기위해서 브라우저를 생성
		RequestDispatcher dis=request.getRequestDispatcher("/home.jsp");
		
		switch(request.getServletPath()) {
		case "/pro/list":
			request.setAttribute("pageName", "/pro/list.jsp");
			dis.forward(request, response);
			break;
		case "/pro/list.json":
			int page=request.getParameter("page")==null ? 1 :
					Integer.parseInt(request.getParameter("page"));
			String query=request.getParameter("query")==null ? "":
				request.getParameter("query");
			
			ArrayList<ProductVO> array=dao.list(page, query);
			
			//ArrayList -> JSONArray로 변환
			JSONArray jArray=new JSONArray();
			for(ProductVO vo:array) {
				JSONObject obj=new JSONObject();
				obj.put("code", vo.getCode());
				obj.put("name", vo.getName());
				obj.put("price", vo.getPrice());
				obj.put("fprice", df.format(vo.getPrice()));
				obj.put("fdate", sdf.format(vo.getRdate()));
				jArray.add(obj);
			}

			JSONObject jObject = new JSONObject();
			jObject.put("total", dao.total(query));
			jObject.put("items", jArray);
			
			out.print(jObject);
			break;
		}
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		switch(request.getServletPath()) {
		case "/pro/insert":
			ProductVO vo=new ProductVO();
			vo.setName(request.getParameter("name"));
			vo.setPrice(Integer.parseInt(request.getParameter("price")));
			System.out.println(vo.toString());
			dao.insert(vo);
			break;
		case "/pro/delete":
			int code=Integer.parseInt(request.getParameter("code"));
			dao.delete(code);
			break;
		case "/pro/update":
			vo=new ProductVO();
			vo.setName(request.getParameter("name"));
			vo.setPrice(Integer.parseInt(request.getParameter("price")));
			vo.setCode(Integer.parseInt(request.getParameter("code")));
			dao.update(vo);
			break;
		}
	}
}
