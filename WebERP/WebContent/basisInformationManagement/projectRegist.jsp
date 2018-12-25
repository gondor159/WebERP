<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="project.ProjectDAO"%>
<%@ page import="project.ProjectDTO"%>
<%@ page import="company.CompanyDAO"%>
<%@ page import="company.CompanyDTO"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.io.PrintWriter"%>
<%
	String userID = null;
	if (session.getAttribute("userID") != null) {
		userID = (String) session.getAttribute("userID");
	}
	if (userID == null) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인이 필요합니다.')");
		script.println("location.href = '../login.jsp'");
		script.println("</script>");
		return;
	}
	
	CompanyDTO companyCont = new CompanyDAO().getCompanyToID(userID);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="">
<meta name="author" content="">
<title>프로젝트 등록</title>

<!-- CSS -->
	<!-- Modal table CSS -->
	<link href="../css/table.css" rel="stylesheet">
	<!-- Bootstrap Core CSS -->
	<link href="../vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
	<!-- MetisMenu CSS -->
	<link href="../vendor/metisMenu/metisMenu.min.css" rel="stylesheet">
	<!-- DataTables CSS -->
	<link href="../vendor/datatables-plugins/dataTables.bootstrap.css" rel="stylesheet">
	<!-- DataTables Responsive CSS -->
	<link href="../vendor/datatables-responsive/dataTables.responsive.css" rel="stylesheet">
	<!-- Custom CSS -->
	<link href="../dist/css/sb-admin-2.css" rel="stylesheet">
	<!-- Custom Fonts -->
	<link href="../vendor/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">
	<!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
	<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
	<!--[if lt IE 9]>
    <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
    <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
	<![endif]-->
<!-- /CSS -->

<!-- jQuery -->
	<script type="text/javascript" src="//code.jquery.com/jquery-3.3.1.js" charset="UTF-8"></script>
<!-- /jQuery -->

<script>
	function insertPGFunction() {
		var companyCode =  encodeURIComponent('<%=companyCont.getCompanyCode()%>');
		var projectGroup = $('input[name="selectProjectGroup"]:checked').val();
		$.ajax({
			type : 'POST',
			url : './projectGroupGetServlet',
			data : {
				companyCode : companyCode,
				projectGroup : projectGroup
			},
			success : function(data) {
				if(data == "") return;
				var parsed = JSON.parse(data);
				var result = parsed.result;
				$('#projectGroup').attr('value', result[0].value);
				$('#projectGroupName').attr('value', result[1].value);
			}
		});
	}
</script>

