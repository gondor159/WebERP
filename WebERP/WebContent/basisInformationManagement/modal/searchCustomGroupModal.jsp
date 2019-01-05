<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="customgroup.CustomGroupDAO" %>
<%@ page import="customgroup.CustomGroupDTO" %>
<%@ page import="java.util.ArrayList" %>
<%
	request.setCharacterEncoding("UTF-8");
	String companyCode = request.getParameter("companyCode");
	
	ArrayList<CustomGroupDTO> list = new CustomGroupDAO().getCustomGroupList(companyCode);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script>
	function searchCustomGroup() {
		var select = document.getElementById("customGroupSearchDivision");
		var division = select.options[select.selectedIndex].value;
		var input = $('#customGroupSearchInput').val();
		var companyCode = $('#paramCompanyCodeToSPG').val();
		$.ajax({
			type : 'POST',
			url : './customGroupGetListServlet',
			data : {
				companyCode : companyCode,
				division : division,
				input : input
			},
			success : function(data) {
				if(data == "") {
					$('#tableCustomGroupResult').empty();
					$('#tableCustomGroupResult').append('');
				} else {
					var parsed = JSON.parse(data);
					var result = parsed.result;
					$('#tableCustomGroupResult').empty();
					for (var i = 0; i < result.length; i++) {
						tableCustomGroupResult(result[i][0].value, result[i][1].value);
					}
				}
			}
		});
	}
	function tableCustomGroupResult(customGroup, groupName) {
		$('#tableCustomGroupResult').append('<tr><td><input type="radio" id="selectCustomGroup" name="selectCustomGroup" value="' + customGroup
				+ '"></td>'
				+ '<td>' + customGroup + '</td>'
				+ '<td>' + groupName + '</td></tr>');
	}
</script>
</head>
<body>
	<input type="hidden" id="paramCompanyCodeToSPG" value="<%= companyCode %>">
	<div class="modal-header">
		<button type="button" class="close" data-dismiss="modal"
			aria-hidden="true">&times;</button>
		<h4 class="modal-title" id="searchCustomGroupLabel">거래처 분류 검색</h4>
	</div>
	<div class="modal-body">
		<div class="panel panel-default">
			<div class="row" style="margin-top: 10px; margin-bottom: 10px;">
				<div class="col-md-4">
					<select class="form-control" id="customGroupSearchDivision" 
						style="width: 85%; float: right;">
						<option value="divisionCustomGroupName">분류명</option>
						<option value="divisionCustomGroupCode">분류코드</option>
					</select>
				</div>
				<div class="col-md-6">
					<input class="form-control" id="customGroupSearchInput" type="text">
				</div>
				<div class="col-md-2">
					<button class="btn btn-default" type="button"
						onclick="searchCustomGroup();">
						<i class="fa fa-search-plus"></i>
					</button>
				</div>
			</div>
			<div>
				<table class="table table-striped table-bordered table-hover">
					<thead>
						<tr>
							<td><i class="fa fa-check-square-o"></i></td>
							<td>코드</td>
							<td>거래처 분류명</td>
						</tr>
					</thead>
					<tbody id="tableCustomGroupResult">
						<% 
							for(int i = 0; i < list.size(); i++) { 
								CustomGroupDTO group = list.get(i);
						%>
						<tr>
							<td><input type="radio" id="selectCustomGroup" name="selectCustomGroup" value="<%= group.getCustomGroup() %>"></td>
							<td><%= group.getCustomGroup() %></td>
							<td><%= group.getGroupName() %></td>
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
			onclick="insertCGFunction();" data-dismiss="modal">확인</button>
	</div>
</body>
</html>