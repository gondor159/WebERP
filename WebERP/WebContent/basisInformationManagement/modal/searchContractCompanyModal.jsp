<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="customer.CustomerDAO" %>
<%@ page import="customer.CustomerDTO" %>
<%@ page import="businesstype.BusinessTypeDAO" %>
<%@ page import="businesstype.BusinessTypeDTO" %>
<%@ page import="java.util.ArrayList" %>
<%
	request.setCharacterEncoding("UTF-8");
	String companyCode = request.getParameter("companyCode");
	
	ArrayList<CustomerDTO> list = new CustomerDAO().getCustomerListToCompanyCode(companyCode);
	BusinessTypeDAO btDAO = new BusinessTypeDAO();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script>
	function searchContractCustom() {
		var companyCode = $('#paramCompanyCodeToCCM').val();
		var select = document.getElementById("customSearchDivision");
		var division = select.options[select.selectedIndex].value;
		var input = $('#searchContractInput').val();
		$.ajax({
			type : 'POST',
			url : './customFindToModalServlet',
			data : {
				companyCode : companyCode,
				division : division,
				input : input
			},
			success : function(data) {
				if(data == "") {
					$('#tableCustomResult').empty();
					$('#tableCustomResult').append('');
				} else {
					var parsed = JSON.parse(data);
					var result = parsed.result;
					$('#tableCustomResult').empty();
					for(var i = 0; i < result.length; i++) {
						tBodyCompanyResult(result[i][0].value, result[i][1].value, result[i][2].value, result[i][3].value, result[i][4].value);
					}
				}
			}
		});
	}
	function tBodyCompanyResult(customName, customCode, chief, condition, type) {
		$('#tableCustomResult').append('<tr><td><input type="radio" name="selectCustomToSearch" value="' + customCode + '"></td>' +
				'<td>' + customName + '</td>' +
				'<td>' + customCode + '</td>' +
				'<td>' + chief + '</td>' +
				'<td>' + condition + '</td>' +
				'<td>' + type + '</td></tr>');
	}
</script>
</head>
<body>
	<input type="hidden" id="paramCompanyCodeToCCM" value="<%= companyCode %>">
	<div class="modal-header">
		<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
		<h4 class="modal-title" id="searchCollectCustomLabel">수금거래처 검색</h4>
	</div>
	<div class="modal-body">
		<div class="panel panel-default">
			<div class="row" style="margin-top: 10px; margin-bottom: 10px;">
				<div class="col-md-1"></div>
				<div class="col-md-3">
					<select class="form-control" id="customSearchDivision">
						<option value="searchCustomName">거래처명</option>
						<option value="searchCustomCode">거래처코드</option>
					</select>
				</div>
				<div class="col-md-5">
					<input class="form-control" id="searchContractInput" type="text">
				</div>
				<div class="col-md-3">
					<button class="btn btn-default" type="button" onclick="searchContractCustom();">
						<i class="fa fa-search-plus "></i>
					</button>
				</div>
			</div>
			<div>
				<table class="table table-striped table-bordered table-hover">
					<thead>
						<tr>
							<td><i class="fa fa-check-square-o"></i></td>
							<td>거래처이름</td>
							<td>거래처코드</td>
							<td>대표명</td>
							<td>업태</td>
							<td>업종</td>
						</tr>
					</thead>
					<tbody id="tableCustomResult">
						<% 
							for(int i = 0; i < list.size(); i++) {
								CustomerDTO customer = list.get(i);
								BusinessTypeDTO bt = btDAO.getBusinessType(customer.getBusinessCondition(), customer.getBusinessType());
						%>
						<tr>
							<td><input type="radio" name="selectCustomToSearch" value="<%= customer.getCustomCode() %>"></td>
							<td><%= customer.getCustomerName() %></td>
							<td><%= customer.getCustomCode() %></td>
							<td><%= customer.getChiefName() %></td>
							<td><%= bt.getBusinessConditionName() %></td>
							<td><%= bt.getBusinessTypeName() %></td>
						<% } %>
					</tbody>
				</table>
			</div>
		</div>
	</div>
	<div class="modal-footer">
		<button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
		<button type="button" class="btn btn-primary"
			onclick="insertCCFunction();" data-dismiss="modal">확인</button>
	</div>
</body>
</html>