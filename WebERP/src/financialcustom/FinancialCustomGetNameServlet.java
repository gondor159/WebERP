package financialcustom;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/FinancialCustomGetNameServlet")
public class FinancialCustomGetNameServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		String companyCode = request.getParameter("companyCode");
		String fcCode = request.getParameter("fcCode");
		if(companyCode == null || companyCode.equals("") || fcCode == null || fcCode.equals("")) {
			response.getWriter().write("");
		} else {
			try {
				response.getWriter().write(new FinancialCustomDAO().getFcName(companyCode, fcCode));
			} catch(Exception e) {
				e.printStackTrace();
				response.getWriter().write("");
			}
		}
	}

}
