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

import model.ProDAO;
import model.ProVO;
@WebServlet(value={"/pro/list", "/pro/list.json", "/pro/total"})
public class ProfessorsServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    ProDAO dao=new ProDAO();   
    SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
    DecimalFormat df=new DecimalFormat("#,###원");
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out=response.getWriter();
		RequestDispatcher dis=request.getRequestDispatcher("/home.jsp");
		
		switch(request.getServletPath()) {
		case "/pro/list":
			request.setAttribute("pageName", "/pro/list.jsp");
			dis.forward(request, response);
			break;
		case "/pro/list.json":
			String key=request.getParameter("key");
			String query=request.getParameter("query");
			int page=Integer.parseInt(request.getParameter("page"));
			ArrayList<ProVO> array=dao.list(page, query, key);
			JSONArray jArray=new JSONArray();
			for(ProVO vo:array) {
				JSONObject obj=new JSONObject();
				obj.put("pcode", vo.getPcode());
				obj.put("pname", vo.getPname());
				obj.put("dept", vo.getDept());
				obj.put("hiredate", sdf.format(vo.getHiredate()));
				obj.put("salary", df.format(vo.getSalary()));
				obj.put("title", vo.getTitle());
				jArray.add(obj);
			}
			out.print(jArray);
			break;
		case "/pro/total":
			key=request.getParameter("key");
			query=request.getParameter("query");
			out.print(dao.total(query, key));
			break;
		}
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	}

}
