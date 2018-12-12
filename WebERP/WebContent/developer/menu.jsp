<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%
	String developerPass = null;
	if (session.getAttribute("developerPass") != null) {
		developerPass = (String) session.getAttribute("developerPass");
	}
	if (developerPass == null) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('개발자 인증이 필요합니다.')");
		script.println("location.href = '../developer.jsp'");
		script.println("</script>");
		return;
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Developer Menu</title>
</head>
<body>
<ul>
	<li>
		<a href="dbBusinessType.jsp">BusinessType DB</a>
	</li>
	<li>
		<a href="dbFinancialInstitution.jsp">FinancialInstitution DB</a>
	</li>
	<li>
		<a href="dbRights.jsp">Rights DB</a>
	</li>
</ul>
</body>
</html>