<!-- Button 활성화 -->
<script>
$(function() {
	var companyCode = encodeURIComponent('<%=companyCont.getCompanyCode()%>');
	/* 프로젝트 분류 검색 버튼 */
	$("#searchProjectGroupBtn").click(function(){
		$('#searchProjectGroup').modal({
			remote : 'modal/searchProjectGroupModal.jsp?companyCode=' + companyCode
		});
	})
	/* 프로젝트 분류 등록 버튼 */
	$("#insertProjectGroupBtn").click(function(){
		$('#insertProjectGroup').modal({
			remote : 'modal/insertProjectGroupModal.jsp?companyCode=' + companyCode
		});
	})
})
</script>
</head>
<body>
	<nav class="navbar navbar-default navbar-static-top" role="navigation" style="margin-bottom: 0">
		<%@include file="../main/headNav.jsp"%>
		<%@include file="../main/sideNav.jsp"%>
	</nav>
	<div id="page-wrapper">
		<div class="row">
			<div class="col-lg-12">
				<h1 class="page-header">프로젝트 등록</h1>
			</div>
		</div>
		<div class="row">
			<div class="col-lg-5">
				<div class="panel panel-default">
					<div class="panel-heading">등록된 프로젝트를 확인 할 수 있습니다.</div>
					<!-- /.panel-heading -->
					<div class="panel-body">
						<table width="100%"
							class="table table-striped table-bordered table-hover">
							<thead>
								<tr>
									<th><i class="fa fa-check-square-o"></i></th>
									<th>코드</th>
									<th>프로젝트명</th>
									<th>구분</th>
								</tr>
							</thead>
						</table>
						<div style="float: right;">
							<button class="btn btn-outline btn-primary" type="button" onclick="editProject();">수정</button>
							<button class="btn btn-outline btn-danger" type="button">삭제</button>
						</div>
					</div>
				</div>
			</div>
			<div class="col-lg-7">
				<div class="panel panel-default">
					<div class="panel-heading">
						<div class="row">
							<div class="col-lg-6"><h5>프로젝트 정보를 확인합니다.</h5></div>
							<div class="col-lg-6" style="text-align: right;"><button type="button" class="btn btn-default" id="insertProjectGroupBtn">분류등록</button></div>
						</div>
					</div>
					<form class="panel-body" method="POST"
						action="./projectRegistServlet">
						<input type="hidden" name="companyCode" value="123">
						<div class="row">
							<div class="col-lg-12">
								<br>
								<table class="table table-striped">
									<tr>
										<td style="text-align: right;"><h5>* 프로젝트코드</h5></td>
										<td><input class="form-control" id="projectCode" type="text" name="projectCode"></td>
										<td style="text-align: right;"><h5>* 구분</h5></td>
										<td>
											<select class="form-control" style="width: 70%;" name="division">
												<option value="progress">진행</option>
												<option value="complete">완료</option>
												<option value="unused">미사용</option>
											</select>
										</td>
									</tr>
									<tr>
										<td style="text-align: right;"><h5>* 프로젝트 명</h5></td>
										<td colspan="3"><input class="form-control" id="projectName" type="text" name="projectName"></td>
									</tr>
									<tr>
										<td style="text-align: right;"><h5>프로젝트 기간</h5></td>
										<td><input class="form-control" type="date" name="projectSince" placeholder="YYYY-MM-DD"></td>
									    <td style="text-align: center;"><h5>~</h5></td>
									    <td><input class="form-control" type="date" name="projectTill" placeholder="YYYY-MM-DD"></td>
									</tr>
									<tr>
										<td style="text-align: right;"><h5>원청회사</h5></td>
										<td><input class="form-control" id="contractCompany" type="text" name="contractCompany"></td>
										<td style="text-align: left;">
											<button class="btn btn-default" id="searchCustomBtn" type="button"><i class="fa fa-search-plus "></i></button>
										</td>
										<td><input class="form-control" id="contractCompanyName" type="text" readonly></td>

									</tr>
									<tr>
										<td style="text-align: right;"><h5>시작일</h5></td>
										<td><input class="form-control" type="date" name="startDate" placeholder="YYYY-MM-DD"></td>
										<td colspan="2"></td>
									</tr>
									<tr>
										<td style="text-align: right;"><h5>원가구분</h5></td>
										<td>
											<select class="form-control" name="costDivision">
												<option value="manufacture">제조</option>
												<option value="parcelOut">분양</option>
												<option value="contract">도급</option>
												<option value="etc">기타</option>
											</select>
										</td>
										<td colspan="2"></td>
									</tr>
									<tr>
										<td style="text-align: right;"><h5>프로젝트 유형</h5></td>
										<td>
									    	<select class="form-control" name="projectType">
												<option value="direct">직접</option>
												<option value="common">공통</option>
											</select>
										</td>
										<td colspan="2"></td>
									</tr>
									<tr>
										<td style="text-align: right;"><h5>프로젝트 금액</h5></td>
										<td><input class="form-control" id="projectSum" type="text"name="projectSum"></td>
										<td colspan="2"></td>
									</tr>
									<tr>
										<td style="text-align: right;"><h5>프로젝트 분류</h5></td>
										<td><input class="form-control" id="projectGroup" type="text" name="projectGroup"></td>
										<td style="text-align: left;">
											<button class="btn btn-default" id="searchProjectGroupBtn" type="button"><i class="fa fa-search-plus"></i></button>
										</td>
										<td><input class="form-control" id="projectGroupName" type="text" readonly></td>

									</tr>
									<tr>
										<td style="text-align: right;"><h5>비고</h5></td>
										<td colspan="3"><textarea class="form-control" name="note" rows="3"></textarea></td>
									</tr>
									<tr>
										<td style="text-align: right;"><h5>고용관리 책임자</h5></td>
										<td><input class="form-control" id="employmentManager" type="text" name="employmentManager"></td>
										<td colspan="2"></td>
									</tr>
									<tr>
										<td style="text-align: right;"><h5>고용관리 책임자 주민번호</h5></td>
										<td><input class="form-control" id="employmentManagerIdentityNum" type="text" name="employmentManagerIdentityNum"></td>
										<td colspan="2"></td>
									</tr>
									<tr>
										<td style="text-align: right;"><h5>고용관리 책임자 직위</h5></td>
										<td><input class="form-control" id="EMposition" type="text" name="EMposition"></td>
										<td colspan="2"></td>
									</tr>
									<tr>
										<td style="text-align: right;"><h5>고용관리 책임자 직무내용</h5></td>
										<td colspan="3"><textarea class="form-control" name="EMtask" rows="3"></textarea></td>
									</tr>
									<tr>
										<td style="text-align: right;"><h5>근무지</h5></td>
										<td colspan="3" style="vertical-align: middle;">
											<label class="radio-inline">
												<input type="radio" name="employment" value="head" checked>본사
											</label>
											<label class="radio-inline">
												<input type="radio" name="employment" value="thisPlace">해당 사업장(현장)
											</label>
											<label class="radio-inline">
												<input type="radio" name="employment" value="anotherPlace">다른 사업장(현장)
											</label>
										</td>
									</tr>
								</table>
							</div>
						</div>
						<button class="btn btn-outline btn-primary btn-lg btn-block" type="submit">등록</button>
					</form>
				</div>
			</div>
		</div>
	</div>
	<!-- Modal -->
	<!-- 프로젝트 분류 검색 -->
	<div class="modal fade" id="searchProjectGroup" tabindex="-1" role="dialog"
		aria-labelledby="searchProjectGroupLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal-dialog -->
	</div>
	<!-- 프로젝트 분류 등록 -->
	<div class="modal fade" id="insertProjectGroup" tabindex="-1" role="dialog"
		aria-labelledby="insertProjectGroupLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
			</div>
		</div>
	</div>
	
