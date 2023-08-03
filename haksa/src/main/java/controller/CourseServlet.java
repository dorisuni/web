package controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import model.*;
import java.util.*;

@WebServlet(value={"/cou/list", "/cou/total", "/cou/list.json", "/cou/insert","/cou/update"})
public class CourseServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    CouDAO dao=new CouDAO();  
    ProDAO pdao=new ProDAO();
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out=response.getWriter();
		RequestDispatcher dis=request.getRequestDispatcher("/home.jsp");
		
		switch(request.getServletPath()) {
		case "/cou/list":
			request.setAttribute("parray", pdao.all());
			request.setAttribute("pageName", "/cou/list.jsp");
			dis.forward(request, response);
			break;
		case "/cou/total": //브라우저 주소입력에 /cou/total?key=pname&query=이
			String key=request.getParameter("key");
			String query=request.getParameter("query");
			out.print(dao.total(key, query));
			break;
		case "/cou/list.json": //브라우저 주소입력에 /cou/list.json?key=pname&query=이&page=1
			int page=Integer.parseInt(request.getParameter("page"));
			key=request.getParameter("key");
			query=request.getParameter("query");
			Gson gson=new Gson();
			out.println(gson.toJson(dao.list(page, key, query)));
			break;
		case "/cou/update":
			request.setAttribute("vo", dao.read(request.getParameter("lcode")));
			request.setAttribute("parray", pdao.all());
			request.setAttribute("pageName", "/cou/update.jsp");
			dis.forward(request, response);
			break;
			
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		switch(request.getServletPath()) {
		case "/cou/insert":
			CourseVO vo=new CourseVO();
			vo.setLname(request.getParameter("lname"));
			vo.setRoom(request.getParameter("room"));
			vo.setHours(Integer.parseInt(request.getParameter("hours")));
			vo.setCapacity(Integer.parseInt(request.getParameter("capacity")));
			vo.setPersons(Integer.parseInt(request.getParameter("persons")));
			vo.setInstructor(request.getParameter("instructor"));
//			System.out.println(vo.toString());
			dao.insert(vo);
			response.sendRedirect("/cou/list");
			break;
			
		case "/cou/update":
			vo = new CourseVO();
			vo.setLcode(request.getParameter("lcode"));
			vo.setLname(request.getParameter("lname"));
			vo.setRoom(request.getParameter("room"));
			vo.setHours(Integer.parseInt(request.getParameter("hours")));
			vo.setCapacity(Integer.parseInt(request.getParameter("capacity")));
			vo.setPersons(Integer.parseInt(request.getParameter("persons")));
			vo.setInstructor(request.getParameter("instructor"));
//			System.out.println(vo.toString());
			dao.update(vo);
			response.sendRedirect("/cou/list");
			break;
			
		}
	}
}
