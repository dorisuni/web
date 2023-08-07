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
@WebServlet(value={"/pro/list", "/pro/list.json", "/pro/total", "/pro/insert", "/pro/update"})
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
				obj.put("hiredate", vo.getHiredate());
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
		case "/pro/update":
			String pcode=request.getParameter("pcode");
			request.setAttribute("vo", dao.read(pcode));
			request.setAttribute("pageName", "/pro/update.jsp");
			dis.forward(request, response);
			break;
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		switch(request.getServletPath()) {
		case "/pro/insert":
			ProVO vo=new ProVO();
			vo.setPname(request.getParameter("pname"));
			vo.setDept(request.getParameter("dept"));
			vo.setSalary(Integer.parseInt(request.getParameter("salary")));
			vo.setTitle(request.getParameter("title"));
			vo.setHiredate(request.getParameter("hiredate"));
			System.out.println(vo.toString());
			dao.insert(vo);
			break;
		case "/pro/update":
			vo=new ProVO();
			vo.setPcode(request.getParameter("pcode"));
			vo.setPname(request.getParameter("pname"));
			vo.setDept(request.getParameter("dept"));
			vo.setSalary(Integer.parseInt(request.getParameter("salary")));
			vo.setTitle(request.getParameter("title"));
			vo.setHiredate(request.getParameter("hiredate"));
			System.out.println(vo.toString());
			dao.update(vo);
			response.sendRedirect("/pro/list");
			break;
		}
	}

}
