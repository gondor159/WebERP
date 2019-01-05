<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO"%>
<%@ page import="businesstype.BusinessTypeDAO"%>
<%@ page import="businesstype.BusinessTypeDTO"%>
<%@ page import="placebusiness.PlaceBusinessDAO"%>
<%@ page import="placebusiness.PlaceBusinessDTO"%>
<%@ page import="field.FieldDAO"%>
<%@ page import="field.FieldDTO"%>
<%@ page import="employee.EmployeeDAO"%>
<%@ page import="employee.EmployeeDTO"%>
<%@ page import="department.DepartmentDAO"%>
<%@ page import="department.DepartmentDTO"%>
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
	ArrayList<EmployeeDTO> employeeList = new EmployeeDAO().getEmployeeListToCompany(companyCont.getCompanyCode());
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="">
<meta name="author" content="">

<title>회사 정보 등록</title>

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
	/* 아이디 검색 결과값 가져오기 function */
	function insertUserID() {
		var userID = $('input[name="selectUser"]:checked').val();
		$('#userID').attr('value', userID);
	}
	/* 사업장명 불러오기 function */
	function insertPlaceCode() {
		var companyCode = encodeURIComponent('<%=companyCont.getCompanyCode()%>');
		var placeCode = $('input[name="selectPlace"]:checked').val();
		$.ajax({
			type : 'POST',
			url : './placeBusinessGetNameServlet',
			data : {
				companyCode : companyCode,
				placeCode : placeCode
			},
			success : function(result) {
				$('#departmentTable').empty();
				$('#placeName').attr('value', result);
				$('#placeCode').attr('value', placeCode);
			}
		});
	}
	/* 부서명 불러오기 function */
	function insertFieldCode() {
		var companyCode = encodeURIComponent('<%=companyCont.getCompanyCode()%>');
		var departmentCode = $('input[name="selectDepartment"]:checked').val();
		var fieldCode = $('input[name="selectFieldCode"]:checked').val();
		$.ajax({
			type : 'POST',
			url : './departmentGetNameServlet',
			data : {
				companyCode : companyCode,
				fieldCode : fieldCode,
				departmentCode : departmentCode
			},
			success : function(result) {
				$('#fieldCode').attr('value', fieldCode);
				$('#departmentName').attr('value', result);
				$('#departmentCode').attr('value', departmentCode);
			}
		});
	}
