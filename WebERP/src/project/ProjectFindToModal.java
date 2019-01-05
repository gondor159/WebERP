package project;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/ProjectFindToModal")
public class ProjectFindToModal extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		String companyCode = request.getParameter("companyCode");
		String division = request.getParameter("division");
		String input = request.getParameter("input");
		if(companyCode == null || companyCode.equals("") || division == null || division.equals("") || input == null || input.equals("")) {
			response.getWriter().write("");
		} else {
			if(division.equals("divisionProjectName")) {
				try {
					response.getWriter().write(getProjectToProjectName(companyCode, input));
				} catch(Exception e) {
					e.printStackTrace();
					response.getWriter().write("");
				}
			} else if(division.equals("divisionProjectCode")) {
				try {
					response.getWriter().write(getProjectToProjectCode(companyCode, input));
				} catch(Exception e) {
					e.printStackTrace();
					response.getWriter().write("");
				}
			}
		}
	}
	
	/* 구분이 프로젝트명일 경우 */
	public String getProjectToProjectName(String companyCode, String input) {
		StringBuffer result = new StringBuffer("");
		result.append("{\"result\":[");
		ArrayList<ProjectDTO> list = new ProjectDAO().getProjectListToName(companyCode, input);
		if(list.size() == 0) return "";
		for(int i = 0; i < list.size(); i++) {
			result.append("[{\"value\": \"" + list.get(i).getProjectCode() + "\"},");
			result.append("{\"value\": \"" + list.get(i).getProjectName() + "\"}]");
			if(i != list.size() -1) result.append(",");
		}
		result.append("]}");
		return result.toString();
	}
	
	/* 구분이 프로젝트코드일 경우 */
	public String getProjectToProjectCode(String companyCode, String input) {
		StringBuffer result = new StringBuffer("");
		result.append("{\"result\":[");
		ArrayList<ProjectDTO> list = new ProjectDAO().getProjectListToCode(companyCode, input);
		if(list.size() == 0) return "";
		for(int i = 0; i < list.size(); i++) {
			result.append("[{\"value\": \"" + list.get(i).getProjectCode() + "\"},");
			result.append("{\"value\": \"" + list.get(i).getProjectName() + "\"}]");
			if(i != list.size() -1) result.append(",");
		}
		result.append("]}");
		return result.toString();
	}

}
