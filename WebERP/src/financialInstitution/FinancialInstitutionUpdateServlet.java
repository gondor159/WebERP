package financialInstitution;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/FinancialInstitutionUpdateServlet")
public class FinancialInstitutionUpdateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		String financialInstitutionCode = request.getParameter("financialInstitutionCode");
		String financialInstitutionName = request.getParameter("financialInstitutionName");
		String editFinancialInstitutionCode = request.getParameter("editFinancialInstitutionCode");

		if (financialInstitutionCode == null || financialInstitutionCode.equals("") || financialInstitutionName == null || financialInstitutionName.equals("") || editFinancialInstitutionCode == null || editFinancialInstitutionCode.equals("")) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('모든 값을 입력하세요.')");
			script.println("history.back();");
			script.println("</script>");
			script.close();
			return;
		}

		int Result = new FinancialInstitutionDAO().updateFinancialInstitution(editFinancialInstitutionCode, financialInstitutionCode, financialInstitutionName);
		
		if (Result == 1) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('수정 성공.')");
			script.println("location.href='dbFinancialInstitution.jsp'");
			script.println("</script>");
			script.close();
			return;

		} else {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('수정 실패.')");
			script.println("history.back();");
			script.println("</script>");
			script.close();
			return;
		}
	}

}