<!-- JavaScript -->
	<!-- jQuery -->
	<script src="../vendor/jquery/jquery.min.js"></script>
	<!-- Bootstrap Core JavaScript -->
	<script src="../vendor/bootstrap/js/bootstrap.min.js"></script>
	<!-- Metis Menu Plugin JavaScript -->
	<script src="../vendor/metisMenu/metisMenu.min.js"></script>
	<!-- DataTables JavaScript -->
	<script src="../vendor/datatables/js/jquery.dataTables.min.js"></script>
	<script src="../vendor/datatables-plugins/dataTables.bootstrap.min.js"></script>
	<script src="../vendor/datatables-responsive/dataTables.responsive.js"></script>
	<!-- Custom Theme JavaScript -->
	<script src="../dist/js/sb-admin-2.js"></script>
	<!-- Page-Level Demo Scripts - Tables - Use for reference -->
	<script>
		$(document).ready(function() {
			$('#dataTables-example').DataTable({
				responsive : true
			});
		});
	</script>
	<!-- Page-Level Demo Scripts - Notifications - Use for reference -->
	<script>
		// tooltip demo
		$('.tooltip-demo').tooltip({
			selector : "[data-toggle=tooltip]",
			container : "body"
		})
		// popover demo
		$("[data-toggle=popover]").popover()
	</script>
<!-- /JavaScript -->
</body>
</html>
