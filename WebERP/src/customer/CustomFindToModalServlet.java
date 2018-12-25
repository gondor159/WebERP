package customer;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import businesstype.BusinessTypeDAO;
import businesstype.BusinessTypeDTO;

@WebServlet("/CustomFindToModalServlet")
public class CustomFindToModalServlet extends HttpServlet {
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
			if(division.equals("searchCustomName")) {
				try {
					response.getWriter().write(getCusomtToCustomName(companyCode, input));
				} catch(Exception e) {
					e.printStackTrace();
					response.getWriter().write("");
				}
			} else if(division.equals("searchCustomCode")) {
				try {
					response.getWriter().write(getCusomtToCustomCode(companyCode, input));
				} catch(Exception e) {
					e.printStackTrace();
					response.getWriter().write("");
				}
			} else if(division.equals("searchCustomBusinessLicenseNum")) {
				try {
					response.getWriter().write(getCustomToBusinessLicenseNum(companyCode, input));
				} catch(Exception e) {
					e.printStackTrace();
					response.getWriter().write("");
				}
			}
		}
	}
	
	/* 구분이 거래처명일 경우 */
	public String getCusomtToCustomName(String companyCode, String input) {
		StringBuffer result = new StringBuffer("");
		result.append("{\"result\":[");
		ArrayList<CustomerDTO> list = new CustomerDAO().getCustomerListToName(companyCode, input);
		BusinessTypeDAO businessDAO = new BusinessTypeDAO();
		BusinessTypeDTO type = new BusinessTypeDTO();
		if(list.size() == 0) return "";
		for(int i = 0; i < list.size(); i++) {
			type = businessDAO.getBusinessType(list.get(i).getBusinessCondition(), list.get(i).getBusinessType());
			result.append("[{\"value\": \"" + list.get(i).getCustomerName() + "\"},");
			result.append("{\"value\": \"" + list.get(i).getCustomCode() + "\"},");
			result.append("{\"value\": \"" + list.get(i).getChiefName() + "\"},");
			result.append("{\"value\": \"" + type.getBusinessConditionName() + "\"},");
			result.append("{\"value\": \"" + type.getBusinessTypeName() + "\"}]");
			if(i != list.size() -1) result.append(",");
		}
		result.append("]}");
		return result.toString();
	}
	
	/* 구분이 거래처코드일 경우 */
	public String getCusomtToCustomCode(String companyCode, String input) {
		StringBuffer result = new StringBuffer("");
		result.append("{\"result\":[");
		CustomerDTO list = new CustomerDAO().getCustomerListToCustomCode(companyCode, input);
		BusinessTypeDAO businessDAO = new BusinessTypeDAO();
		BusinessTypeDTO type = new BusinessTypeDTO();
		if(list == null) return "";
		type = businessDAO.getBusinessType(list.getBusinessCondition(), list.getBusinessType());
		result.append("[{\"value\": \"" + list.getCustomerName() + "\"},");
		result.append("{\"value\": \"" + list.getCustomCode() + "\"},");
		result.append("{\"value\": \"" + list.getChiefName() + "\"},");
		result.append("{\"value\": \"" + type.getBusinessConditionName() + "\"},");
		result.append("{\"value\": \"" + type.getBusinessTypeName() + "\"}]");
		result.append("]}");
		return result.toString();
	}
	
	/* 구분이 사업자등록번호일 경우 */
	public String getCustomToBusinessLicenseNum(String companyCode, String input) {
		StringBuffer result = new StringBuffer("");
		result.append("{\"result\":[");
		ArrayList<CustomerDTO> list = new CustomerDAO().getCustomerListToBusinessLicenseNum(companyCode, input);
		BusinessTypeDAO businessDAO = new BusinessTypeDAO();
		BusinessTypeDTO type = new BusinessTypeDTO();
		if(list.size() == 0) return "";
		for(int i = 0; i < list.size(); i++) {
			type = businessDAO.getBusinessType(list.get(i).getBusinessCondition(), list.get(i).getBusinessType());
			result.append("[{\"value\": \"" + list.get(i).getCustomerName() + "\"},");
			result.append("{\"value\": \"" + list.get(i).getCustomCode() + "\"},");
			result.append("{\"value\": \"" + list.get(i).getChiefName() + "\"},");
			result.append("{\"value\": \"" + type.getBusinessConditionName() + "\"},");
			result.append("{\"value\": \"" + type.getBusinessTypeName() + "\"}]");
			if(i != list.size() -1) result.append(",");
		}
		result.append("]}");
		return result.toString();
	}
}
