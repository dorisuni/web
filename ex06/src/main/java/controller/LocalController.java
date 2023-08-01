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

import model.LocalDAO;
import model.LocalVO;


@WebServlet(value={"/local/list","/local/list.json","/local/total"})
public class LocalController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	LocalDAO dao=new LocalDAO();
	SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	DecimalFormat df=new DecimalFormat("#,###");

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out=response.getWriter();
		RequestDispatcher dis = request.getRequestDispatcher("/home.jsp");
		switch(request.getServletPath()) {
		
		case "/local/list":
			request.setAttribute("pageName", "local/list.jsp");
			dis.forward(request, response);
			break;
		
		case "/local/list.json"://pro/list.json?page=1&query=냉장고
			int page=Integer.parseInt(request.getParameter("page"));
			String query=request.getParameter("query");
			ArrayList<LocalVO> array=dao.list(page, query);
			JSONArray jArray=new JSONArray();
			for(LocalVO vo:array) {
				JSONObject obj=new JSONObject();
				obj.put("id", vo.getId());
				obj.put("lid", vo.getLid());
				obj.put("lname", vo.getLname());
				obj.put("laddress", vo.getLaddress());
				obj.put("lphone", vo.getLphone());
				jArray.add(obj);
			}
			out.print(jArray);
			break;
		
		case "/local/total":
			String query1=request.getParameter("query");
			out.print(dao.total(query1));
			break;
			
		}
		
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}

}
