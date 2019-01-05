package customgroup;

import java.io.IOException;
import java.net.URLDecoder;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/CustomGroupGetListServlet")
public class CustomGroupGetListServlet extends HttpServlet {
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
				if(division.equals("divisionCustomGroupName")) {
					response.getWriter().write(getListToName(companyCode, input));
				/* 구분이 분류코드일 경우 */
				} else if (division.equals("divisionCustomGroupCode")) {
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
		CustomGroupDAO customGroupDAO = new CustomGroupDAO();
		ArrayList<CustomGroupDTO> list = customGroupDAO.getCustomGroupListToName(companyCode, groupName);
		if(list == null) { 
			return ""; 
		} else {
			for(int i = 0; i < list.size(); i++) {
				result.append("[{\"value\": \"" + list.get(i).getCustomGroup() + "\"},");
				result.append("{\"value\": \"" + list.get(i).getGroupName() + "\"}]");
				if(i != list.size() -1) result.append(",");
			}
		}
		result.append("]}");
		return result.toString();
	}
	
	/* 구분이 분류코드일 경우 */
	public String getListToCode(String companyCode, String customGroup) {
		StringBuffer result = new StringBuffer("");
		result.append("{\"result\":[");
		CustomGroupDAO customGroupDAO = new CustomGroupDAO();
		ArrayList<CustomGroupDTO> list = customGroupDAO.getCustomGroupListToCode(companyCode, customGroup);
		if(list == null) { 
			return ""; 
		} else {
			for(int i = 0; i < list.size(); i++) {
				result.append("[{\"value\": \"" + list.get(i).getCustomGroup() + "\"},");
				result.append("{\"value\": \"" + list.get(i).getGroupName() + "\"}]");
				if(i != list.size() -1) result.append(",");
			}
		}
		result.append("]}");
		return result.toString();
	}

}
