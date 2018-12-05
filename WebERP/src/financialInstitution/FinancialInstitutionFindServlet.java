package financialInstitution;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/FinancialInstitutionFindServlet")
public class FinancialInstitutionFindServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		String financialinstitutionName = request.getParameter("financialinstitutionName");
		if(financialinstitutionName == null || financialinstitutionName.equals("")) {
			response.getWriter().write("");
		} else {
			try {
				response.getWriter().write(getFinancialInstitutionToName(financialinstitutionName));
			} catch(Exception e) {
				e.printStackTrace();
				response.getWriter().write("");
			}
		}
	}
	
	public String getFinancialInstitutionToName(String financialinstitutionName) {
		StringBuffer result = new StringBuffer("");
		result.append("{\"result\":[");
		FinancialInstitutionDAO financialInstitutionDAO = new FinancialInstitutionDAO();
		ArrayList<FinancialInstitutionDTO> filist = financialInstitutionDAO.getFinancialInstitutionToName(financialinstitutionName);
		if(filist == null) { 
			return ""; 
		} else {
			for(int i = 0; i < filist.size(); i++) {
				result.append("[{\"value\": \"" + filist.get(i).getFinancialinstitutionCode() + "\"},");
				result.append("{\"value\": \"" + filist.get(i).getFinancialinstitutionName() + "\"}]");
				if(i != filist.size() -1) result.append(",");
			}
		}
		result.append("]}");
		return result.toString();
	}
}
