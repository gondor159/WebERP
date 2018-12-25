package company;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import businesstype.BusinessTypeDAO;
import businesstype.BusinessTypeDTO;
import user.UserDAO;

@WebServlet("/FindCompanyToCompanyCodeServlet")
public class FindCompanyToCompanyCodeServlet extends HttpServlet {
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
				response.getWriter().write(companyToCompanyCode(companyCode));
			} catch(Exception e) {
				e.printStackTrace();
				response.getWriter().write("");
			}
		}
	}
	
	public String companyToCompanyCode(String companyCode) {
		StringBuffer result = new StringBuffer("");
		result.append("{\"result\":[");
		CompanyDTO company = new CompanyDAO().getCompany(companyCode);
		UserDAO userDAO = new UserDAO();
		BusinessTypeDAO businessDAO = new BusinessTypeDAO();
		BusinessTypeDTO type = new BusinessTypeDTO();
		String chief;
		if(company == null) return "";
		chief = userDAO.findUserName(company.getChiefID());
		type = businessDAO.getBusinessType(company.getBusinessCondition(), company.getBusinessType());
		result.append("{\"value\": \"" + company.getCompanyName() + "\"},");
		result.append("{\"value\": \"" + company.getBusinessLicenseNum() + "\"},");
		result.append("{\"value\": \"" + chief + "\"},");
		result.append("{\"value\": \"" + company.getPostNum() + "\"},");
		result.append("{\"value\": \"" + company.getAddress() + "\"},");
		result.append("{\"value\": \"" + company.getTel() + "\"},");
		result.append("{\"value\": \"" + company.getFax() + "\"},");
		result.append("{\"value\": \"" + company.getBusinessCondition() + "\"},");
		result.append("{\"value\": \"" + type.getBusinessConditionName() + "\"},");
		result.append("{\"value\": \"" + company.getBusinessType() + "\"},");
		result.append("{\"value\": \"" + type.getBusinessTypeName() + "\"},");
		result.append("{\"value\": \"" + company.getHomepage() + "\"}");
		result.append("]}");
		return result.toString();
	}
}
