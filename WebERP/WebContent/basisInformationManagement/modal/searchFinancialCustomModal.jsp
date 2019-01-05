<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="financialcustom.FinancialCustomDAO" %>
<%@ page import="financialcustom.FinancialCustomDTO" %>
<%@ page import="java.util.ArrayList" %>
<%
	request.setCharacterEncoding("UTF-8");
	String companyCode = request.getParameter("companyCode");
	
	ArrayList<FinancialCustomDTO> list = new FinancialCustomDAO().getFinancialCustomList(companyCode);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script>
	function searchFinancialCustom() {
		var select = document.getElementById("financialCustomSearchDivision");
		var division = select.options[select.selectedIndex].value;
		var input = $('#financialCustomSearchInput').val();
		var companyCode = $('#paramCompanyCodeToSFC').val();
		$.ajax({
			type : 'POST',
			url : './financialCustomGetListServlet',
			data : {
				companyCode : companyCode,
				division : division,
				input : input
			},
			success : function(data) {
				if(data == "") {
					$('#tableFinancialCustomResult').empty();
					$('#tableFinancialCustomResult').append('');
				} else {
					var parsed = JSON.parse(data);
					var result = parsed.result;
					$('#tableFinancialCustomResult').empty();
					for (var i = 0; i < result.length; i++) {
						tableCustomGroupResult(result[i][0].value, result[i][1].value, result[i][2].value);
					}
				}
			}
		});
	}
	function tableCustomGroupResult(fcCode, fcName, division) {
		$('#tableFinancialCustomResult').append('<tr><td><input type="radio" id="selectFinancialCustomModal" name="selectFinancialCustomModal" value="' + fcCode
				+ '"></td>'
				+ '<td>' + fcCode + '</td>'
				+ '<td>' + fcName + '</td>'
				+ '<td>' + division + '</td></tr>');
	}
</script>
</head>
<body>
	<input type="hidden" id="paramCompanyCodeToSFC" value="<%= companyCode %>">
	<div class="modal-header">
		<button type="button" class="close" data-dismiss="modal"
			aria-hidden="true">&times;</button>
		<h4 class="modal-title" id="searchFinancialCustomLabel">금융 거래처 검색</h4>
	</div>
	<div class="modal-body">
		<div class="panel panel-default">
			<div class="row" style="margin-top: 10px; margin-bottom: 10px;">
				<div class="col-md-4">
					<select class="form-control" id="financialCustomSearchDivision" 
						style="width: 85%; float: right;">
						<option value="divisionFinancialCustomName">거래처명</option>
						<option value="divisionFinancialCustomCode">거래처코드</option>
						<option value="divisionFinancialCustomDivision">거래처분류</option>
					</select>
				</div>
				<div class="col-md-6">
					<input class="form-control" id="financialCustomSearchInput" type="text">
				</div>
				<div class="col-md-2">
					<button class="btn btn-default" type="button"
						onclick="searchFinancialCustom();">
						<i class="fa fa-search-plus"></i>
					</button>
				</div>
			</div>
			<div>
				<table class="table table-striped table-bordered table-hover">
					<thead>
						<tr>
							<th><i class="fa fa-check-square-o"></i></th>
							<th>코드</th>
							<th>금융거래처명</th>
							<th>구분</th>
						</tr>
					</thead>
					<tbody id="tableFinancialCustomResult">
						<%
							for(int i = 0; i < list.size(); i++) {
								FinancialCustomDTO financialCustom = list.get(i);
						%>
						<tr>
							<td><input type="radio" id="selectFinancialCustomModal" name="selectFinancialCustomModal" value="<%= financialCustom.getFcCode() %>"></td>
							<td><%= financialCustom.getFcCode() %></td>
							<td><%= financialCustom.getFcName() %></td>
							<td>
								<% 
									if(financialCustom.getDivision().equals("fi")) { out.println("금융거래처"); } 
									else if(financialCustom.getDivision().equals("td")) { out.println("정기예금"); } 
									else if(financialCustom.getDivision().equals("isd")) { out.println("정기적금"); } 
									else if(financialCustom.getDivision().equals("ccc")) { out.println("카드사"); } 
									else if(financialCustom.getDivision().equals("cd")) { out.println("신용카드"); } 
								%>
							</td>
						</tr>
						<% } %>
					</tbody>
				</table>
			</div>
		</div>
	</div>
	<div class="modal-footer">
		<button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
		<button type="button" class="btn btn-primary"
			onclick="insertFCFunction();" data-dismiss="modal">확인</button>
	</div>
</body>
</html>