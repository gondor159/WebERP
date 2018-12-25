<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%
	String developerPass = null;
	if (session.getAttribute("developerPass") != null) {
		developerPass = (String) session.getAttribute("developerPass");
	}
	if (developerPass == null) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('개발자 인증이 필요합니다.')");
		script.println("location.href = '../developer.jsp'");
		script.println("</script>");
		return;
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Developer Menu</title>

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
<div class="navbar-header">
		<button type="button" class="navbar-toggle" data-toggle="collapse"
			data-target=".navbar-collapse">
			<span class="sr-only">WebERP</span> <span
				class="icon-bar"></span> <span class="icon-bar"></span> <span
				class="icon-bar"></span>
		</button>
		<a class="navbar-brand" href="../index.jsp">WebERP 개발자 페이지</a>
	</div>
	<!-- /.네비게이션 버튼 -->
	<ul class="nav navbar-top-links navbar-right">
		<li class="dropdown">
			<a class="dropdown-toggle" data-toggle="dropdown" href="#"> 
				<i class="fa fa-table fa-fw"></i>
				<i class="fa fa-caret-down"></i>
			</a>
			<ul class="dropdown-menu dropdown-messages">
				<li>
					<a href="dbBusinessType.jsp">
						<div>
							<strong>BusinessType DB</strong>
							<span class="pull-right text-muted">
								<em>업태/종목 테이블</em>
							</span>
						</div>
					</a>
				</li>
				<li class="divider"></li>
				<li>
					<a href="dbFinancialInstitution.jsp">
						<div>
							<strong>FinancialInstitution DB</strong>
							<span class="pull-right text-muted">
								<em>금융기관 테이블</em>
							</span>
						</div>
					</a>
				</li>
				<li class="divider"></li>
				<li>
					<a href="dbRights.jsp">
						<div>
							<strong>Rights DB</strong>
							<span class="pull-right text-muted">
								<em>권한 테이블</em>
							</span>
						</div>
					</a>
				</li>
			</ul>
		</li>
	</ul>

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