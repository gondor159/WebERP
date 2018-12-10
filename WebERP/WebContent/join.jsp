<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<!DOCTYPE html>
<%
	String userID = null;
	if (request.getParameter("userID") != null) {
		userID = (String) request.getParameter("userID");
	}
	if (userID != null) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('이미 로그인 상태입니다.');");
		script.println("location.href = 'index.jsp';");
		script.println("</script>");
		script.close();
		return;
	}
%>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="">
<meta name="author" content="">

<title>WebERP</title>

<!-- Bootstrap Core CSS -->
<link href="vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">

<!-- MetisMenu CSS -->
<link href="vendor/metisMenu/metisMenu.min.css" rel="stylesheet">

<!-- Custom CSS -->
<link href="dist/css/sb-admin-2.css" rel="stylesheet">

<!-- Custom Fonts -->
<link href="vendor/font-awesome/css/font-awesome.min.css"
	rel="stylesheet" type="text/css">

<!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
<!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
	
<script>
	/* 아이디 중복체크 */
	function userIdCheckFunction() {
		var userID = $('#userID').val();
		$.ajax({
			type : 'POST',
			url : './userIdCheckServlet',
			data : {
				userID : userID
			},
			success : function(result) {
				if (result == -11) {
					var txt = '아이디를 입력하세요.';
				} else if (result == 0) {
					var txt = '이미 사용중인 아이디입니다.';
					alert(txt);
				} else {
					var txt = '사용 가능한 아이디입니다.';
					alert(txt);
				}
			}
		});
	}
	/* 이름 주민번호 확인 */
	function nameCheckFunction() {
		var identityNumFront = $('#identityNumFront').val();
		var identityNumBack = $('#identityNumBack').val();
		var userNameCheck = $('#userNameCheck').val();
		$('#userName').attr('value', userNameCheck);
		$('#identityNum').attr('value', identityNumFront + identityNumBack);
	}
	/* 주소 등록 */
	function insertAddFunction() {
		var entry_postcode5 = $('#entry_postcode5').val();
		var entry_address = $('#entry_address').val();
		var entry_details = $('#entry_details').val();
		var entry_extra_info = $('#entry_extra_info').val();
		$('#postNum').attr('value', entry_postcode5);
		$('#address').attr('value', entry_address + entry_extra_info + " " + entry_details);
	}
</script>
<!-- 주소검색 script -->
<script type="text/javascript"
	src="//ajax.googleapis.com/ajax/libs/jquery/1/jquery.min.js"
	charset="UTF-8"></script>
