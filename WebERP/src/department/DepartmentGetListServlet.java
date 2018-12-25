package department;

import java.io.IOException;
import java.net.URLDecoder;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/DepartmentGetListServlet")
public class DepartmentGetListServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		String companyCode = request.getParameter("companyCode");
		String fieldCode = request.getParameter("fieldCode");
		if(companyCode == null || companyCode.equals("") || fieldCode == null || fieldCode.equals("")) {
			response.getWriter().write("");
		} else {
			try {
				response.getWriter().write(getDeptList(URLDecoder.decode(companyCode, "UTF-8"), fieldCode));
			} catch(Exception e) {
				e.printStackTrace();
				response.getWriter().write("");
			}
		}
	}
	
	public String getDeptList(String companyCode, String fieldCode) {
		StringBuffer result = new StringBuffer("");
		result.append("{\"result\":[");
		DepartmentDAO departmentDAO = new DepartmentDAO();
		ArrayList<DepartmentDTO> deptList = departmentDAO.getDepartmentList(companyCode, fieldCode);
		if(deptList.size() == 0) return "";
		for(int i = 0; i < deptList.size(); i++) {
			result.append("[{\"value\": \"" + deptList.get(i).getDepartmentCode() + "\"},");
			result.append("{\"value\": \"" + deptList.get(i).getDepartmentName() + "\"}]");
			if(i != deptList.size() -1) result.append(",");
		}
		result.append("]}");
		return result.toString();
	}
	
}
