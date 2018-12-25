package department;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/DepartmentRegistServlet")
public class DepartmentRegistServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		String companyCode = request.getParameter("companyCode");
		String fieldCode = request.getParameter("fieldCode");
		String departmentCode = request.getParameter("departmentCode");
		String departmentName = request.getParameter("departmentName");
		if (companyCode == null || companyCode.equals("") || fieldCode == null || fieldCode.equals("")
				|| departmentCode == null || departmentCode.equals("") || departmentName == null
				|| departmentName.equals("")) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('모든 내용을 입력하세요.')");
			script.println("location.href = 'departmentRegist.jsp'");
			script.println("</script>");
			script.close();
			return;
		}
		int result = new DepartmentDAO().registDepartment(companyCode, fieldCode, departmentCode, departmentName);
		if (result == 1) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('부서가 등록 되었습니다.')");
			script.println("location.href = 'departmentRegist.jsp'");
			script.println("</script>");
			script.close();
			return;
		} else {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('데이터베이스 오류가 발생했습니다.')");
			script.println("location.href = 'departmentRegist.jsp'");
			script.println("</script>");
			script.close();
			return;
		}
	}

}
