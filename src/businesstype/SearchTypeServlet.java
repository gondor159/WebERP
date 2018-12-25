package businesstype;

import java.io.IOException;
import java.net.URLDecoder;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/SearchTypeServlet")
public class SearchTypeServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		String businessCondition = request.getParameter("businessCondition");
		if(businessCondition == null || businessCondition.equals("")) {
			response.getWriter().write("");
		} else {
			try {
				response.getWriter().write(getType(URLDecoder.decode(businessCondition, "UTF-8")));
			} catch(Exception e) {
				e.printStackTrace();
				response.getWriter().write("");
			}
		}
	}
	public String getType(String businessCondition) {
		StringBuffer result = new StringBuffer("");
		result.append("{\"result\":[");
		BusinessTypeDAO businessTypeDAO = new BusinessTypeDAO();
		ArrayList<String[]> typeList = businessTypeDAO.searchType(businessCondition);
		if(typeList.size() == 0) return "";
		for(int i = 0; i < typeList.size(); i++) {
			result.append("[{\"value\": \"" + typeList.get(i)[0] + "\"},");
			result.append("{\"value\": \"" + typeList.get(i)[1] + "\"}]");
			if(i != typeList.size() -1) result.append(",");
		}
		result.append("]}");
		return result.toString();
	}
}
