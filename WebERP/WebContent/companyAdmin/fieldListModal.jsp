<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="field.FieldDAO"%>
<%@ page import="field.FieldDTO"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.io.PrintWriter"%>
<%
	request.setCharacterEncoding("UTF-8");
	String companyCode = request.getParameter("companyCode");
	
	ArrayList<FieldDTO> fieldList = new FieldDAO().getFieldList(companyCode);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
</head>
<body>
	<div class="modal-header">
		<button type="button" class="close" data-dismiss="modal"
			aria-hidden="true">&times;</button>
		<h4 class="modal-title" id="serchFieldLabel">부문검색</h4>
	</div>
	<div class="modal-body">
		<table class="table table-striped table-bordered table-hover"
			id="fieldList">
			<thead>
				<tr>
					<th>선택</th>
					<th>부문코드</th>
					<th>부문명</th>
				</tr>
			</thead>
			<tbody>
				<% 
					if(fieldList != null) {
						for(int i = 0; i < fieldList.size(); i++) {
							FieldDTO field = fieldList.get(i);
				%>
				<tr>
					<td class="center"><input type="radio" name="selectField"
								value="<%= field.getFieldCode() %>"></td>
					<td class="center"><%= field.getFieldCode() %></td>
					<td class="center"><%= field.getFieldName() %></td>
				</tr>
				<% 
						}
					} else { 
				%>
					<tr>
						<td></td>
						<td></td>
						<td></td>
					</tr>
				<%
					}
				%>
			</tbody>
		</table>
	</div>
	<div class="modal-footer">
		<button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
		<button type="button" class="btn btn-primary" data-dismiss="modal" onclick="insertFieldCode();">확인</button>
	</div>
</body>
</html>