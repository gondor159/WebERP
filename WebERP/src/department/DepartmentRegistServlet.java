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
			script.println("alert('��� ������ �Է��ϼ���.')");
			script.println("location.href = 'departmentRegist.jsp'");
			script.println("</script>");
			script.close();
			return;
		}
		int result = new DepartmentDAO().registDepartment(companyCode, fieldCode, departmentCode, departmentName);
		if (result == 1) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('�μ��� ��� �Ǿ����ϴ�.')");
			script.println("location.href = 'departmentRegist.jsp'");
			script.println("</script>");
			script.close();
			return;
		} else {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('�˼��մϴ�. �ٽ� �õ��� �ּ���.')");
			script.println("location.href = 'departmentRegist.jsp'");
			script.println("</script>");
			script.close();
			return;
		}
	}

}
