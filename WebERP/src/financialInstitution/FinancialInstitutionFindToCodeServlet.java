package financialInstitution;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/FinancialInstitutionFindToCodeServlet")
public class FinancialInstitutionFindToCodeServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		String financialInstitutionCode = request.getParameter("financialInstitutionCode");
		if(financialInstitutionCode == null || financialInstitutionCode.equals("")) {
			response.getWriter().write("");
		} else {
			try {
				response.getWriter().write(getFinancialInstitutionToCode(financialInstitutionCode));
			} catch(Exception e) {
				e.printStackTrace();
				response.getWriter().write("");
			}
		}
	}

	public String getFinancialInstitutionToCode(String financialInstitutionCode) {
		StringBuffer result = new StringBuffer("");
		FinancialInstitutionDAO financialInstitutionDAO = new FinancialInstitutionDAO();
		FinancialInstitutionDTO dto = financialInstitutionDAO.getFinancialInstitutionToCode(financialInstitutionCode);
		if(dto == null) return "";
		result.append("{\"result\":[{\"value\": \"" + dto.getFinancialinstitutionName() + "\"}]}");
		return result.toString();
	}
}
