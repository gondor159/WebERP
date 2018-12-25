package projectgroup;

import java.io.IOException;
import java.net.URLDecoder;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/ProjectGroupGetListServlet")
public class ProjectGroupGetListServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		String companyCode = request.getParameter("companyCode");
		String division = request.getParameter("division");
		String input = request.getParameter("input");
		if(companyCode == null || companyCode.equals("") || division == null || division.equals("") || input == null || input.equals("")) {
			response.getWriter().write("");
		} else {
			try {
				/* 구분이 분류명일 경우 */
				if(division.equals("divisionProjectGroupName")) {
					response.getWriter().write(getListToName(companyCode, input));
				/* 구분이 분류코드일 경우 */
				} else if (division.equals("divisionProjectGroupCode")) {
					response.getWriter().write(getListToCode(companyCode, URLDecoder.decode(input, "UTF-8")));
				}
			} catch(Exception e) {
				response.getWriter().write("");
			}
		}
	}
	
	/* 구분이 분류명일 경우 */
	public String getListToName(String companyCode, String groupName) {
		StringBuffer result = new StringBuffer("");
		result.append("{\"result\":[");
		ProjectGroupDAO projectGroupDAO = new ProjectGroupDAO();
		ArrayList<ProjectGroupDTO> list = projectGroupDAO.getProjectGroupListToName(companyCode, groupName);
		if(list == null) { 
			return ""; 
		} else {
			for(int i = 0; i < list.size(); i++) {
				result.append("[{\"value\": \"" + list.get(i).getProjectGroup() + "\"},");
				result.append("{\"value\": \"" + list.get(i).getGroupName() + "\"}]");
				if(i != list.size() -1) result.append(",");
			}
		}
		result.append("]}");
		return result.toString();
	}
	
	/* 구분이 분류코드일 경우 */
	public String getListToCode(String companyCode, String projectGroup) {
		StringBuffer result = new StringBuffer("");
		result.append("{\"result\":[");
		ProjectGroupDAO projectGroupDAO = new ProjectGroupDAO();
		ArrayList<ProjectGroupDTO> list = projectGroupDAO.getProjectGroupListToCode(companyCode, projectGroup);
		if(list == null) { 
			return ""; 
		} else {
			for(int i = 0; i < list.size(); i++) {
				result.append("[{\"value\": \"" + list.get(i).getProjectGroup() + "\"},");
				result.append("{\"value\": \"" + list.get(i).getGroupName() + "\"}]");
				if(i != list.size() -1) result.append(",");
			}
		}
		result.append("]}");
		return result.toString();
	}

}
