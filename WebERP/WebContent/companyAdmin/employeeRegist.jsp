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

<!-- Modal table CSS -->
<link href="../css/table.css" rel="stylesheet">

<!-- Bootstrap Core CSS -->
<link href="../vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">

<!-- MetisMenu CSS -->
<link href="../vendor/metisMenu/metisMenu.min.css" rel="stylesheet">

<!-- DataTables CSS -->
<link href="../vendor/datatables-plugins/dataTables.bootstrap.css"
	rel="stylesheet">

<!-- DataTables Responsive CSS -->
<link href="../vendor/datatables-responsive/dataTables.responsive.css"
	rel="stylesheet">

<!-- Custom CSS -->
<link href="../dist/css/sb-admin-2.css" rel="stylesheet">

<!-- Custom Fonts -->
<link href="../vendor/font-awesome/css/font-awesome.min.css"
	rel="stylesheet" type="text/css">

<!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
<!--[if lt IE 9]>
    <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
    <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
<![endif]-->
<!-- jQuery -->
<script type="text/javascript" src="//code.jquery.com/jquery-3.3.1.js" charset="UTF-8"></script>
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
<script>
$(function(){
	var companyCode = encodeURIComponent('<%=companyCont.getCompanyCode()%>');
    $("#findUserButton").click(function(){
       $('#findUser').modal({
        				remote : 'findUserModal.jsp'
              });
    })
    $("#findPlaceButton").click(function(){
       $('#findPlace').modal({
        				remote : 'findPlaceModal.jsp?companyCode=' + companyCode
              });
    })
     $("#findDeptButton").click(function(){
       $('#findDept').modal({
        				remote : 'findDeptModal.jsp?companyCode=' + companyCode
              });
    })
});
</script>
</head>
<body>
	<!-- Navigation -->
	<nav class="navbar navbar-default navbar-static-top" role="navigation"
		style="margin-bottom: 0">
		<div class="navbar-header">
			<button type="button" class="navbar-toggle" data-toggle="collapse"
				data-target=".navbar-collapse">
				<span class="sr-only">Toggle navigation</span> <span
					class="icon-bar"></span> <span class="icon-bar"></span> <span
					class="icon-bar"></span>
			</button>
			<a class="navbar-brand" href="index.html">SB Admin v2.0</a>
		</div>
		<!-- /.navbar-header -->

		<ul class="nav navbar-top-links navbar-right">
			<li class="dropdown"><a class="dropdown-toggle"
				data-toggle="dropdown" href="#"> <i class="fa fa-envelope fa-fw"></i>
					<i class="fa fa-caret-down"></i>
			</a>
				<ul class="dropdown-menu dropdown-messages">
					<li><a href="#">
							<div>
								<strong>John Smith</strong> <span class="pull-right text-muted">
									<em>Yesterday</em>
								</span>
							</div>
							<div>Lorem ipsum dolor sit amet, consectetur adipiscing
								elit. Pellentesque eleifend...</div>
					</a></li>
					<li class="divider"></li>
					<li><a href="#">
							<div>
								<strong>John Smith</strong> <span class="pull-right text-muted">
									<em>Yesterday</em>
								</span>
							</div>
							<div>Lorem ipsum dolor sit amet, consectetur adipiscing
								elit. Pellentesque eleifend...</div>
					</a></li>
					<li class="divider"></li>
					<li><a href="#">
							<div>
								<strong>John Smith</strong> <span class="pull-right text-muted">
									<em>Yesterday</em>
								</span>
							</div>
							<div>Lorem ipsum dolor sit amet, consectetur adipiscing
								elit. Pellentesque eleifend...</div>
					</a></li>
					<li class="divider"></li>
					<li><a class="text-center" href="#"> <strong>Read
								All Messages</strong> <i class="fa fa-angle-right"></i>
					</a></li>
				</ul> <!-- /.dropdown-messages --></li>
			<!-- /.dropdown -->
			<li class="dropdown"><a class="dropdown-toggle"
				data-toggle="dropdown" href="#"> <i class="fa fa-tasks fa-fw"></i>
					<i class="fa fa-caret-down"></i>
			</a>
				<ul class="dropdown-menu dropdown-tasks">
					<li><a href="#">
							<div>
								<p>
									<strong>Task 1</strong> <span class="pull-right text-muted">40%
										Complete</span>
								</p>
								<div class="progress progress-striped active">
									<div class="progress-bar progress-bar-success"
										role="progressbar" aria-valuenow="40" aria-valuemin="0"
										aria-valuemax="100" style="width: 40%">
										<span class="sr-only">40% Complete (success)</span>
									</div>
								</div>
							</div>
					</a></li>
					<li class="divider"></li>
					<li><a href="#">
							<div>
								<p>
									<strong>Task 2</strong> <span class="pull-right text-muted">20%
										Complete</span>
								</p>
								<div class="progress progress-striped active">
									<div class="progress-bar progress-bar-info" role="progressbar"
										aria-valuenow="20" aria-valuemin="0" aria-valuemax="100"
										style="width: 20%">
										<span class="sr-only">20% Complete</span>
									</div>
								</div>
							</div>
					</a></li>
					<li class="divider"></li>
					<li><a href="#">
							<div>
								<p>
									<strong>Task 3</strong> <span class="pull-right text-muted">60%
										Complete</span>
								</p>
								<div class="progress progress-striped active">
									<div class="progress-bar progress-bar-warning"
										role="progressbar" aria-valuenow="60" aria-valuemin="0"
										aria-valuemax="100" style="width: 60%">
										<span class="sr-only">60% Complete (warning)</span>
									</div>
								</div>
							</div>
					</a></li>
					<li class="divider"></li>
					<li><a href="#">
							<div>
								<p>
									<strong>Task 4</strong> <span class="pull-right text-muted">80%
										Complete</span>
								</p>
								<div class="progress progress-striped active">
									<div class="progress-bar progress-bar-danger"
										role="progressbar" aria-valuenow="80" aria-valuemin="0"
										aria-valuemax="100" style="width: 80%">
										<span class="sr-only">80% Complete (danger)</span>
									</div>
								</div>
							</div>
					</a></li>
					<li class="divider"></li>
					<li><a class="text-center" href="#"> <strong>See
								All Tasks</strong> <i class="fa fa-angle-right"></i>
					</a></li>
				</ul> <!-- /.dropdown-tasks --></li>
			<!-- /.dropdown -->
			<li class="dropdown"><a class="dropdown-toggle"
				data-toggle="dropdown" href="#"> <i class="fa fa-bell fa-fw"></i>
					<i class="fa fa-caret-down"></i>
			</a>
				<ul class="dropdown-menu dropdown-alerts">
					<li><a href="#">
							<div>
								<i class="fa fa-comment fa-fw"></i> New Comment <span
									class="pull-right text-muted small">4 minutes ago</span>
							</div>
					</a></li>
					<li class="divider"></li>
					<li><a href="#">
							<div>
								<i class="fa fa-twitter fa-fw"></i> 3 New Followers <span
									class="pull-right text-muted small">12 minutes ago</span>
							</div>
					</a></li>
					<li class="divider"></li>
					<li><a href="#">
							<div>
								<i class="fa fa-envelope fa-fw"></i> Message Sent <span
									class="pull-right text-muted small">4 minutes ago</span>
							</div>
					</a></li>
					<li class="divider"></li>
					<li><a href="#">
							<div>
								<i class="fa fa-tasks fa-fw"></i> New Task <span
									class="pull-right text-muted small">4 minutes ago</span>
							</div>
					</a></li>
					<li class="divider"></li>
					<li><a href="#">
							<div>
								<i class="fa fa-upload fa-fw"></i> Server Rebooted <span
									class="pull-right text-muted small">4 minutes ago</span>
							</div>
					</a></li>
					<li class="divider"></li>
					<li><a class="text-center" href="#"> <strong>See
								All Alerts</strong> <i class="fa fa-angle-right"></i>
					</a></li>
				</ul> <!-- /.dropdown-alerts --></li>
			<!-- /.dropdown -->
			<li class="dropdown"><a class="dropdown-toggle"
				data-toggle="dropdown" href="#"> <i class="fa fa-user fa-fw"></i>
					<i class="fa fa-caret-down"></i>
			</a>
				<ul class="dropdown-menu dropdown-user">
					<li><a href="#"><i class="fa fa-user fa-fw"></i> User
							Profile</a></li>
					<li><a href="#"><i class="fa fa-gear fa-fw"></i> Settings</a>
					</li>
					<li class="divider"></li>
					<li><a href="login.html"><i class="fa fa-sign-out fa-fw"></i>
							Logout</a></li>
				</ul> <!-- /.dropdown-user --></li>
			<!-- /.dropdown -->
		</ul>
		<!-- /.navbar-top-links -->

		<%@include file="../main/sideNav.jsp" %>
		<!-- /.navbar-static-side -->
	</nav>
	<div id="page-wrapper">
		<div class="row">
			<div class="col-lg-6">
				<h1 class="page-header">등록사원</h1>
			</div>
			<!-- /.col-lg-6 -->
			<div class="col-lg-6">
				<h1 class="page-header">사원등록</h1>
			</div>
			<!-- /.col-lg-6 -->
		</div>
		<div class="row">
			<div class="col-lg-6">
				<div class="panel panel-default">
					<div class="panel-heading">등록된 사원을 확인 할 수 있습니다.</div>
					<!-- /.panel-heading -->
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
						<!-- /.table-responsive -->
					</div>
					<!-- /.panel-body -->
				</div>
				<!-- /.panel -->
			</div>
			<!-- /.col-lg-6 -->
			<div class="col-lg-6">
				<div class="panel panel-default">
					<div class="panel-heading">간단한 사원 정보를 입력합니다.</div>
					<div class="panel-body">
						<div class="row">
							<div class="col-lg-12">
								<form role="form" method="POST" action="./employeeRegistServlet">
									<input type="hidden" name="companyCode"
										value="<%=companyCont.getCompanyCode()%>">
									<table class="table table-striped">
										<tr>
											<td style="text-align: right;">사원 ID</td>
											<td><input type="text" id="userID" name="userID"></td>
											<td><button class="btn btn-default" id="findUserButton" type="button"><i class="fa fa-search-plus"></i></button></td>
											<td></td>
										</tr>
										<tr>
											<td style="text-align: right;">사원번호</td>
											<td colspan="2"><input type="text" name="employeeNum"></td>
											<td></td>
										</tr>
										<tr>
                            				<td style="text-align: right;">사업장</td>
                            				<td><input id="placeCode" type="text" name="placeCode" readonly></td>
                            				<td style="text-align: left;"><button class="btn btn-default" id="findPlaceButton" type="button"><i class="fa fa-search-plus "></i></button></td>
                            				<td><input id="placeName" type="text" readonly></td>
                            			</tr>
                            			<tr>
                            				<td style="text-align: right;">부서</td>
                            				<td><input id="departmentCode" type="text" name="departmentCode" readonly><input id="fieldCode" type="hidden" name="fieldCode"></td>
                            				<td style="text-align: left;"><button class="btn btn-default" id="findDeptButton" type="button"><i class="fa fa-search-plus "></i></button></td>
                            				<td><input id="departmentName" type="text" readonly></td>
                            			</tr>
                            			<tr>
											<td style="text-align: right;">입사일</td>
											<td colspan="2"><input id="joinDate" type="date" placeholder="YYYY-MM-DD" name="joinDate"></td>
											<td></td>
										</tr>
									</table>
									<button class="btn btn-outline btn-primary btn-lg btn-block" type="submit">등록</button>
								</form>
							</div>
							<!-- /.col-lg-12 (nested) -->
						</div>
						<!-- /.row (nested) -->
					</div>
					<!-- /.panel-body -->
				</div>
				<!-- /.panel -->
			</div>
			<!-- /.col-lg-6 -->
		</div>
		<!-- /.row -->
	</div>
	<!-- Modal -->
	<!-- 유저 검색 -->
	<div class="modal fade" id="findUser" tabindex="-1" role="dialog"
		aria-labelledby="findUserLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
			</div>
			<!-- /.modal-content -->
		</div>
	</div>
	<!-- 사업장 검색 -->
	<div class="modal fade" id="findPlace" tabindex="-1" role="dialog"
		aria-labelledby="findPlaceLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
			</div>
			<!-- /.modal-content -->
		</div>
	</div>
	<!-- 부서 검색 -->
	<div class="modal fade" id="findDept" tabindex="-1" role="dialog"
		aria-labelledby="findDeptLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal-dialog -->
	</div>
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
</body>
</html>