<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="project.ProjectDAO" %>
<%@ page import="project.ProjectDTO" %>
<%@ page import="java.util.ArrayList" %>
<%
	request.setCharacterEncoding("UTF-8");
	String companyCode = request.getParameter("companyCode");
	
	ArrayList<ProjectDTO> list = new ProjectDAO().getProjectList(companyCode);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script>
	function searchProject() {
		var select = document.getElementById("projectSearchDivision");
		var division = select.options[select.selectedIndex].value;
		var input = $('#projectSearchInput').val();
		var companyCode = $('#paramCompanyCodeToSP').val();
		$.ajax({
			type : 'POST',
			url : './projectFindToModal',
			data : {
				companyCode : companyCode,
				division : division,
				input : input
			},
			success : function(data) {
				if(data == "") {
					$('#tableProjectResult').empty();
					$('#tableProjectResult').append('');
				} else {
					var parsed = JSON.parse(data);
					var result = parsed.result;
					$('#tableProjectResult').empty();
					for (var i = 0; i < result.length; i++) {
						tableProjectResult(result[i][0].value, result[i][1].value);
					}
				}
			}
		});
	}
	function tableProjectResult(projectCode, projectName) {
		$('#tableProjectResult').append('<tr><td><input type="radio" id="selectProject" name="selectProject" value="' + projectCode
				+ '"></td>'
				+ '<td>' + projectCode + '</td>'
				+ '<td>' + projectName + '</td></tr>');
	}
</script>
</head>
<body>
	<input type="hidden" id="paramCompanyCodeToSP" value="<%= companyCode %>">
	<div class="modal-header">
		<button type="button" class="close" data-dismiss="modal"aria-hidden="true">&times;</button>
		<h4 class="modal-title" id="searchProjectLabel">프로젝트 검색</h4>
	</div>
	<div class="modal-body">
		<div class="panel panel-default">
			<div class="row" style="margin-top: 10px; margin-bottom: 10px;">
				<div class="col-md-4">
					<select class="form-control" id="projectSearchDivision">
						<option value="divisionProjectName">프로젝트명</option>
						<option value="divisionProjectCode">프로젝트코드</option>
					</select>
				</div>
				<div class="col-md-5">
					<input class="form-control" id="projectSearchInput" type="text">
				</div>
				<div class="col-md-1">
					<button class="btn btn-default" type="button" onclick="searchProject();">
						<i class="fa fa-search-plus "></i>
					</button>
				</div>
				<div class="col-md-2"><button class="btn btn-default" onclick="">추가</button></div>
			</div>
			<div>
				<table class="table table-striped table-bordered table-hover">
					<thead>
						<tr>
							<td><i class="fa fa-check-square-o"></i></td>
							<td>코드</td>
							<td>프로젝트명</td>
						</tr>
					</thead>
					<tbody id="tableProjectResult">
						<% 
							for(int i = 0; i < list.size(); i++) { 
								ProjectDTO project = list.get(i);
						%>
						<tr>
							<td><input type="radio" id="selectProject" name="selectProject" value="<%= project.getProjectCode() %>"></td>
							<td><%= project.getProjectCode() %></td>
							<td><%= project.getProjectName() %></td>
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
			onclick="insertPFunction();" data-dismiss="modal">확인</button>
	</div>
</body>
</html>