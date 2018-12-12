<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="rights.RightsDAO"%>
<%@ page import="rights.RightsDTO"%>
<%@ page import="java.util.ArrayList"%>
<!DOCTYPE html>
<html>
<%
	ArrayList<RightsDTO> list = new RightsDAO().getRightsList();
%>
<head>
<meta charset="UTF-8">
<title>Rights DB controller</title>
</head>
<body>
<form method="POST" action="./rightsInsertServlet">
	<table>
		<tr>
			<td>권한코드</td>
			<td><input type="text" name="rightsCode"></td>
		</tr>
		<tr>
			<td>권한이름</td>
			<td><input type="text" name="rightsName"></td>
		</tr>
	</table>
	<button type="submit">전송</button>
</form>
<form method="POST" action="./rightsUpdateServlet">
	<table>
		<tr>
			<td>수정할 권한코드</td>
			<td><input type="text" name="editRightsCode"></td>
		</tr>
		<tr>
			<td>권한코드</td>
			<td><input type="text" name="rightsCode"></td>
		</tr>
		<tr>
			<td>권한이름</td>
			<td><input type="text" name="rightsName"></td>
		</tr>
	</table>
	<button type="submit">수정</button>
</form>
<form method="POST" action="./rightsDeleteServlet">
	<table>
		<tr>
			<td>권한코드</td>
			<td><input type="text" name="rightsCode"></td>
		</tr>
	</table>
	<button type="submit">삭제</button>
</form>
<table>
	<thead>
		<tr>
			<th>권한코드</th>
			<th>권한이름</th>
		</tr>
	</thead>
	<tbody>
		<%
			if (list != null) {
				for (int i = 0; i < list.size(); i++) {
					RightsDTO dto = list.get(i);
		%>
		<tr>
			<td><%=dto.getRightsCode()%></td>
			<td><%=dto.getRightsName()%></td>
		</tr>
		<%
				}
			}
		%>
	</tbody>
</table>
</body>
</html>