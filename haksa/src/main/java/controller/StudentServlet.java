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

import model.ProDAO;
import model.StuDAO;
import model.StuVO;


@WebServlet(value={"/stu/list", "/stu/list.json", "/stu/total", "/stu/insert", "/stu/update"})
public class StudentServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    StuDAO dao=new StuDAO();
    ProDAO pdao=new ProDAO();
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out=response.getWriter();
		RequestDispatcher dis=request.getRequestDispatcher("/home.jsp");
		
		switch(request.getServletPath()) {
		case "/stu/list":
			request.setAttribute("parray", pdao.all());
			request.setAttribute("pageName", "/stu/list.jsp");
			dis.forward(request, response);
			break;
		case "/stu/list.json"://stu/list.json?page=1&key=pname&query=이병렬
			int page=Integer.parseInt(request.getParameter("page"));
			String query=request.getParameter("query");
			String key=request.getParameter("key");
			ArrayList<StuVO> array=dao.list(page, query, key);
			JSONArray jArray=new JSONArray(); //ctrl + shift + o
			for(StuVO vo:array) {
				JSONObject obj=new JSONObject();
				obj.put("scode", vo.getScode());
				obj.put("sname", vo.getSname());
				obj.put("dept", vo.getDept());
				obj.put("year", vo.getYear());
				obj.put("advisor", vo.getAdvisor());
				obj.put("birthday", vo.getBirthday().toString());
				obj.put("pname", vo.getPname());
				jArray.add(obj);
			}
			out.println(jArray);
			break;
		case "/stu/total": //stu/total?query=4&key=year
			query=request.getParameter("query");
			key=request.getParameter("key");
			out.println(dao.total(query, key));
			break;
		case "/stu/update":
			request.setAttribute("vo", dao.read(request.getParameter("scode")));
			request.setAttribute("parray", pdao.all());
			request.setAttribute("pageName", "/stu/update.jsp");
			dis.forward(request, response);
			break;
		}
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		switch(request.getServletPath()) {
		case "/stu/insert":
			StuVO vo=new StuVO();
			vo.setSname(request.getParameter("sname"));
			vo.setDept(request.getParameter("dept"));
			vo.setBirthday(request.getParameter("birthday"));
			vo.setYear(Integer.parseInt(request.getParameter("year")));
			vo.setAdvisor(request.getParameter("advisor"));
			System.out.println(vo.toString());
			dao.insert(vo);
			response.sendRedirect("/stu/list");
			break;
		
		case "/stu/update":
			vo = new StuVO();
			vo.setScode(request.getParameter("scode"));
			vo.setSname(request.getParameter("sname"));
			vo.setDept(request.getParameter("dept"));
			vo.setBirthday(request.getParameter("birthday"));
			vo.setYear(Integer.parseInt(request.getParameter("year")));
			vo.setAdvisor(request.getParameter("advisor"));
			System.out.println(vo.toString());
			dao.update(vo);
			response.sendRedirect("/stu/list");
			break;
			
			
			
		}
	}
}
