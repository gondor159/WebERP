package financialcustom;

import java.io.IOException;
import java.net.URLDecoder;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/FinancialCustomGetListServlet")
public class FinancialCustomGetListServlet extends HttpServlet {
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
				/* 구분이 거래처명일 경우 */
				if(division.equals("divisionFinancialCustomName")) {
					response.getWriter().write(getListToName(companyCode, input));
				/* 구분이 거래처코드일 경우 */
				} else if (division.equals("divisionFinancialCustomCode")) {
					response.getWriter().write(getListToCode(companyCode, URLDecoder.decode(input, "UTF-8")));
				/* 구분이 거래처분류일 경우 */
				}  else if (division.equals("divisionFinancialCustomDivision")) {
					if(input.equals("금융기관") || input.equals("은행")) {
						input = "fi";
					} else if(input.equals("정기예금") || input.equals("예금")) {
						input = "td";
					} else if(input.equals("정기적금") || input.equals("적금")) {
						input = "isd";
					} else if(input.equals("카드사") || input.equals("카드회사")) {
						input = "ccc";
					} else if(input.equals("신용카드") || input.equals("카드")) {
						input = "cd";
					}
					response.getWriter().write(getListToDivision(companyCode, input));
				} 
			} catch(Exception e) {
				response.getWriter().write("");
			}
		}
	}
	/* 구분이 거래처명일 경우 */
	public String getListToName(String companyCode, String fcName) {
		StringBuffer result = new StringBuffer("");
		String divisions = "";
		result.append("{\"result\":[");
		FinancialCustomDAO financialCustomDAO = new FinancialCustomDAO();
		ArrayList<FinancialCustomDTO> list = financialCustomDAO.getFinancialCustomListToName(companyCode, fcName);
		if(list == null) { 
			return ""; 
		} else {
			for(int i = 0; i < list.size(); i++) {
				if(list.get(i).getDivision().equals("fi")) { divisions = "금융기관"; }
				else if(list.get(i).getDivision().equals("td")) { divisions = "정기예금"; }
				else if(list.get(i).getDivision().equals("isd")) { divisions = "정기적금"; }
				else if(list.get(i).getDivision().equals("ccc")) { divisions = "카드사"; }
				else if(list.get(i).getDivision().equals("cd")) { divisions = "신용카드"; }
				result.append("[{\"value\": \"" + list.get(i).getFcCode() + "\"},");
				result.append("{\"value\": \"" + list.get(i).getFcName() + "\"},");
				result.append("{\"value\": \"" + divisions + "\"}]");
				if(i != list.size() -1) result.append(",");
			}
		}
		result.append("]}");
		return result.toString();
	}
	/* 구분이 거래처코드일 경우 */
	public String getListToCode(String companyCode, String fcCode) {
		StringBuffer result = new StringBuffer("");
		String divisions = "";
		result.append("{\"result\":[");
		FinancialCustomDAO financialCustomDAO = new FinancialCustomDAO();
		ArrayList<FinancialCustomDTO> list = financialCustomDAO.getFinancialCustomListToCode(companyCode, fcCode);
		if(list == null) { 
			return ""; 
		} else {
			for(int i = 0; i < list.size(); i++) {
				if(list.get(i).getDivision().equals("fi")) { divisions = "금융기관"; }
				else if(list.get(i).getDivision().equals("td")) { divisions = "정기예금"; }
				else if(list.get(i).getDivision().equals("isd")) { divisions = "정기적금"; }
				else if(list.get(i).getDivision().equals("ccc")) { divisions = "카드사"; }
				else if(list.get(i).getDivision().equals("cd")) { divisions = "신용카드"; }
				result.append("[{\"value\": \"" + list.get(i).getFcCode() + "\"},");
				result.append("{\"value\": \"" + list.get(i).getFcName() + "\"},");
				result.append("{\"value\": \"" + divisions + "\"}]");
				if(i != list.size() -1) result.append(",");
			}
		}
		result.append("]}");
		return result.toString();
	}
	/* 구분이 거래처분류일 경우 */
	public String getListToDivision(String companyCode, String division) {
		StringBuffer result = new StringBuffer("");
		String divisions = "";
		result.append("{\"result\":[");
		FinancialCustomDAO financialCustomDAO = new FinancialCustomDAO();
		ArrayList<FinancialCustomDTO> list = financialCustomDAO.getFinancialCustomListToDivision(companyCode, division);
		if(list == null) { 
			return ""; 
		} else {
			for(int i = 0; i < list.size(); i++) {
				if(list.get(i).getDivision().equals("fi")) { divisions = "금융기관"; }
				else if(list.get(i).getDivision().equals("td")) { divisions = "정기예금"; }
				else if(list.get(i).getDivision().equals("isd")) { divisions = "정기적금"; }
				else if(list.get(i).getDivision().equals("ccc")) { divisions = "카드사"; }
				else if(list.get(i).getDivision().equals("cd")) { divisions = "신용카드"; }
				result.append("[{\"value\": \"" + list.get(i).getFcCode() + "\"},");
				result.append("{\"value\": \"" + list.get(i).getFcName() + "\"},");
				result.append("{\"value\": \"" + divisions + "\"}]");
				if(i != list.size() -1) result.append(",");
			}
		}
		result.append("]}");
		return result.toString();
	}
}
