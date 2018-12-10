<!DOCTYPE html>
<html>
<head>
</head>
<body>
<%
	session.invalidate();
%>
<script>
	location.href = 'login.jsp';
</script>
</body>
</html>