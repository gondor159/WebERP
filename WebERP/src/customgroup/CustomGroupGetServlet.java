package customgroup;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/CustomGroupGetServlet")
public class CustomGroupGetServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		String companyCode = request.getParameter("companyCode");
		String customGroup = request.getParameter("customGroup");
		if(companyCode == null || companyCode.equals("") || customGroup == null || customGroup.equals("")) {
			response.getWriter().write("");
		} else {
			try {
				response.getWriter().write(getGroup(companyCode, customGroup));
			} catch(Exception e) {
				response.getWriter().write("");
			}
		}
	}
	
	public String getGroup(String companyCode, String customGroup) {
		StringBuffer result = new StringBuffer("");
		result.append("{\"result\":[");
		CustomGroupDAO customGroupDAO = new CustomGroupDAO();
		CustomGroupDTO group = customGroupDAO.getCustomGroup(companyCode, customGroup);
		if(group == null) {
			return "";
		} else {
			result.append("{\"value\": \"" + group.getCustomGroup() + "\"},");
			result.append("{\"value\": \"" + group.getGroupName() + "\"}]}");
		}
		return result.toString();
	}
}