<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="rights.RightsDAO"%>
<%@ page import="rights.RightsDTO"%>
<%@ page import="java.util.ArrayList"%>
<!DOCTYPE html>
<html>
<%
	ArrayList<RightsDTO> list = new RightsDAO().getRightsList();
%>
<head>
<meta charset="UTF-8">
<title>Rights DB controller</title>

<!-- CSS -->
	<!-- Bootstrap Core CSS -->
	<link href="../vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
	<!-- MetisMenu CSS -->
	<link href="../vendor/metisMenu/metisMenu.min.css" rel="stylesheet">
	<!-- Custom CSS -->
	<link href="../dist/css/sb-admin-2.css" rel="stylesheet">
	<!-- Custom Fonts -->
	<link href="../vendor/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">
<!-- /CSS -->

</head>
<body>
	<div id="wrapper">
		<nav class="navbar navbar-default navbar-static-top" role="navigation" style="margin-bottom: 0">
			<div class="navbar-default sidebar" role="navigation">
				<div class="sidebar-nav navbar-collapse">
					<ul class="nav" id="side-menu">
						<li><a href="menu.jsp"><i class="fa fa-th-list fa-fw"></i> 메뉴</a></li>
						<li>
							<a href="#"><i class="fa fa-table fa-fw"></i> Data Base<span class="fa arrow"></span></a>
							<ul class="nav nav-second-level">
								<li><a href="dbFinancialInstitution.jsp">FinancialInstitution</a></li>
								<li><a href="dbBusinessType.jsp">BusinessType</a></li>
								<li><a href="dbRights.jsp">Rights</a></li>
							</ul>
						</li>
					</ul>
				</div>
			</div>
		</nav>
		<div id="page-wrapper">
			<div class="row">
				<div class="col-lg-12">
					<h1 class="page-header">Rights DB controller</h1>
				</div>
			</div>
			<div class="row">
				<div class="col-lg-4">
					<form class="panel panel-primary" method="POST" action="./rightsInsertServlet">
						<div class="panel-heading" style="text-align: center;">
							<h4>Insert Query</h4>
						</div>
						<div class="panel-body">
							<table class="table table-bordered" style="text-align: center;">
								<tr>
									<td><h5>권한코드</h5></td>
									<td><input class="form-control" type="text" name="rightsCode"></td>
								</tr>
								<tr>
									<td><h5>권한이름</h5></td>
									<td><input class="form-control" type="text" name="rightsName"></td>
								</tr>
							</table>
						</div>
						<div class="panel-footer">
							<button class="btn btn-primary btn-block" type="submit">Insert</button>
						</div>
					</form>
				</div>
				<div class="col-lg-4">
					<form class="panel panel-yellow" method="POST" action="./rightsUpdateServlet">
						<div class="panel-heading" style="text-align: center;">
							<h4>Update Query</h4>
						</div>
						<div class="panel-body">
							<table class="table table-bordered" style="text-align: center;">
								<tr>
									<td><h5>수정할 권한코드</h5></td>
									<td><input class="form-control" type="text" name="editRightsCode"></td>
								</tr>
								<tr>
									<td><h5>권한코em</h5></td>
									<td><input class="form-control" type="text" name="rightsCode"></td>
								</tr>
								<tr>
									<td><h5>권한이름</h5></td>
									<td><input class="form-control" type="text" name="rightsName"></td>
								</tr>
							</table>
						</div>
						<div class="panel-footer">
							<button class="btn btn-warning btn-block" type="submit">Update</button>
						</div>
					</form>
				</div>
				<div class="col-lg-4">
					<form class="panel panel-red" method="POST" action="./rightsDeleteServlet">
						<div class="panel-heading" style="text-align: center;">
							<h4>Delete Query</h4>
						</div>
						<div class="panel-body">
							<table class="table table-bordered" style="text-align: center;">
								<tr>
									<td><h5>권한코드</h5></td>
									<td><input class="form-control" type="text" name="rightsCode"></td>
								</tr>
							</table>
						</div>
						<div class="panel-footer">
							<button class="btn btn-danger btn-block" type="submit">Delete</button>
						</div>
					</form>
				</div>
			</div>
			<div class="row">
				<div class="col-lg-3"></div>
				<div class="col-lg-6">
					<table class="table table-bordered" style="text-align: center;">
						<thead>
							<tr>
								<th><h4>권한코드</h4></th>
								<th><h4>권한이름</h4></th>
							</tr>
						</thead>
						<tbody>
							<%
								if (list != null) {
									for (int i = 0; i < list.size(); i++) {
										RightsDTO dto = list.get(i);
							%>
							<tr>
								<td><h5><%=dto.getRightsCode()%></h5></td>
								<td><h5><%=dto.getRightsName()%></h5></td>
							</tr>
							<%
									}
								}
							%>
						</tbody>
					</table>
				</div>
				<div class="col-lg-3"></div>
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
	<!-- Custom Theme JavaScript -->
	<script src="../dist/js/sb-admin-2.js"></script>
<!-- /JavaScript -->

</body>
</html>