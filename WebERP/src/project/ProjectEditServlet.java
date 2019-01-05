package project;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/ProjectEditServlet")
public class ProjectEditServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		String companyCode = request.getParameter("companyCode");
		String projectCode = request.getParameter("projectCode");
		String projectName = request.getParameter("projectName");
		String division = request.getParameter("division");
		String projectSince = request.getParameter("projectSince");
		String projectTill = request.getParameter("projectTill");
		String contractCompany= request.getParameter("contractCompany");
		String startDate = request.getParameter("startDate");
		String costDivision = request.getParameter("costDivision");
		String projectType = request.getParameter("projectType");
		String projectSum = request.getParameter("projectSum");
		String projectGroup = request.getParameter("projectGroup");
		String note = request.getParameter("note");
		String employmentManager = request.getParameter("employmentManager");
		String employmentManagerIdentityNum = request.getParameter("employmentManagerIdentityNum");
		String EMposition = request.getParameter("EMposition");
		String EMtask = request.getParameter("EMtask");
		String employment = request.getParameter("employment");
		String editProjectCode = request.getParameter("editProjectCode");
		
		if(companyCode == null || companyCode.equals("") || projectCode == null || projectCode.equals("") || projectName == null || projectName.equals("") 
				|| division == null || division.equals("")) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('필수 값을 입력해주세요.')");
			script.println("history.back();");
			script.println("</script>");
			script.close();
			return;
		}
		if(projectSince == null || projectSince.equals("")) {
			projectSince = "0000-00-00";
		}
		if(projectTill == null || projectTill.equals("")) {
			projectTill = "0000-00-00";
		}
		if(startDate == null || startDate.equals("")) {
			startDate = "0000-00-00";
		}
		
		int result = new ProjectDAO().updateProject(companyCode, projectCode, projectName, division, projectSince, projectTill, contractCompany, startDate, costDivision, projectType, projectSum, projectGroup, note, employmentManager, employmentManagerIdentityNum, EMposition, EMtask, employment, editProjectCode);
		if (result == 1) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('수정에 성공하였습니다.')");
			script.println("location.href = 'projectRegist.jsp'");
			script.println("</script>");
			script.close();
			return;
		} else {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('수정에 실패하였습니다.')");
			script.println("history.back();");
			script.println("</script>");
			script.close();
			return;
		}
	}

}
