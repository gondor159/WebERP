<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="employee.EmployeeDAO" %>
<%@ page import="employee.EmployeeDTO" %>
<%
	String userID = null;
	if (session.getAttribute("userID") != null) {
		userID = (String) session.getAttribute("userID");
	}
	EmployeeDTO employee = new EmployeeDTO();
	employee = new EmployeeDAO().getEmployee(userID);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>HOME</title>
</head>
<body>
	<%
		if(userID == null) {
			response.sendRedirect("login.jsp");
		} else {
			if(employee.getCompanyCode() == null || employee.getCompanyCode().equals("")) {
				response.sendRedirect("companyAdmin/register.jsp");
			} else {
				response.sendRedirect("main/mainDashboard.jsp");
			}
		}
	%>
</body>
</html>