</script>
<!-- 버튼 활성화 -->
<script>
$(function(){
	var companyCode = encodeURIComponent('<%=companyCont.getCompanyCode()%>');
	$("#searchUserButton").click(function(){
		$('#searchUser').modal({
			remote : 'modal/searchUserModal.jsp'
		});
	})
	$("#searchPlaceButton").click(function(){
		$('#searchPlace').modal({
			remote : 'modal/searchPlaceModal.jsp?companyCode=' + companyCode
		});
	})
	$("#searchDeptButton").click(function(){
		$('#searchDept').modal({
			remote : 'modal/searchDeptModal.jsp?companyCode=' + companyCode
		});
	})
});
</script>
</head>
<body>
	<nav class="navbar navbar-default navbar-static-top" role="navigation"
		style="margin-bottom: 0">
		<%@include file="../main/headNav.jsp"%>
		<%@include file="../main/sideNav.jsp" %>
	</nav>
	<div id="page-wrapper">
		<div class="row">
			<div class="col-lg-6">
				<h1 class="page-header">등록사원</h1>
			</div>
			<div class="col-lg-6">
				<h1 class="page-header">사원등록</h1>
			</div>
		</div>
		<div class="row">
			<div class="col-lg-6">
				<div class="panel panel-default">
					<div class="panel-heading">등록된 사원을 확인 할 수 있습니다.</div>
					<div class="panel-body">
						<table width="100%"
							class="table table-striped table-bordered table-hover"
							id="dataTables-example">
							<thead>
								<tr>
									<th>사원 번호</th>
									<th>사원명</th>
									<th>사업장명</th>
									<th>부서명</th>
									<th>입사일</th>
								</tr>
							</thead>
							<tbody>
								<%
									if(employeeList != null) {
										for(int i = 0; i < employeeList.size(); i++) {
											EmployeeDTO employee = employeeList.get(i);
											String placeName = new PlaceBusinessDAO().getPlaceName(employee.getCompanyCode(), employee.getPlaceCode());
											String departmentName = new DepartmentDAO().getDepartmentName(employee.getCompanyCode(), employee.getFieldCode(), employee.getDepartmentCode());
											String userName = new UserDAO().findUserName(employee.getUserID());
								%>
								<tr class="odd gradeX">
									<td class="center"><%= employee.getEmployeeNum() %></td>
									<td class="center"><%= userName %></td>
									<td class="center"><%= placeName %></td>
									<td class="center"><%= departmentName %></td>
									<td class="center"><%= employee.getJoinDate() %></td>
								</tr>
								<%
										}
									} else {
								%>
								<tr class="odd gradeX">
									<td></td>
									<td></td>
									<td></td>
									<td></td>
									<td></td>
								</tr>
								<%
									}
								%>
							</tbody>
						</table>
					</div>
				</div>
			</div>
			<div class="col-lg-6">
				<div class="panel panel-default">
					<div class="panel-heading">간단한 사원 정보를 입력합니다.</div>
					<div class="panel-body">
						<div class="row">
							<div class="col-lg-12">
								<form role="form" method="POST" action="./employeeRegistServlet">
									<input type="hidden" name="companyCode" value="<%=companyCont.getCompanyCode()%>">
									<table class="table table-striped">
										<tr>
											<td style="text-align: right;"><h5>사원 ID</h5></td>
											<td><input class="form-control" type="text" id="userID" name="userID" readonly></td>
											<td><button class="btn btn-default" id="searchUserButton" type="button"><i class="fa fa-search-plus"></i></button></td>
											<td></td>
										</tr>
										<tr>
											<td style="text-align: right;"><h5>사원번호</h5></td>
											<td><input class="form-control" type="text" name="employeeNum"></td>
											<td colspan="2"></td>
										</tr>
										<tr>
                            				<td style="text-align: right;"><h5>사업장</h5></td>
                            				<td><input class="form-control" id="placeCode" type="text" name="placeCode" readonly></td>
                            				<td style="text-align: left;"><button class="btn btn-default" id="searchPlaceButton" type="button"><i class="fa fa-search-plus "></i></button></td>
                            				<td><input class="form-control" id="placeName" type="text" readonly></td>
                            			</tr>
                            			<tr>
                            				<td style="text-align: right;"><h5>부서</h5></td>
                            				<td><input class="form-control" id="departmentCode" type="text" name="departmentCode" readonly><input id="fieldCode" type="hidden" name="fieldCode"></td>
                            				<td style="text-align: left;"><button class="btn btn-default" id="searchDeptButton" type="button"><i class="fa fa-search-plus "></i></button></td>
                            				<td><input class="form-control" id="departmentName" type="text" readonly></td>
                            			</tr>
                            			<tr>
											<td style="text-align: right;"><h5>입사일</h5></td>
											<td colspan="2"><input class="form-control" id="joinDate" type="date" placeholder="YYYY-MM-DD" name="joinDate"></td>
											<td></td>
										</tr>
									</table>
									<button class="btn btn-outline btn-primary btn-lg btn-block" type="submit">등록</button>
								</form>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- Modal -->
	<!-- 유저 검색 -->
	<div class="modal fade" id="searchUser" tabindex="-1" role="dialog"
		aria-labelledby="searchUserLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
			</div>
		</div>
	</div>
	<!-- 사업장 검색 -->
	<div class="modal fade" id="searchPlace" tabindex="-1" role="dialog"
		aria-labelledby="searchPlaceLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
			</div>
		</div>
	</div>
	<!-- 부서 검색 -->
	<div class="modal fade" id="searchDept" tabindex="-1" role="dialog"
		aria-labelledby="searchDeptLabel" aria-hidden="true">
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