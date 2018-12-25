package projectgroup;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/ProjectGroupGetServlet")
public class ProjectGroupGetServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		String companyCode = request.getParameter("companyCode");
		String projectGroup = request.getParameter("projectGroup");
		if(companyCode == null || companyCode.equals("") || projectGroup == null || projectGroup.equals("")) {
			response.getWriter().write("");
		} else {
			try {
				response.getWriter().write(getGroup(companyCode, projectGroup));
			} catch(Exception e) {
				response.getWriter().write("");
			}
		}
	}
	
	public String getGroup(String companyCode, String projectGroup) {
		StringBuffer result = new StringBuffer("");
		result.append("{\"result\":[");
		ProjectGroupDAO projectGroupDAO = new ProjectGroupDAO();
		ProjectGroupDTO group = projectGroupDAO.getProjectGroup(companyCode, projectGroup);
		if(group == null) {
			return "";
		} else {
			result.append("{\"value\": \"" + group.getProjectGroup() + "\"},");
			result.append("{\"value\": \"" + group.getGroupName() + "\"}]}");
		}
		return result.toString();
	}
}