package field;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/FieldGetListServlet")
public class FieldGetListServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		String companyCode = request.getParameter("companyCode");
		if(companyCode == null || companyCode.equals("")) {
			response.getWriter().write("");
		} else {
			try {
			response.getWriter().write(getFieldList(companyCode));
			} catch(Exception e) {
				e.printStackTrace();
				response.getWriter().write("");
			}
		}
	}
	
	public String getFieldList(String companyCode) {
		StringBuffer result = new StringBuffer("");
		result.append("{\"result\":[");
		FieldDAO fieldDAO = new FieldDAO();
		ArrayList<FieldDTO> fieldList = fieldDAO.getFieldList(companyCode);
		if(fieldList.size() == 0) return "";
		for(int i = 0; i < fieldList.size(); i++) {
			result.append("[{\"value\": \"" + fieldList.get(i).getFieldCode() + "\"},");
			result.append("{\"value\": \"" + fieldList.get(i).getFieldName() + "\"}]");
			if(i != fieldList.size() -1) result.append(",");
		}
		result.append("]}");
		return result.toString();
	}
}
