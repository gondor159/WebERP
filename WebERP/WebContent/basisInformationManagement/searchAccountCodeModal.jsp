<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String companyCode = request.getParameter("companyCode");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script>

</script>
</head>
<body>
	<input type="hidden" id="" value="<%= companyCode %>">
	<div class="modal-header">
		<button type="button" class="close" data-dismiss="modal"
			aria-hidden="true">&times;</button>
		<h4 class="modal-title" id="searchAccountCodeLabel">은행코드 검색</h4>
	</div>
	<div class="modal-body">
		<div class="panel panel-default">
			<div class="row" style="margin-top: 10px; margin-bottom: 10px;">
				<div class="col-md-4">
					<select id="accountSearchDivision" style="width: 85%; height: 34px; float: right;">
						<option value="searchAccountName">계좌명</option>
						<option value="searchAccountCode">계좌코드</option>
						<option value="searchAccountNum">계좌번호</option>
					</select>
				</div>
				<div class="col-md-5">
					<input id="accountSearchInput" type="text" style="width: 100%; height: 34px;">
				</div>
				<div class="col-md-1">
					<button class="btn btn-default" type="button" onclick="searchAccount();">
						<i class="fa fa-search-plus "></i>
					</button>
				</div>
				<div class="col-md-2"></div>
			</div>
			<div>
				<table class="table table-striped table-bordered table-hover">
					<thead>
						<tr>
							<td><i class="fa fa-check-square-o"></i></td>
							<td>계좌코드</td>
							<td>계좌명</td>
							<td>금융기관명</td>
							<td>계좌번호</td>
						</tr>
					</thead>
					<tbody id="tableAccountCodeResult">
					<tr>
						<td><input type="radio" name="fiCode" value=""></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
					</tr>
					</tbody>
				</table>
			</div>
		</div>
	</div>
	<div class="modal-footer">
		<button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
		<button type="button" class="btn btn-primary"
			onclick="();" data-dismiss="modal">확인</button>
	</div>
</body>
</html>