<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="company.CompanyDAO"%>
<%@ page import="company.CompanyDTO"%>
<%@ page import="track.TrackDAO"%>
<%@ page import="track.TrackDTO"%>
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
	ArrayList<TrackDTO> list = new TrackDAO().getTrackList(companyCont.getCompanyCode());
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
	/* 프로젝트 그룹 등록 */
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
	/* 원청회사 등록 */
	function insertCCFunction() {
		var companyCode =  encodeURIComponent('<%=companyCont.getCompanyCode()%>');
		var customCode = $('input[name="selectCustomToSearch"]:checked').val();
		$.ajax({
			type : 'POST',
			url : './customerGetNameServlet',
			data : {
				companyCode : companyCode,
				customCode : customCode
			},
			success : function(data) {
				if(data == "") return;
				var parsed = JSON.parse(data);
				var result = parsed.result;
				$('#contractCompanyName').attr('value', result[0].value);
			}
		});
		$('#contractCompany').attr('value', customCode);
	}
	/* 프로젝트 수정 */
	function editProject() {
		var projectCode = $('input[name="selectProject"]:checked').val();
		if (projectCode != null) {
			location.href = 'projectEdit.jsp?projectCode=' + projectCode;
		} else {
			alert('프로젝트를 선택하여 주세요.');
		}
	}
	/* 프로젝트 삭제 */
	function deleteProject() {
		var companyCode =  encodeURIComponent('<%=companyCont.getCompanyCode()%>');
		var projectCode = $('input[name="selectProject"]:checked').val();
		$.ajax({
			type : 'POST',
			url : './projectDeleteSerlvet',
			data : {
				companyCode : companyCode,
				projectCode : projectCode
			},
			success : function(result) {
				if(result == "9") {
					alert('프로젝트를 선택하여 주세요.');
					return;
				} else if(result == "-1") {
					alert('데이터베이스 오류입니다.');
					return;
				} else {
					alert('삭제되었습니다.');
					location.reload();
				}
			}
		});
	}
</script>

<!-- Button 활성화 -->
</head>
<body>
	<nav class="navbar navbar-default navbar-static-top" role="navigation" style="margin-bottom: 0">
		<%@include file="../main/headNav.jsp"%>
		<%@include file="../main/sideNav.jsp"%>
	</nav>
	<div id="page-wrapper">
		<div class="row">
			<div class="col-lg-6">
				<h1 class="page-header">품목군</h1>
				<div class="panel panel-default">
					<div class="panel-heading">등록된 품목군을 확인 할 수 있습니다.</div>
					<div class="panel-body">
						<table class="table table-striped table-bordered table-hover">
							<thead>
								<tr>
									<th><i class="fa fa-check-square-o"></i></th>
									<th>코드</th>
									<th>품목군명</th>
									<th>사용여부</th>
								</tr>
							</thead>
							<tbody>
							<% 
								for(int i = 0; i < list.size(); i++) { 
									TrackDTO track = list.get(i);
							%>
							<tr>
								<td><input type="radio" name="selectTrack" value="<%= track.getTrackCode() %>"></td>
								<td><%= track.getTrackCode() %></td>
								<td><%= track.getTrackName() %></td>
								<td><% if(track.getUseBoolean().equals("1")) { out.println("사용"); } else { out.println("미사용"); } %></td>
							</tr>
							<% } %>
							</tbody>
						</table>
						<div style="float: right;">
							<button class="btn btn-outline btn-primary" type="button" onclick="editProject();">수정</button>
							<button class="btn btn-outline btn-danger" type="button" onclick="deleteProject();">삭제</button>
						</div>
					</div>
				</div>
				<h1 class="page-header">품목군 등록</h1>
				<div class="panel panel-default">
					<div class="panel-heading">품목군을 등록합니다.</div>
					<form class="panel-body" method="POST" action="./trackRegistServlet">
						<input type="hidden" name="companyCode" value="<%= companyCont.getCompanyCode() %>">
						<input type="hidden" name="lastUser" value="<%= userID %>">
						<table class="table table-striped">
							<tr>
								<td style="text-align: right;"><h5>품목군 코드</h5></td>
								<td><input class="form-control" style="width: 50%;" type="text" name="trackCode"></td>
							</tr>
							<tr>
								<td style="text-align: right;"><h5>품목군명</h5></td>
								<td><input class="form-control" style="width: 50%;" type="text" name="trackName"></td>
							</tr>
							<tr>
								<td style="text-align: right;"><h5>사용여부</h5></td>
								<td style="vertical-align: middle;">
									<label class="radio-inline"><input type="radio" name="useBoolean" value="1"> 여</label>
									<label class="radio-inline"><input type="radio" name="useBoolean" value="0"> 부</label>
								</td>
							</tr>
							<tr>
								<td style="text-align: right; vertical-align: middle;"><h5>설명</h5></td>
								<td><textarea class="form-control" name="trackInfo" rows="3"></textarea></td>
							</tr>
						</table>
						<button class="btn btn-outline btn-primary btn-lg btn-block" type="submit">등록</button>
					</form>
				</div>
			</div>
			<div class="col-lg-6">
				<div class="panel panel-default">
					<div class="panel-heading">
					</div>
					<div class="panel-body">
					</div>
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
		</div>
	</div>
	<!-- 프로젝트 분류 등록 -->
	<div class="modal fade" id="insertProjectGroup" tabindex="-1" role="dialog"
		aria-labelledby="insertProjectGroupLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
			</div>
		</div>
	</div>
	<!-- 원청회사 검색 -->
	<div class="modal fade" id="searchContractCompany" tabindex="-1" role="dialog"
		aria-labelledby="searchContractCompanyLabel" aria-hidden="true">
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
