package company;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import businesstype.BusinessTypeDAO;
import businesstype.BusinessTypeDTO;
import user.UserDAO;

@WebServlet("/CompanyFindForCustomServlet")
public class CompanyFindForCustomServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		String division = request.getParameter("division");
		String input = request.getParameter("input");
		if(division == null || division.equals("") || input == null || input.equals("")) {
			response.getWriter().write("");
		} else {
			if(division.equals("companyName")) {
				try {
					response.getWriter().write(getCompanyToCompanyName(input));
				} catch(Exception e) {
					e.printStackTrace();
					response.getWriter().write("");
				}
			} else if(division.equals("companyCode")) {
				try {
					response.getWriter().write(getCompanyToCompanyCode(input));
				} catch(Exception e) {
					e.printStackTrace();
					response.getWriter().write("");
				}
			} else if(division.equals("businessLicenseNum")) {
				try {
					response.getWriter().write(getCompanyToBusinessLicenseNum(input));
				} catch(Exception e) {
					e.printStackTrace();
					response.getWriter().write("");
				}
			}
		}
	}
	
	/* 구분이 회사명일 경우 */
	public String getCompanyToCompanyName(String input) {
		StringBuffer result = new StringBuffer("");
		result.append("{\"result\":[");
		ArrayList<CompanyDTO> list = new CompanyDAO().getCompanyListToCompanyName(input);
		UserDAO userDAO = new UserDAO();
		BusinessTypeDAO businessDAO = new BusinessTypeDAO();
		BusinessTypeDTO type = new BusinessTypeDTO();
		String chief;
		if(list.size() == 0) return "";
		for(int i = 0; i < list.size(); i++) {
			chief = userDAO.findUserName(list.get(i).getChiefID());
			type = businessDAO.getBusinessType(list.get(i).getBusinessCondition(), list.get(i).getBusinessType());
			result.append("[{\"value\": \"" + list.get(i).getCompanyName() + "\"},");
			result.append("{\"value\": \"" + list.get(i).getCompanyCode() + "\"},");
			result.append("{\"value\": \"" + chief + "\"},");
			result.append("{\"value\": \"" + type.getBusinessConditionName() + "\"},");
			result.append("{\"value\": \"" + type.getBusinessTypeName() + "\"}]");
			if(i != list.size() -1) result.append(",");
		}
		result.append("]}");
		return result.toString();
	}
	
	/* 구분이 회사코드일 경우 */
	public String getCompanyToCompanyCode(String input) {
		StringBuffer result = new StringBuffer("");
		result.append("{\"result\":[");
		CompanyDTO company = new CompanyDAO().getCompany(input);
		UserDAO userDAO = new UserDAO();
		BusinessTypeDAO businessDAO = new BusinessTypeDAO();
		BusinessTypeDTO type = new BusinessTypeDTO();
		String chief;
		if(company == null) return "";
		chief = userDAO.findUserName(company.getChiefID());
		type = businessDAO.getBusinessType(company.getBusinessCondition(), company.getBusinessType());
		result.append("[{\"value\": \"" + company.getCompanyName() + "\"},");
		result.append("{\"value\": \"" + company.getCompanyCode() + "\"},");
		result.append("{\"value\": \"" + chief + "\"},");
		result.append("{\"value\": \"" + type.getBusinessConditionName() + "\"},");
		result.append("{\"value\": \"" + type.getBusinessTypeName() + "\"}]");
		result.append("]}");
		return result.toString();
	}
	
	/* 구분이 사업자등록번호일 경우 */
	public String getCompanyToBusinessLicenseNum(String input) {
		StringBuffer result = new StringBuffer("");
		result.append("{\"result\":[");
		CompanyDTO company = new CompanyDAO().getCompanyToLicense(input);
		UserDAO userDAO = new UserDAO();
		BusinessTypeDAO businessDAO = new BusinessTypeDAO();
		BusinessTypeDTO type = new BusinessTypeDTO();
		String chief;
		if(company == null) return "";
		chief = userDAO.findUserName(company.getChiefID());
		type = businessDAO.getBusinessType(company.getBusinessCondition(), company.getBusinessType());
		result.append("[{\"value\": \"" + company.getCompanyName() + "\"},");
		result.append("{\"value\": \"" + company.getCompanyCode() + "\"},");
		result.append("{\"value\": \"" + chief + "\"},");
		result.append("{\"value\": \"" + type.getBusinessConditionName() + "\"},");
		result.append("{\"value\": \"" + type.getBusinessTypeName() + "\"}]");
		result.append("]}");
		return result.toString();
	}
}
