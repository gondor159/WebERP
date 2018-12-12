package businesstype;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/BusinessTypeUpdateServlet")
public class BusinessTypeUpdateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		String editBusinessCondition = request.getParameter("editBusinessCondition");
		String editBusinessType = request.getParameter("editBusinessType");
		String businessCondition = request.getParameter("businessCondition");
		String businessType = request.getParameter("businessType");
		String businessConditionName = request.getParameter("businessConditionName");
		String businessTypeName = request.getParameter("businessTypeName");
		if(editBusinessCondition == null || editBusinessCondition.equals("") || editBusinessType == null || editBusinessType.equals("") ||
				businessCondition == null || businessCondition.equals("") || businessType == null || businessType.equals("") ||
						businessConditionName == null || businessConditionName.equals("") || businessTypeName == null || businessTypeName.equals("")) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('모든 값을 입력하세요.')");
			script.println("history.back();");
			script.println("</script>");
			script.close();
			return;
		}
		int result = new BusinessTypeDAO().updateType(editBusinessCondition, editBusinessType, businessCondition, businessType, businessConditionName, businessTypeName);
		if(result == 1) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('수정되었습니다.')");
			script.println("location.href = 'dbBusinessType.jsp';");
			script.println("</script>");
			script.close();
			return;
		} else {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('수정에 실패 했습니다.')");
			script.println("history.back();");
			script.println("</script>");
			script.close();
			return;
		}
	}

}
