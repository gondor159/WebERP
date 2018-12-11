package businesstype;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/BusinessTypeDeleteServlet")
public class BusinessTypeDeleteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		String businessCondition = request.getParameter("businessCondition");
		String businessType = request.getParameter("businessType");
		if(businessCondition == null || businessCondition.equals("") || businessType == null || businessType.equals("")) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('PK�� null�� �� �� �����ϴ�.')");
			script.println("history.back();");
			script.println("</script>");
			script.close();
			return;
		}
		int result = new BusinessTypeDAO().deleteType(businessCondition, businessType);
		if(result == 1) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('�����Ǿ����ϴ�.')");
			script.println("location.href = 'dbBusinessType.jsp';");
			script.println("</script>");
			script.close();
			return;
		} else {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('������ ���� �߽��ϴ�.')");
			script.println("history.back();");
			script.println("</script>");
			script.close();
			return;
		}
	}

}
