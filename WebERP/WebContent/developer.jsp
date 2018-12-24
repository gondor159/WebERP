<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>WebERP</title>

<!-- CSS -->
	<!-- Bootstrap Core CSS -->
	<link href="vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
	<!-- MetisMenu CSS -->
	<link href="vendor/metisMenu/metisMenu.min.css" rel="stylesheet">
	<!-- Custom CSS -->
	<link href="dist/css/sb-admin-2.css" rel="stylesheet">
	<!-- Custom Fonts -->
	<link href="vendor/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">
<!-- /CSS -->

</head>
<body>
	<div class="container">
		<div class="row">
			<div class="col-md-4 col-md-offset-4">
				<div class="login-panel panel panel-default">
					<div class="panel-heading">
						<h3 class="panel-title">개발자 인증번호를 입력하세요.</h3>
					</div>
					<div class="panel-body">
						<form method="POST" action="./userDeveloperServlet">
							<div class="form-group input-group">
								<input class="form-control" type="password" name="developerPass">
								<span class="input-group-btn">
									<button class="btn btn-default" type="submit">
										<i class="fa fa-key"></i>
									</button>
								</span>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
	
<!-- JavaScript -->
	<!-- jQuery -->
	<script src="vendor/jquery/jquery.min.js"></script>
	<!-- Bootstrap Core JavaScript -->
	<script src="vendor/bootstrap/js/bootstrap.min.js"></script>
	<!-- Metis Menu Plugin JavaScript -->
	<script src="vendor/metisMenu/metisMenu.min.js"></script>
	<!-- Custom Theme JavaScript -->
	<script src="dist/js/sb-admin-2.js"></script>
<!-- /JavaScript -->
</body>
</html>