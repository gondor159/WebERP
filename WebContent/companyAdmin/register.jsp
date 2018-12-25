<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO"%>
<%@ page import="businesstype.BusinessTypeDAO"%>
<%@ page import="businesstype.BusinessTypeDTO"%>
<%@ page import="company.CompanyDAO" %>
<%@ page import="company.CompanyDTO" %>
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
	ArrayList<String[]> businessConditionList = new BusinessTypeDAO().searchCondition();
	ArrayList<CompanyDTO> companyList = new CompanyDAO().getCompanyList();
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

<!-- function -->
<script>
	/* 주소 등록 */
	function insertAddFunction() {
		var entry_postcode5 = $('#entry_postcode5').val();
		var entry_address = $('#entry_address').val();
		var entry_details = $('#entry_details').val();
		var entry_extra_info = $('#entry_extra_info').val();
		$('#postNum').attr('value', entry_postcode5);
		$('#address').attr('value',
				entry_address + entry_extra_info + " " + entry_details);
	}
	/* 종목 선택 */
	function printType() {
		var businessCondition = $('#conditionSelect').val();
		$.ajax({
			type : 'POST',
			url : './searchTypeServlet',
			data : {
				businessCondition : businessCondition
			},
			success : function(data) {
				if (data == "")
					return;
				var parsed = JSON.parse(data);
				var result = parsed.result;
				$('.businessTypeClass').remove();
				for (var i = 0; i < result.length; i++) {
					addTypeSelect(result[i][0].value, result[i][1].value);
				}
			}
		});
	}
	function addTypeSelect(businessType, businessTypeName) {
		$('#typeSelect').append(
				'<option class="businessTypeClass" value="' + businessType + '">'
						+ businessTypeName + '</option>');
	}
	/* 업태 종목 등록 */
	function insertConTypeFunction() {
		var conditionSelect = $('#conditionSelect').val();
		var typeSelecet = $('#typeSelect').val();
		$.ajax({
			type : 'POST',
			url : './businessTypeGetNameServlet',
			data : {
				businessCondition : conditionSelect,
				businessType : typeSelecet
			},
			success : function(data) {
				if(data == "") return;
				var parsed = JSON.parse(data);
				var result = parsed.result;
				$('#businessConditionName').attr('value', result[0].value);
				$('#businessTypeName').attr('value', result[1].value);
			}
		});
		$('#businessCondition').attr('value', conditionSelect);
		$('#businessType').attr('value', typeSelecet);
	}
</script>

