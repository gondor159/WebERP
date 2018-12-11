<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="businesstype.BusinessTypeDAO" %>
<%@ page import="businesstype.BusinessTypeDTO" %>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html>
<%
	ArrayList<BusinessTypeDTO> list = new BusinessTypeDAO().getBusinessType();
%>
<head>
<meta charset="UTF-8">
<title>BUSINESSTYPE DB controller</title>
</head>
<body>
<form method="POST" action="./businessTypeInsertServlet">
	<table>
		<tr>
			<td>업태코드</td>
			<td><input type="text" name="businessCondition"></td>
		</tr>
		<tr>
			<td>종목코드</td>
			<td><input type="text" name="businessType"></td>
		</tr>
		<tr>
			<td>업태이름</td>
			<td><input type="text" name="businessConditionName"></td>
		</tr>
		<tr>
			<td>종목이름</td>
			<td><input type="text" name="businessTypeName"></td>
		</tr>
	</table>
	<button type="submit">전송</button>
</form>
<form method="POST" action="./businessTypeUpdateServlet">
	<table>
		<tr>
			<td>수정할 업태코드</td>
			<td><input type="text" name="editBusinessCondition"></td>
		</tr>
		<tr>
			<td>수정할 종목코드</td>
			<td><input type="text" name="editBusinessType"></td>
		</tr>
	</table>
	<table>
		<tr>
			<td>업태코드</td>
			<td><input type="text" name="businessCondition"></td>
		</tr>
		<tr>
			<td>종목코드</td>
			<td><input type="text" name="businessType"></td>
		</tr>
		<tr>
			<td>업태이름</td>
			<td><input type="text" name="businessConditionName"></td>
		</tr>
		<tr>
			<td>종목이름</td>
			<td><input type="text" name="businessTypeName"></td>
		</tr>
	</table>
	<button type="submit">수정</button>
</form>
<form method="POST" action="./businessTypeDeleteServlet">
	<table>
		<tr>
			<td>삭제할 업태코드</td>
			<td><input type="text" name="businessCondition"></td>
		</tr>
		<tr>
			<td>삭제할 종목코드</td>
			<td><input type="text" name="businessType"></td>
		</tr>
	</table>
	<button type="submit">삭제</button>
</form>
<table>
	<thead>
		<tr>
			<th>업태코드</th>
			<th>종목코드</th>
			<th>업태이름</th>
			<th>종목이름</th>
		</tr>
	</thead>
	<tbody>
		<% 
			if(list != null) {
				for(int i = 0; i < list.size(); i++) {
					BusinessTypeDTO dto = list.get(i);
		%>
		<tr>
			<td><%= dto.getBusinessCondition() %></td>
			<td><%= dto.getBusinessType() %></td>
			<td><%= dto.getBusinessConditionName() %></td>
			<td><%= dto.getBusinessTypeName() %></td>
		</tr>
		<%
				}
			}
		%>
	</tbody>
</table>
</body>
</html>