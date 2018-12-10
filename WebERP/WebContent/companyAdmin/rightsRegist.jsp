<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO"%>
<%@ page import="placebusiness.PlaceBusinessDAO"%>
<%@ page import="department.DepartmentDAO"%>
<%@ page import="employee.EmployeeDAO"%>
<%@ page import="employee.EmployeeDTO"%>
<%@ page import="company.CompanyDAO"%>
<%@ page import="company.CompanyDTO"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.io.PrintWriter"%>
<%
	String userID = null;
	if (session.getAttribute("userID") != null) {
		userID = (String) session.getAttribute("userID");
	}
	/*
	if (userID == null) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인이 필요합니다.')");
		script.println("location.href = '../login.jsp'");
		script.println("</script>");
		return;
	}
	*/
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
$(document).on("click",".settingID",function(){
	var companyCode = encodeURIComponent('<%=companyCont.getCompanyCode()%>');
	var settingID = $(this).attr('value');
	$('#settingRight').modal({
		remote : 'modal/settingRightModal.jsp?companyCode=' + companyCode + '&settingID=' + settingID
	});
 });
</script>
</head>
<body>
	<!-- Navigation -->
	<nav class="navbar navbar-default navbar-static-top" role="navigation"
		style="margin-bottom: 0">
		<%@include file="../main/headNav.jsp"%>
		<!-- /.navbar-top-links -->

		<%@include file="../main/sideNav.jsp" %>
		<!-- /.navbar-static-side -->
	</nav>
	<div id="page-wrapper">
		<div class="row">
			<div class="col-lg-12">
				<h1 class="page-header">사원 권한 관리</h1>
			</div>
			<!-- /.col-lg-12 -->
		</div>
		<div class="row">
			<div class="col-lg-12">
				<div class="panel panel-default">
					<div class="panel-heading">사원을 클릭하여 권한을 지정 할 수 있습니다.</div>
					<!-- /.panel-heading -->
					<div class="panel-body">
						<table width="100%"
							class="table table-striped table-bordered table-hover"
							id="dataTables-example">
							<thead>
								<tr>
									<th>사원 코드</th>
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
									<td class="center"><a class="settingID" style="text-decoration: none; color: black;" href="#" value="<%= employee.getUserID() %>"><%= employee.getEmployeeNum() %></a></td>
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
			<!-- /.col-lg-12 -->
		</div>
		<!-- /.row -->
	</div>
	<!-- Modal -->
	<!-- 권한 설정 -->
	<div class="modal fade" id="settingRight" tabindex="-1" role="dialog"
		aria-labelledby="settingRightLabel" aria-hidden="true">
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