<script type="text/javascript" src="js/searchAdd.js" charset="UTF-8"></script>
<!-- ./주소검색 script -->
</head>
<body>

	<div class="container">
		<div class="row">
			<div class="col-md-4 col-md-offset-4">
				<div class="login-panel panel panel-default">
					<div class="panel-heading">
						<h3 class="panel-title">Please Join us</h3>
					</div>
					<div class="panel-body">
						<form role="form" method="post" action="./userJoin">
							<fieldset>
								<div class="form-group input-group">
									<input type="text" class="form-control" id="userID"
										name="userID" placeholder="ID를 입력하세요."> <span
										class="input-group-btn">
										<button class="btn btn-default" type="button"
											onclick="userIdCheckFunction();">중복체크</button>
									</span>
								</div>
								<div class="form-group">
									<input class="form-control" placeholder="Password를 입력하세요."
										name="userPassword" type="password">
								</div>
								<div class="form-group">
									<input class="form-control" placeholder="Password를 한번 더 입력하세요."
										name="userPasswordRe" type="password">
								</div>
								<div class="form-group input-group">
									<input type="text" class="form-control" id="userName"
										name="userName" value="실명확인을 하세요." readonly> <span
										class="input-group-btn">
										<button class="btn btn-default" type="button"
											data-toggle="modal" data-target="#nameCheck">실명확인</button>
									</span> <input id="identityNum" name="identityNum" value=""
										type="hidden">
								</div>
								<div class="form-group">
									<input class="form-control" placeholder="영문 이름을 입력하세요."
										name="userEngName" type="text">
									<p class="help-block">여권상 영문이름을 입력하세요.</p>
								</div>
								<div class="form-group">
									<input class="form-control" placeholder="한문 이름을 입력하세요."
										name="userHanName" type="text">
								</div>
								<div class="form-group">
									<input class="form-control col-md-4" style="width: 85px;"
										placeholder="우편번호" id="postNum" name="postNum" type="text"
										readonly><input class="form-control"
										placeholder="주소를 입력하세요." id="address" name="address"
										type="text" readonly>
								</div>
								<div class="form-group">
									<button class="btn btn-primary btn-sm" type="button"
										data-toggle="modal" data-target="#searchAdd">주소 찾기</button>
								</div>
								<div class="form-group">
									<input class="form-control" placeholder="전화번호를 입력하세요."
										name="homeTel" type="text">
									<p class="help-block">'-'는 기입하지마세요.</p>
								</div>
								<div class="form-group">
									<input class="form-control" placeholder="휴대전화번호를 입력하세요."
										name="phoneNum" type="text">
									<p class="help-block">'-'는 기입하지마세요.</p>
								</div>
								<div class="form-group">
									<input class="form-control" placeholder="이메일을 입력하세요."
										name="email" type="email">
								</div>
								<!-- Change this to a button or input when using this as a form -->
								<button type="submit" class="btn btn-lg btn-success btn-block">가입</button>
							</fieldset>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- Modal -->
	<!-- 실명 확인 -->
	<div class="modal fade" id="nameCheck" tabindex="-1" role="dialog"
		aria-labelledby="nameCheckLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">&times;</button>
					<h4 class="modal-title" id="nameCheckLabel">실명확인</h4>
				</div>
				<div class="modal-body">
					<table width="100%"
						class="table table-striped table-bordered table-hover">
						<tr>
							<td><h5>이름</h5></td>
							<td colspan="3"><input class="form-control"
								id="userNameCheck" name="userNameCheck" type="text"></td>
						</tr>
						<tr>
							<td><h5>주민등록번호</h5></td>
							<td><input class="form-control" id="identityNumFront"
								name="identityNumFront" type="text"></td>
							<td><h5>-</h5></td>
							<td><input class="form-control" id="identityNumBack"
								name="identityNumBack" type="password"></td>
						</tr>
					</table>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
					<button type="button" class="btn btn-primary"
						onclick="nameCheckFunction();" data-dismiss="modal">확인</button>
				</div>
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal-dialog -->
	</div>
	<!-- 주소 검색 -->
	<div class="modal fade" id="searchAdd" tabindex="-1" role="dialog"
		aria-labelledby="searchAddLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">&times;</button>
					<h4 class="modal-title" id="searchAddLabel">주소 검색</h4>
				</div>
				<div class="modal-body">
					<div class="row" id="postcodify"></div>
					<!-- Postcodify 셋팅 -->

					<script type="text/javascript">
						$("#postcodify")
								.postcodify(
										{
											insertPostcode5 : "#entry_postcode5",
											insertAddress : "#entry_address",
											insertDetails : "#entry_details",
											insertExtraInfo : "#entry_extra_info",
											insertEnglishAddress : "#entry_english_address",
											insertJibeonAddress : "#entry_jibeon_address",
											useFullJibeon : true,
											mapLinkProvider : "google",
											ready : function() {
												$(
														"#postcodify div.postcode_search_status.empty")
														.hide();
											},
											beforeSearch : function(keywords) {
												$("#entry_box").hide();
											},
											afterSelect : function(
													selectedEntry) {
												$(
														"#postcodify div.postcode_search_result")
														.remove();
												$(
														"#postcodify div.postcode_search_status.summary")
														.hide();
												$("#entry_box").show();
												$("#entry_details").focus();
											}
										});
					</script>
					<div>
						<p>
							<label for="entry_postcode6">우편번호</label><input type="text"
								class="form-control" id="entry_postcode5" readonly>
						</p>
						<p>
							<label for="entry_address">도로명주소</label><input type="text"
								class="form-control" id="entry_address" readonly>
						</p>
						<p>
							<label for="entry_address">참고항목</label><input type="text"
								class="form-control" id="entry_extra_info" readonly>
						</p>
						<p>
							<label for="entry_details">상세주소</label><input type="text"
								class="form-control" id="entry_details" />
						</p>
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
					<button type="button" class="btn btn-primary"
						onclick="insertAddFunction();" data-dismiss="modal">확인</button>
				</div>
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal-dialog -->
	</div>
	<!-- jQuery -->
	<script src="vendor/jquery/jquery.min.js"></script>

	<!-- Bootstrap Core JavaScript -->
	<script src="vendor/bootstrap/js/bootstrap.min.js"></script>

	<!-- Metis Menu Plugin JavaScript -->
	<script src="vendor/metisMenu/metisMenu.min.js"></script>

	<!-- Custom Theme JavaScript -->
	<script src="dist/js/sb-admin-2.js"></script>
</body>
</html>