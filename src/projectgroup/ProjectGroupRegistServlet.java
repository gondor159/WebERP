package projectgroup;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/ProjectGroupRegistServlet")
public class ProjectGroupRegistServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		String companyCode = request.getParameter("companyCode");
		String projectGroup = request.getParameter("projectGroup");
		String groupName = request.getParameter("groupName");
		String startDate = request.getParameter("startDate");
		String endDate = request.getParameter("endDate");
		String note = request.getParameter("note");
		if(companyCode == null || companyCode.equals("") || projectGroup == null || projectGroup.equals("") || groupName == null || groupName.equals("")) {
			response.getWriter().write("0");
		} else {
			if(startDate == null || startDate.equals("") ) {
				startDate = "0000-00-00";
			}
			if(endDate == null || endDate.equals("") ) {
				endDate = "0000-00-00";
			}
			int result = new ProjectGroupDAO().insertProjectGroup(companyCode, projectGroup, groupName, startDate, endDate, note);
			if(result == 1) {
				response.getWriter().write("1");
			} else {
				response.getWriter().write("-1");
			}
		}
	}

}
