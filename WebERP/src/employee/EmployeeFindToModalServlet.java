package employee;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import department.DepartmentDAO;
import field.FieldDAO;
import user.UserDAO;
import user.UserDTO;

@WebServlet("/EmployeeFindToModalServlet")
public class EmployeeFindToModalServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		String companyCode = request.getParameter("companyCode");
		String division = request.getParameter("division");
		String input = request.getParameter("input");
		if(companyCode == null || companyCode.equals("") || division == null || division.equals("") || input == null || input.equals("")) {
			response.getWriter().write("");
		} else {
			if(division.equals("chargeEmployeeName")) {
				try {
					response.getWriter().write(getEmployeeToName(companyCode, input));
				} catch(Exception e) {
					e.printStackTrace();
					response.getWriter().write("");
				}
			} else if(division.equals("chargeEmployeeCode")) {
				try {
					response.getWriter().write(getEmployeeToCode(companyCode, input));
				} catch(Exception e) {
					e.printStackTrace();
					response.getWriter().write("");
				}
			}
		}
	}
	
	/* 구분이 사원이름일 경우 */
	public String getEmployeeToName(String companyCode, String input) {
		StringBuffer result = new StringBuffer("");
		result.append("{\"result\":[");
		ArrayList<String> useres = new UserDAO().findUserID(input);
		if(useres.size() == 0) return "";
		EmployeeDTO employee = new EmployeeDTO();
		UserDTO user = new UserDTO();
		String fieldName = "";
		String deptName = "";
		for(int i = 0; i < useres.size(); i++) {
			employee = new EmployeeDAO().getEmployee(useres.get(i));
			user = new UserDAO().getUser(useres.get(i));
			fieldName = new FieldDAO().getFieldName(companyCode, employee.getFieldCode());
			deptName = new DepartmentDAO().getDepartmentName(companyCode, employee.getFieldCode(), employee.getDepartmentCode());
			result.append("[{\"value\": \"" + employee.getEmployeeNum() + "\"},");
			result.append("{\"value\": \"" + user.getUserName() + "\"},");
			result.append("{\"value\": \"" + fieldName + "\"},");
			result.append("{\"value\": \"" + deptName + "\"}]");
			if(i != useres.size() -1) result.append(",");
		}
		result.append("]}");
		return result.toString();
	}
	
	/* 구분이 사원코드일 경우 */
	public String getEmployeeToCode(String companyCode, String input) {
		StringBuffer result = new StringBuffer("");
		result.append("{\"result\":[");
		EmployeeDTO employee = new EmployeeDAO().findEmployee(companyCode, input);
		if(employee == null) return "";
		String employeeName = new UserDAO().findUserName(employee.getUserID());
		String fieldName = new FieldDAO().getFieldName(companyCode, employee.getFieldCode());
		String deptName = new DepartmentDAO().getDepartmentName(companyCode, employee.getFieldCode(), employee.getDepartmentCode());
		result.append("[{\"value\": \"" + employee.getEmployeeNum() + "\"},");
		result.append("{\"value\": \"" + employeeName + "\"},");
		result.append("{\"value\": \"" + fieldName + "\"},");
		result.append("{\"value\": \"" + deptName + "\"}]]}");
		return result.toString();
	}
}
