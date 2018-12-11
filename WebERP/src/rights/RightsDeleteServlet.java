package rights;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet("/RightsDeleteServlet")
public class RightsDeleteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		String rightsCode = request.getParameter("rightsCode");

		if (rightsCode == null || rightsCode.equals("")) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('��簪�� �Է��ϼ���.')");
			script.println("history.back();");
			script.println("</script>");
			script.close();
			return;
		}

		int Result = new RightsDAO().deleterights(rightsCode);
		
		if (Result == 1) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('���� ����.')");
			script.println("location.href='dbRightsinsert.jsp'");
			script.println("</script>");
			script.close();
			return;

		} else {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('���� ����.')");
			script.println("history.back();");
			script.println("</script>");
			script.close();
			return;
		}
	}
}