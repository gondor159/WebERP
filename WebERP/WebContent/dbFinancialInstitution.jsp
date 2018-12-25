<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="financialInstitution.FinancialInstitutionDAO"%>
<%@ page import="financialInstitution.FinancialInstitutionDTO"%>
<%@ page import="java.util.ArrayList"%>
<!DOCTYPE html>
<html>
<%
	ArrayList<FinancialInstitutionDTO> list = new FinancialInstitutionDAO().getFinancialInstitution();
%>
<head>
<meta charset="UTF-8">
<title>FinancialInstitution DB controller</title>
</head>
<body>
<form method="POST" action="./financialInstitutionInsertServlet">
	<table>
		<tr>
			<td>금융기관코드</td>
			<td><input type="text" name="financialInstitutionCode"></td>
		</tr>
		<tr>
			<td>금융기관이름</td>
			<td><input type="text" name="financialInstitutionName"></td>
		</tr>
	</table>
	<button type="submit">전송</button>
</form>
<form method="POST" action="./financialInstitutionUpdateServlet">
	<table>
		<tr>
			<td>수정할 금융기관코드</td>
			<td><input type="text" name="editFinancialInstitutionCode"></td>
		</tr>
		<tr>
			<td>금융기관코드</td>
			<td><input type="text" name="financialInstitutionCode"></td>
		</tr>
		<tr>
			<td>금융기관이름</td>
			<td><input type="text" name="financialInstitutionName"></td>
		</tr>
	</table>
	<button type="submit">수정</button>
</form>
<form method="POST" action="./financialInstitutionDeleteServlet">
	<table>
		<tr>
			<td>삭제할 금융기관코드</td>
			<td><input type="text" name="financialInstitutionCode"></td>
		</tr>
	</table>
	<button type="submit">삭제</button>
</form>
<table>
	<thead>
		<tr>
			<th>금융기관코드</th>
			<th>금융기관이름</th>
		</tr>
	</thead>
	<tbody>
		<%
			if (list != null) {
				for (int i = 0; i < list.size(); i++) {
					FinancialInstitutionDTO dto = list.get(i);
		%>
		<tr>
			<td><%=dto.getFinancialInstitutionCode()%></td>
			<td><%=dto.getFinancialInstitutionName()%></td>
		</tr>
		<% 			
				}
			}
		%>
	</tbody>
</table>
</body>
</html>