<!-- Button 활성화 -->
<script>
$(function(){
	/* 주소 검색 버튼 */
	$("#searchAddressBtn").click(function(){
		$('#searchAddress').modal({
			remote : 'modal/searchAddressModal.jsp'
		});
	})
	/* 업태 종목 검색 버튼 */
	$("#searchTypeBtn").click(function(){
		$('#searchType').modal({
			remote : 'modal/searchTypeModal.jsp'
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
				<h1 class="page-header">등록회사</h1>
				<div class="panel panel-default">
					<div class="panel-heading">등록된 회사를 확인 할 수 있습니다.</div>
					<!-- /.panel-heading -->
					<div class="panel-body">
						<table width="100%"
							class="table table-striped table-bordered table-hover"
							id="dataTables-example">
							<thead>
								<tr>
									<th>회사 코드</th>
									<th>회사명</th>
									<th>대표자</th>
									<th>업태</th>
									<th>종목</th>
								</tr>
							</thead>
							<tbody>
								<%
									if(companyList != null) {
										for(int i = 0; i < companyList.size(); i++) {
											CompanyDTO company = companyList.get(i);
											BusinessTypeDTO businessConType = new BusinessTypeDAO().getBusinessType(company.getBusinessCondition(), company.getBusinessType());
											String chiefName = new UserDAO().findUserName(company.getChiefID());
								%>
								<tr class="odd gradeX">
									<td class="center"><%= company.getCompanyCode() %></td>
									<td class="center"><%= company.getCompanyName() %></td>
									<td class="center"><%= chiefName %></td>
									<td class="center"><%= businessConType.getBusinessConditionName() %></td>
									<td class="center"><%= businessConType.getBusinessTypeName() %></td>
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
				<form class="row" role="form" method="POST" action="./companyRegisterServlet">
					<h1 class="page-header">회사등록</h1>
					<div class="col-lg-12">
						<div class="panel panel-default">
							<div class="panel-heading">회사코드는 업태와 종목을 통해 자동으로 생성 됩니다.</div>
							<div class="panel-body">
								<ul class="nav nav-tabs">
        							<li class="active"><a href="#baseSession" data-toggle="tab">필수 입력 사항</a>
        							</li>
        							<li><a href="#addSession" data-toggle="tab">추가 등록 사항</a>
        							</li>
        						</ul>
								<div class="tab-content">
									<div class="tab-pane fade in active" id="baseSession">
										<input type="hidden" name="chiefID" value="<%= userID %>"><br>
										<table class="table table-striped">
											<tr>
												<td style="text-align: right;"><h5>사업자 등록번호</h5></td>
												<td><input class="form-control" type="text" name="businessLicenseNum" placeholder="'-'을 제외하고 입력하세요."></td>
												<td colspan="2"></td>
											</tr>
											<tr>
												<td style="text-align: right;"><h5>회사명</h5></td>
												<td colspan="3"><input class="form-control" type="text" name="companyName"></td>
											</tr>
											<tr>
												<td style="text-align: right;"><h5>본점 우편 번호</h5></td>
												<td><input class="form-control" type="text" maxlength="5" id="postNum" name="postNum" readonly></td>
												<td><button class="btn btn-default" id="searchAddressBtn" type="button"><i class="fa fa-search-plus"></i></button></td>
												<td></td>
											</tr>
											<tr>
												<td style="text-align: right;"><h5>본점 주소</h5></td>
												<td colspan="3"><input class="form-control" type="text" id="address" name="address" readonly></td>
											</tr>
											<tr>
												<td style="text-align: right;"><h5>회사 전화번호</h5></td>
												<td><input class="form-control" type="text" name="tel"></td>
												<td colspan="2"></td>
											</tr>
											<tr>
                            					<td style="text-align: right;"><h5>업태</h5></td>
                            					<td><input class="form-control" id="businessCondition" type="text" name="businessCondition" readonly></td>
                            					<td style="text-align: left;"><button class="btn btn-default" id="searchTypeBtn" type="button"><i class="fa fa-search-plus "></i></button></td>
                            					<td><input class="form-control" id="businessConditionName" type="text" readonly></td>
                            				</tr>
                            				<tr>
                            					<td style="text-align: right;"><h5>종목</h5></td>
                            					<td><input class="form-control" id="businessType" type="text" name="businessType" readonly></td>
                            					<td style="text-align: left;"></td>
                            					<td><input class="form-control" id="businessTypeName" type="text" readonly></td>
                            				</tr>
                            				<tr>
                            					<td style="text-align: right;"><h5>설립연월일</h5></td>
                            					<td><input class="form-control" type="date" placeholder="YYYY-MM-DD" name="establishmentDate"></td>
                            					<td style="text-align: right;">개업연월일</td>
                            					<td><input class="form-control" type="date" placeholder="YYYY-MM-DD" name="startDate"></td>
                            				</tr>
										</table>
									</div>
									<div class="tab-pane fade" id="addSession">
										<table class="table table-striped">
											<tr>
												<td style="text-align: right;"><h5>법인 등록번호</h5></td>
												<td><input class="form-control" type="text" name="corporateLicenseNum" placeholder="'-'을 제외하고 입력하세요."></td>
												<td colspan="2"></td>
											</tr>
											<tr>
												<td style="text-align: right;"><h5>회사 영문명</h5></td>
												<td colspan="3"><input class="form-control" type="text" name="companyEngName"></td>
											</tr>
											<tr>
												<td style="text-align: right;"><h5>회사 영문주소</h5></td>
												<td colspan="3"><input class="form-control" type="text" name="addressEng"></td>
											</tr>
											<tr>
												<td style="text-align: right;"><h5>회사 팩스번호</h5></td>
												<td><input class="form-control" type="text" name="fax"></td>
												<td colspan="2"></td>
											</tr>
											<tr>
												<td style="text-align: right;"><h5>회사 홈페이지</h5></td>
												<td colspan="3"><input class="form-control" type="text" name="homepage"></td>
											</tr>
											<tr>
                            					<td style="text-align: right;"><h5>환종</h5></td>
                            					<td>
                            						<select class="form-control" name="monetaryUnit">
														<option value="KRW">￦ KRW</option>
														<option value="USD">$ USD</option>
														<option value="JPY">￥ JPY</option>
														<option value="CNY">元 CNY</option>
														<option value="EUR">€ EUR</option>
													</select>
                            					</td>
                            					<td colspan="2"><p class="help-block">선택하지 않으면 KRW로 등록됩니다.</p></td>
                            				</tr>
										</table>
									</div>
								</div>
								<button class="btn btn-outline btn-primary btn-lg btn-block" type="submit">등록</button>
							</div>
						</div>
					</div>
				</form>
			</div>
		</div>
	</div>
	<!-- Modal -->
	<!-- 주소 검색 -->
	<div class="modal fade" id="searchAddress" tabindex="-1" role="dialog"
		aria-labelledby="searchAddressLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
			</div>
		</div>
	</div>
	<!-- 업태/종목 검색 -->
	<div class="modal fade" id="searchType" tabindex="-1" role="dialog"
		aria-labelledby="searchTypeLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
			</div>
		</div>
	</div>
	<!-- 세무서 검색 -->
	<div class="modal fade" id="searchTaxOfiice" tabindex="-1"
		role="dialog" aria-labelledby="searchTaxOfiice" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">&times;</button>
					<h4 class="modal-title" id="searchTaxOfiice">Modal title</h4>
				</div>
				<div class="modal-body"></div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
					<button type="button" class="btn btn-primary">Save changes</button>
				</div>
			</div>
		</div>
	</div>
	<!-- 주민납세지 검색 -->
	<div class="modal fade" id="searchresidentPayment" tabindex="-1"
		role="dialog" aria-labelledby="searchresidentPaymentLabel"
		aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">&times;</button>
					<h4 class="modal-title" id="searchresidentPaymentLabel">Modal
						title</h4>
				</div>
				<div class="modal-body"></div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
					<button type="button" class="btn btn-primary">Save changes</button>
				</div>
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
<!-- JavaScript -->
</body>
</html>