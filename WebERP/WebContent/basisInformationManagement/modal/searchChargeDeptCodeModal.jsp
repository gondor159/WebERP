<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="department.DepartmentDAO" %>
<%@ page import="department.DepartmentDTO" %>
<%@ page import="java.util.ArrayList" %>
<%
	request.setCharacterEncoding("UTF-8");
	String companyCode = request.getParameter("companyCode");
	ArrayList<DepartmentDTO> departmentList = new DepartmentDAO().getDepartmentListToCompanyCode(companyCode);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script>
	function searchChargeDeptCode() {
		var companyCode = $('#paramCompanyCodeToSCDCM').val();
		var input = $('#chargeDeptCodeSearchInput').val();
		$.ajax({
			type : 'POST',
			url : './departmentGetListToAllServlet',
			data : {
				companyCode : companyCode,
				departmentName : input
			},
			success : function(data) {
				if(data == "") {
					$('#tableChargeDeptCodeResult').empty();
					$('#tableChargeDeptCodeResult').append('');
				} else {
					var parsed = JSON.parse(data);
					var result = parsed.result;
					$('#tableChargeDeptCodeResult').empty();
					for (var i = 0; i < result.length; i++) {
						tableChargeDeptCodeResultFunction(result[i][0].value, result[i][1].value);
					}
				}
			}
		});
	}
	function tableChargeDeptCodeResultFunction(departmentCode, departmentName) {
		$('#tableChargeDeptCodeResult').append('<tr><td><input type="radio" name="deptCode" value="' + departmentCode + '"></td>' +
				'<td>' + departmentCode + '</td>' + '<td>' + departmentName + '</td></tr>');
	}
</script>
</head>
<body>
	<input type="hidden" id="paramCompanyCodeToSCDCM" value="<%= companyCode %>">
	<div class="modal-header">
		<button type="button" class="close" data-dismiss="modal"
			aria-hidden="true">&times;</button>
		<h4 class="modal-title" id="searchChargeDeptCodeLabel">부서
			검색</h4>
	</div>
	<div class="modal-body">
		<div class="panel panel-default">
			<div class="row" style="margin-top: 10px; margin-bottom: 10px;">
				<div class="col-md-3">
					<h5 style="text-align: center;">부서명으로 검색</h5>
				</div>
				<div class="col-md-6">
					<input id="chargeDeptCodeSearchInput" type="text"
						style="width: 100%; height: 34px;">
				</div>
				<div class="col-md-2">
					<button class="btn btn-default" type="button"
						onclick="searchChargeDeptCode();">
						<i class="fa fa-search-plus "></i>
					</button>
				</div>
				<div class="col-md-1"></div>
			</div>
			<div>
				<table class="table table-striped table-bordered table-hover">
					<thead>
						<tr>
							<td><i class="fa fa-check-square-o"></i></td>
							<td>부서코드</td>
							<td>부서명</td>
						</tr>
					</thead>
					<tbody id="tableChargeDeptCodeResult">
						<%
							if (departmentList != null) {
								for (int i = 0; i < departmentList.size(); i++) {
									DepartmentDTO dto = departmentList.get(i);
						%>
						<tr>
							<td><input type="radio" name="deptCode"
								value="<%= dto.getDepartmentCode() %>"></td>
							<td><%= dto.getDepartmentCode() %></td>
							<td><%= dto.getDepartmentName() %></td>
						</tr>
						<%
							}
							}
						%>
					</tbody>
				</table>
			</div>
		</div>
	</div>
	<div class="modal-footer">
		<button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
		<button type="button" class="btn btn-primary"
			onclick="insertCDCFunction();" data-dismiss="modal">확인</button>
	</div>
</body>
</html>