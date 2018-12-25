package rights;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/RightsInsertServlet")
public class RightsInsertServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		String rightsCode = request.getParameter("rightsCode");
		String rightsName = request.getParameter("rightsName");

		if (rightsCode == null || rightsCode.equals("")) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('PK는 null이 올 수 없습니다.')");
			script.println("history.back();");
			script.println("</script>");
			script.close();
			return;
		}

		int Result = new RightsDAO().insertrights(rightsCode, rightsName);

		if (Result == 1) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('입력 성공.')");
			script.println("location.href='dbRights.jsp'");
			script.println("</script>");
			script.close();
			return;

		} else {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('입력 실패.')");
			script.println("history.back();");
			script.println("</script>");
			script.close();
			return;
		}
	}
}
