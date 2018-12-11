<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO"%>
<%@ page import="businesstype.BusinessTypeDAO"%>
<%@ page import="businesstype.BusinessTypeDTO"%>
<%@ page import="placebusiness.PlaceBusinessDAO"%>
<%@ page import="placebusiness.PlaceBusinessDTO"%>
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
	ArrayList<String[]> businessConditionList = new BusinessTypeDAO().searchCondition();
	CompanyDTO companyCont = new CompanyDAO().getCompanyToID(userID);
	ArrayList<PlaceBusinessDTO> placeList = new PlaceBusinessDAO().getPlaceList(companyCont.getCompanyCode());
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

<!-- 주소검색 스크립트 -->
<script type="text/javascript"
	src="//ajax.googleapis.com/ajax/libs/jquery/1/jquery.min.js"
	charset="UTF-8"></script>
<script type="text/javascript" src="../js/searchAdd.js" charset="UTF-8"></script>

<script>
	/* 본점으로 등록 버튼 */
	function registHead() {
		var businessLicenseNum = encodeURIComponent('<%=companyCont.getBusinessLicenseNum()%>');
		var companyName = encodeURIComponent('<%=companyCont.getCompanyName()%>');
		var postNum = encodeURIComponent('<%=companyCont.getPostNum()%>'); 
		var address = encodeURIComponent('<%=companyCont.getAddress()%>'); 
		var tel = encodeURIComponent('<%=companyCont.getTel()%>');
		var businessCondition = encodeURIComponent('<%=companyCont.getBusinessCondition()%>'); 
		var businessType = encodeURIComponent('<%=companyCont.getBusinessType()%>');
		var establishmentDate = encodeURIComponent('<%=companyCont.getEstablishmentDate()%>'); 
		var startDate = encodeURIComponent('<%=companyCont.getStartDate()%>');
		$.ajax({
			type : 'POST',
			url : './businessTypeGetNameServlet',
			data : {
				businessCondition : businessCondition,
				businessType : businessType
			},
			success : function(data) {
				if(data == "") return;
				var parsed = JSON.parse(data);
				var result = parsed.result;
				$('#businessConditionName').attr('value', result[0].value);
				$('#businessTypeName').attr('value', result[1].value);
			}
		});
		$('#businessLicenseNum').attr('value',
				decodeURIComponent(businessLicenseNum));
		$('#companyName').attr('value', decodeURIComponent(companyName));
		$('#postNum').attr('value', decodeURIComponent(postNum));
		$('#address').attr('value', decodeURIComponent(address));
		$('#tel').attr('value', decodeURIComponent(tel));
		$('#businessCondition').attr('value',
				decodeURIComponent(businessCondition));
		$('#businessType').attr('value', decodeURIComponent(businessType));
		$('#establishmentDate').attr('value',
				decodeURIComponent(establishmentDate));
		$('#startDate').attr('value', decodeURIComponent(startDate));
	}
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
				if(data == "") return;
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
			<div class="col-lg-6">
				<h1 class="page-header">등록사업장</h1>
			</div>
			<div class="col-lg-6">
				<h1 class="page-header">사업장등록</h1>
			</div>
			<!-- /.col-lg-12 -->
		</div>
		<div class="row">
			<div class="col-lg-6">
				<div class="panel panel-default">
					<div class="panel-heading">등록된 사업장을 확인 할 수 있습니다.</div>
					<!-- /.panel-heading -->
					<div class="panel-body">
						<table width="100%"
							class="table table-striped table-bordered table-hover"
							id="dataTables-example">
							<thead>
								<tr>
									<th>사업장 코드</th>
									<th>사업장명</th>
									<th>대표자</th>
									<th>업태</th>
									<th>종목</th>
								</tr>
							</thead>
							<tbody>
								<%
									if(placeList != null) {
										for(int i = 0; i < placeList.size(); i++) {
											PlaceBusinessDTO place = placeList.get(i);
											BusinessTypeDTO businessConType = new BusinessTypeDAO().getBusinessType(place.getBusinessCondition(), place.getBusinessType());
											String chiefName = new UserDAO().findUserName(place.getChiefID());
								%>
								<tr class="odd gradeX">
									<td class="center"><%= place.getPlaceCode() %></td>
									<td class="center"><%= place.getCompanyName() %></td>
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
						<!-- /.table-responsive -->
					</div>
					<!-- /.panel-body -->
				</div>
				<!-- /.panel -->
			</div>
			<!-- /.col-lg-6 -->
			<div>
				<form class="row" role="form" method="POST"
					action="./placeBusinessRegisterServlet">
					<div class="col-lg-6">
						<div class="panel panel-default">
							<div class="panel-heading">
								본점을 등록 하실 때는 '본점으로 등록' 버튼을 클릭하시면 편리합니다.
								<button type="button" class="btn btn-outline btn-default"
									onclick="registHead();">본점으로 등록</button>
							</div>
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
												<td style="text-align: right;">회사코드</td>
												<td colspan="2"><input id="companyCode" type="text" name="companyCode" value="<%=companyCont.getCompanyCode()%>" readonly></td>
												<td></td>
											</tr>
											<tr>
												<td style="text-align: right;">사업장 코드</td>
												<td colspan="2"><input type="text" name="placeCode"></td>
												<td></td>
											</tr>
											<tr>
												<td style="text-align: right;">사업자 등록번호</td>
												<td colspan="2"><input id="businessLicenseNum" type="text" name="businessLicenseNum" placeholder="'-'을 제외하고 입력하세요."></td>
												<td></td>
											</tr>
											<tr>
												<td style="text-align: right;">사업장명</td>
												<td colspan="2"><input id="companyName" type="text" name="companyName"></td>
												<td></td>
											</tr>
											<tr>
												<td style="text-align: right;">사업장 우편 번호</td>
												<td><input type="text" maxlength="5" id="postNum" name="postNum" style="width: 20%"></td>
												<td><button class="btn btn-default" type="button" data-toggle="modal" data-target="#searchAddress"><i class="fa fa-search-plus"></i></button></td>
												<td></td>
											</tr>
											<tr>
												<td style="text-align: right;">사업장 주소</td>
												<td colspan="3"><input type="text" id="address" name="address" style="width: 85%"></td>
											</tr>
											<tr>
												<td style="text-align: right;">사업장 전화번호</td>
												<td colspan="2"><input type="text" name="tel"></td>
												<td></td>
											</tr>
											<tr>
                            					<td style="text-align: right;">업태</td>
                            					<td><input id="businessCondition" type="text" name="businessCondition" readonly></td>
                            					<td style="text-align: left;"><button class="btn btn-default" data-toggle="modal" data-target="#business" type="button"><i class="fa fa-search-plus "></i></button></td>
                            					<td><input id="businessConditionName" type="text" readonly></td>
                            				</tr>
                            				<tr>
                            					<td style="text-align: right;">종목</td>
                            					<td><input id="businessType" type="text" name="businessType" readonly></td>
                            					<td style="text-align: left;"></td>
                            					<td><input id="businessTypeName" type="text" readonly></td>
                            				</tr>
                            				<tr>
                            					<td style="text-align: right;">설립연월일</td>
                            					<td><input type="date" placeholder="YYYY-MM-DD" name="establishmentDate"></td>
                            					<td style="text-align: right;">개업연월일</td>
                            					<td><input type="date" placeholder="YYYY-MM-DD" name="startDate"></td>
                            				</tr>
                            				<tr>
                            					<td style="text-align: right;">관할 세무서</td>
                            					<td><input id="taxOfiice" type="text" name="taxOfiice" readonly value="needSetting"></td>
                            					<td style="text-align: left;"><button class="btn btn-default" data-toggle="modal" data-target="#searchTaxOfiice" type="button"><i class="fa fa-search-plus "></i></button></td>
                            					<td><input id="taxOfiiceName" type="text" readonly></td>
                            				</tr>
                            				<tr>
                            					<td style="text-align: right;">본점여부</td>
                            					<td><input type="radio" name="headBoolean" value="true" checked>여</td>
                            					<td><input type="radio" name="headBoolean" value="false">부</td>
                            					<td></td>
                            				</tr>
										</table>
									</div>
									<div class="tab-pane fade" id="addSession">
										<table class="table table-striped">
											<tr>
												<td style="text-align: right;">법인 등록번호</td>
												<td colspan="2"><input type="text" name="corporateLicenseNum" placeholder="'-'을 제외하고 입력하세요."></td>
												<td></td>
											</tr>
											<tr>
												<td style="text-align: right;">회사 영문명</td>
												<td colspan="2"><input type="text" name="companyEngName"></td>
												<td></td>
											</tr>
											<tr>
												<td style="text-align: right;">회사 영문주소</td>
												<td colspan="3"><input type="text" name="addressEng" style="width: 85%"></td>
											</tr>
											<tr>
												<td style="text-align: right;">회사 팩스번호</td>
												<td colspan="2"><input type="text" name="fax"></td>
												<td></td>
											</tr>
											<tr>
												<td style="text-align: right;">회사 홈페이지</td>
												<td colspan="3"><input type="text" name="homepage" style="width: 70%"></td>
											</tr>
											<tr>
                            					<td style="text-align: right;">환종</td>
                            					<td colspan="2">
                            						<select style="width: 30%; height: 25px;" name="monetaryUnit">
														<option value="KRW">￦ KRW</option>
														<option value="USD">$ USD</option>
														<option value="JPY">￥ JPY</option>
														<option value="CNY">元 CNY</option>
														<option value="EUR">€ EUR</option>
													</select>
                            					</td>
                            					<td><p class="help-block">선택하지 않으면 KRW로 등록됩니다.</p></td>
                            				</tr>
										</table>
									</div>
									<!-- /.col-lg-6 (nested) -->
								</div>
								<button class="btn btn-outline btn-primary btn-lg btn-block" type="submit">등록</button>
							</div>
							<!-- /.panel-body -->
						</div>
						<!-- /.panel -->
					</div>
					<!-- /.col-lg-12 -->
				</form>
			</div>
		</div>
		<!-- /.row -->
	</div>
	<!-- Modal -->
	<!-- 주소 검색 -->
	<div class="modal fade" id="searchAddress" tabindex="-1" role="dialog"
		aria-labelledby="searchAddressLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">&times;</button>
					<h4 class="modal-title" id="searchAddressLabel">주소 검색</h4>
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
	<!-- 업태/종목 검색 -->
	<div class="modal fade" id="business" tabindex="-1" role="dialog"
		aria-labelledby="businessLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">&times;</button>
					<h4 class="modal-title" id="businessLabel">업태/종목 선택</h4>
				</div>
				<div class="modal-body">
					<div class="form-group">
						<label>업태</label> <select class="form-control"
							name="conditionSelect" id="conditionSelect">
							<%
								for (int i = 0; i < businessConditionList.size(); i++) {
							%>
							<option value="<%=businessConditionList.get(i)[0]%>"><%=businessConditionList.get(i)[1]%></option>
							<%
								}
							%>
						</select>
					</div>
					<div class="form-group float-right">
						<button type="button" class="btn btn-default"
							onclick="printType();">검색</button>
					</div>
					<div class="form-group">
						<label>종목</label> <select class="form-control" name="typeSelect"
							id="typeSelect">

						</select>
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
					<button type="button" class="btn btn-primary"
						onclick="insertConTypeFunction();" data-dismiss="modal">확인</button>
				</div>
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal-dialog -->
	</div>
	<!-- 설립연월일 검색 -->
	<div class="modal fade" id="searchEstablishmentDate" tabindex="-1"
		role="dialog" aria-labelledby="searchEstablishmentDateLabel"
		aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">&times;</button>
					<h4 class="modal-title" id="searchEstablishmentDateLabel">Modal
						title</h4>
				</div>
				<div class="modal-body"></div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
					<button type="button" class="btn btn-primary">Save changes</button>
				</div>
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal-dialog -->
	</div>
	<!-- 개엽연월일 검색 -->
	<div class="modal fade" id="searchStartDate" tabindex="-1"
		role="dialog" aria-labelledby="searchStartDateLabel"
		aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">&times;</button>
					<h4 class="modal-title" id="searchStartDateLabel">Modal title</h4>
				</div>
				<div class="modal-body"></div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
					<button type="button" class="btn btn-primary">Save changes</button>
				</div>
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal-dialog -->
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