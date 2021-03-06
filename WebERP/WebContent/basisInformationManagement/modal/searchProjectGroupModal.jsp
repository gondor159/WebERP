<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="projectgroup.ProjectGroupDAO" %>
<%@ page import="projectgroup.ProjectGroupDTO" %>
<%@ page import="java.util.ArrayList" %>
<%
	request.setCharacterEncoding("UTF-8");
	String companyCode = request.getParameter("companyCode");
	
	ArrayList<ProjectGroupDTO> list = new ProjectGroupDAO().getProjectGroupList(companyCode);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script>
	function searchProjectGroup() {
		var select = document.getElementById("projectGroupSearchDivision");
		var division = select.options[select.selectedIndex].value;
		var input = $('#projectGroupSearchInput').val();
		var companyCode = $('#paramCompanyCodeToSPG').val();
		$.ajax({
			type : 'POST',
			url : './projectGroupGetListServlet',
			data : {
				companyCode : companyCode,
				division : division,
				input : input
			},
			success : function(data) {
				if(data == "") {
					$('#tableProjectGroupResult').empty();
					$('#tableProjectGroupResult').append('');
				} else {
					var parsed = JSON.parse(data);
					var result = parsed.result;
					$('#tableProjectGroupResult').empty();
					for (var i = 0; i < result.length; i++) {
						tableProjectGroupResult(result[i][0].value, result[i][1].value);
					}
				}
			}
		});
	}
	function tableProjectGroupResult(projectGroup, groupName) {
		$('#tableProjectGroupResult').append('<tr><td><input type="radio" id="selectProjectGroup" name="selectProjectGroup" value="' + projectGroup
				+ '"></td>'
				+ '<td>' + projectGroup + '</td>'
				+ '<td>' + groupName + '</td></tr>');
	}
</script>
</head>
<body>
	<input type="hidden" id="paramCompanyCodeToSPG" value="<%= companyCode %>">
	<div class="modal-header">
		<button type="button" class="close" data-dismiss="modal"
			aria-hidden="true">&times;</button>
		<h4 class="modal-title" id="searchProjectGroupLabel">프로젝트 분류 검색</h4>
	</div>
	<div class="modal-body">
		<div class="panel panel-default">
			<div class="row" style="margin-top: 10px; margin-bottom: 10px;">
				<div class="col-md-4">
					<select class="form-control" id="projectGroupSearchDivision" 
						style="width: 85%; float: right;">
						<option value="divisionProjectGroupName">분류명</option>
						<option value="divisionProjectGroupCode">분류코드</option>
					</select>
				</div>
				<div class="col-md-6">
					<input class="form-control" id="projectGroupSearchInput" type="text">
				</div>
				<div class="col-md-2">
					<button class="btn btn-default" type="button"
						onclick="searchProjectGroup();">
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
							<td>프로젝트 분류명</td>
						</tr>
					</thead>
					<tbody id="tableProjectGroupResult">
						<% 
							for(int i = 0; i < list.size(); i++) { 
								ProjectGroupDTO group = list.get(i);
						%>
						<tr>
							<td><input type="radio" id="selectProjectGroup" name="selectProjectGroup" value="<%= group.getProjectGroup() %>"></td>
							<td><%= group.getProjectGroup() %></td>
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
			onclick="insertPGFunction();" data-dismiss="modal">확인</button>
	</div>
</body>
</html>