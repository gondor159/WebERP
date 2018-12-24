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
			script.println("alert('모든 내용을 입력하세요.')");
			script.println("location.href = 'departmentRegist.jsp'");
			script.println("</script>");
			script.close();
			return;
		}
		int result = new FieldDAO().registField(companyCode, fieldCode, fieldName);
		if(result == 1) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('부문이 등록 되었습니다.')");
			script.println("location.href = 'departmentRegist.jsp'");
			script.println("</script>");
			script.close();
			return;
		} else {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('데이터베이스 오류가 발생하였습니다.')");
			script.println("location.href = 'departmentRegist.jsp'");
			script.println("</script>");
			script.close();
			return;
		}
	}

}
