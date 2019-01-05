package project;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/ProjectGetNameServlet")
public class ProjectGetNameServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		String companyCode = request.getParameter("companyCode");
		String projectCode = request.getParameter("projectCode");
		if(companyCode == null || companyCode.equals("") || projectCode == null || projectCode.equals("")) {
			response.getWriter().write("");
		} else {
			try {
				response.getWriter().write(new ProjectDAO().getProjectName(companyCode, projectCode));
			} catch(Exception e) {
				e.printStackTrace();
				response.getWriter().write("");
			}
		}
	}

}
