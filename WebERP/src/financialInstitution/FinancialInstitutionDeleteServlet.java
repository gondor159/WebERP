package financialInstitution;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import financialInstitution.FinancialInstitutionDAO;


@WebServlet("/FinancialInstitutionDeleteServlet")
public class FinancialInstitutionDeleteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
   
	protected void doPost(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {

		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		String financialinstitutionCode = request.getParameter("financialinstitutionCode");

		if (financialinstitutionCode == null || financialinstitutionCode.equals("")) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('모든 값을 입력하세요.')");
			script.println("history.back();");
			script.println("</script>");
			script.close();
			return;
		}
		
		int Result = new FinancialInstitutionDAO().deletefinancialinstitution(financialinstitutionCode);
		
		if (Result == 1) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('삭제 성공.')");
			script.println("location.href='dbFinancialInstitution.jsp'");
			script.println("</script>");
			script.close();
			return;
			
		} else {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('삭제 실패.')");
			script.println("history.back();");
			script.println("</script>");
			script.close();
			return;
		}
	}

}
