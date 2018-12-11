<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="financialInstitution.FinancialInstitutionDTO" %>
<%@ page import="financialInstitution.FinancialInstitutionDAO" %>
<%@ page import="java.util.ArrayList"%>
<%
	ArrayList<FinancialInstitutionDTO> fiList = new FinancialInstitutionDAO().getFinancialInstitution();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script>
	function searchFinancialInstitution() {
		var fiName = $('#financialInstitutionSearchInput').val();
		$.ajax({
			type : 'POST',
			url : './financialInstitutionFindServlet',
			data : {
				financialinstitutionName : fiName
			},
			success : function(data) {
				if(data == "") {
					$('#tableFinancialInstitutionResult').empty();
					$('#tableFinancialInstitutionResult').append('');
				} else {
					var parsed = JSON.parse(data);
					var result = parsed.result;
					$('#tableFinancialInstitutionResult').empty();
					for (var i = 0; i < result.length; i++) {
						tableFinancialInstitutionResultFunction(result[i][0].value, result[i][1].value);
					}
				}
			}
		});
	}
	function tableFinancialInstitutionResultFunction(financialinstitutionCode, financialinstitutionName) {
		$('#tableFinancialInstitutionResult').append('<tr><td><input type="radio" name="fiCode" value="' + financialinstitutionCode + '"></td>' +
				'<td>' + financialinstitutionCode + '</td>' + '<td>' + financialinstitutionName + '</td></tr>');
	}
</script>
</head>
<body>
<div class="modal-header">
		<button type="button" class="close" data-dismiss="modal"
			aria-hidden="true">&times;</button>
		<h4 class="modal-title" id="searchFinancialInstitutionLabel">금융기관 검색</h4>
	</div>
	<div class="modal-body">
		<div class="panel panel-default">
			<div class="row" style="margin-top: 10px; margin-bottom: 10px;">
				<div class="col-md-3">
					<h5 style="text-align: center;">이름으로 검색</h5>
				</div>
				<div class="col-md-6">
					<input id="financialInstitutionSearchInput" type="text"
						style="width: 100%; height: 34px;">
				</div>
				<div class="col-md-2">
					<button class="btn btn-default" type="button"
						onclick="searchFinancialInstitution();">
						<i class="fa fa-search-plus "></i>
					</button>
				</div>
				<div class="col-md-1">
				</div>
			</div>
			<div>
				<table class="table table-striped table-bordered table-hover">
					<thead>
						<tr>
							<td><i class="fa fa-check-square-o"></i></td>
							<td>코드</td>
							<td>은행명</td>
						</tr>
					</thead>
					<tbody id="tableFinancialInstitutionResult">
					<% 
						if(fiList != null) {
							for(int i = 0; i < fiList.size(); i++) {
								FinancialInstitutionDTO fi = fiList.get(i);
					%>
					<tr>
						<td><input type="radio" name="fiCode" value="<%= fi.getFinancialinstitutionCode() %>"></td>
						<td><%= fi.getFinancialinstitutionCode() %></td>
						<td><%= fi.getFinancialinstitutionName() %></td>
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
			onclick="insertFIFunction();" data-dismiss="modal">확인</button>
	</div>
</body>
</html>