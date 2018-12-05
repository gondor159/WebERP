package field;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/FieldRegistServlet")
public class FieldRegistServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		String companyCode = request.getParameter("companyCode");
		String fieldCode = request.getParameter("fieldCode");
		String fieldName = request.getParameter("fieldName");
		if(companyCode == null || companyCode.equals("") || fieldCode == null || fieldCode.equals("") || fieldName == null || fieldName.equals("")) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('��� ������ �Է��ϼ���.')");
			script.println("location.href = 'departmentRegist.jsp'");
			script.println("</script>");
			script.close();
			return;
		}
		int result = new FieldDAO().registField(companyCode, fieldCode, fieldName);
		if(result == 1) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('�ι��� ��� �Ǿ����ϴ�.')");
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
