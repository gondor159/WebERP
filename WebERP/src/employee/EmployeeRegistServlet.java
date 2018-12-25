package employee;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/EmployeeRegistServlet")
public class EmployeeRegistServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		String companyCode = request.getParameter("companyCode");
		String employeeNum = request.getParameter("employeeNum");
		String placeCode = request.getParameter("placeCode");
		String userID = request.getParameter("userID");
		String fieldCode = request.getParameter("fieldCode");
		String departmentCode = request.getParameter("departmentCode");
		String positionCode = request.getParameter("positionCode");
		String allowance = request.getParameter("allowance");
		String allowanceType = request.getParameter("allowanceType");
		String joinDate = request.getParameter("joinDate");
		if (employeeNum == null || employeeNum.equals("") || userID == null || userID.equals("")
				|| departmentCode == null || departmentCode.equals("") || joinDate == null || joinDate.equals("")) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('모든 내용을 입력하세요.')");
			script.println("location.href = 'employeeRegist.jsp'");
			script.println("</script>");
			script.close();
			return;
		}
		int result = new EmployeeDAO().registEmployee(companyCode, employeeNum, placeCode, userID, fieldCode, departmentCode, positionCode, allowance, allowanceType, joinDate);
		if (result == 1) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('사원번호 : " + employeeNum + "를 등록했습니다.')");
			script.println("location.href = 'employeeRegist.jsp'");
			script.println("</script>");
			script.close();
			return;
		} else {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('데이터베이스 오류가 발생하였습니다.')");
			script.println("location.href = 'employeeRegist.jsp'");
			script.println("</script>");
			script.close();
			return;
		}
	}

}
