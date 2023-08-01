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

import model.ProVO;
import model.StuDAO;
import model.StuVO;

@WebServlet(value={"/stu/list","/stu/list.json","/stu/total"})
public class StudentServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	StuDAO dao = new StuDAO();

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out=response.getWriter();
		RequestDispatcher dis=request.getRequestDispatcher("/home.jsp");
		
		switch(request.getServletPath()) {
		case "/stu/list":
			request.setAttribute("pageName", "/stu/list.jsp");
			dis.forward(request, response);
		break;
		
		case "/stu/list.json":
			int page= Integer.parseInt(request.getParameter("page"));
			String query = request.getParameter("query");
			String key = request.getParameter("key");
			ArrayList<StuVO> array = dao.list(page, query, key);
			JSONArray jArray=new JSONArray();
			for(StuVO vo:array) {
				JSONObject obj=new JSONObject();
				obj.put("scode", vo.getScode());
				obj.put("sname", vo.getSname());
				obj.put("dept", vo.getDept());
				obj.put("year", vo.getYear());
				obj.put("advisor", vo.getAdvisor());
				obj.put("birthday", vo.getBirthday().toString());
				obj.put("pname",vo.getPname());
				jArray.add(obj);
			}
			out.print(jArray);
			break;
		
		case "/stu/total":
			 query = request.getParameter("query");
			 key = request.getParameter("key");
			 out.print(dao.total(query, key));
			break;
		}
		
		
		
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
