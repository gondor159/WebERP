package customer;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/CustomerGetNameServlet")
public class CustomerGetNameServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		String companyCode = request.getParameter("companyCode");
		String customCode = request.getParameter("customCode");
		if (companyCode == null || companyCode.equals("") || customCode == null
				|| customCode.equals("")) {
			response.getWriter().write("");
		} else {
			try {
				response.getWriter().write(getTypeName(companyCode, customCode));
			} catch (Exception e) {
				e.printStackTrace();
				response.getWriter().write("");
			}
		}
	}

	public String getTypeName(String companyCode, String customCode) {
		StringBuffer result = new StringBuffer("");
		CustomerDAO customerDAO = new CustomerDAO();
		String name = customerDAO.getCustomerName(companyCode, customCode);
		if(name == null || name.equals("")) return "";
		result.append("{\"result\":[{\"value\": \"" + name + "\"}]}");
		return result.toString();
	}

}
