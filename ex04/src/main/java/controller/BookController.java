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

import model.BookDAO;
import model.BookVO;


@WebServlet(value={"/book/search","/book/insert","/book/list","/book/list.json","/book/total"})
public class BookController extends HttpServlet {
	private static final long serialVersionUID = 1L;
    BookDAO dao = new BookDAO();
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		RequestDispatcher dis = request.getRequestDispatcher("/home.jsp");
		//브라우저라고 생각해라. 여기다가 출력할 때
		PrintWriter out = response.getWriter();
		Gson gson = new Gson();
		
		switch(request.getServletPath()) {
		
		case "/book/total":
			out.println(dao.total());
			break;
		
		case "/book/search":
			request.setAttribute("pageName", "/book/search.jsp");
			dis.forward(request, response);
			break;
			
		case "/book/list":
			request.setAttribute("pageName", "/book/list.jsp");
			dis.forward(request, response);
			break;
		
		case "/book/list.json":
			int page = Integer.parseInt(request.getParameter("page"));
			out.println(gson.toJson(dao.list(page)));
			
			break;
		}
		
		
	
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		switch(request.getServletPath()) {
		
		case("/book/insert"): //rest api
			BookVO vo = new BookVO();
			vo.setIsbn(request.getParameter("isbn"));
			vo.setTitle(request.getParameter("title"));
			vo.setPrice(Integer.parseInt(request.getParameter("price")));
			vo.setThumbnail(request.getParameter("thumbnail"));
			vo.setUrl(request.getParameter("url"));
			vo.setPublisher(request.getParameter("publisher"));
			vo.setAuthors(request.getParameter("authors"));
			vo.setContents(request.getParameter("contents"));
//			System.out.println(vo.toString());
			dao.insert(vo);
			break;

		
		
		}
		
		
		
	}

}
