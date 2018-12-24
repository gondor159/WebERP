<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- 주소검색 스크립트 -->
<script type="text/javascript" src="//ajax.googleapis.com/ajax/libs/jquery/1/jquery.min.js" charset="UTF-8"></script>
<script type="text/javascript" src="../js/searchAdd.js" charset="UTF-8"></script>
</head>
<body>
	<div class="modal-header">
		<button type="button" class="close" data-dismiss="modal"
			aria-hidden="true">&times;</button>
		<h4 class="modal-title" id="searchAddressLabel">주소 검색</h4>
	</div>
	<div class="modal-body">
		<div class="row" id="postcodify"></div>
		<script type="text/javascript">
			$("#postcodify").postcodify({
				insertPostcode5 : "#nomal_postcode5",
				insertAddress : "#nomal_address",
				insertDetails : "#nomal_details",
				insertExtraInfo : "#nomal_extra_info",
				insertEnglishAddress : "#entry_english_address",
				insertJibeonAddress : "#entry_jibeon_address",
				useFullJibeon : true,
				mapLinkProvider : "google",
				ready : function() {
					$("#postcodify div.postcode_search_status.empty").hide();
				},
				beforeSearch : function(keywords) {
					$("#entry_box").hide();
				},
				afterSelect : function(selectedEntry) {
					$("#postcodify div.postcode_search_result").remove();
					$("#postcodify div.postcode_search_status.summary").hide();
					$("#entry_box").show();
					$("#entry_details").focus();
				}
			});
		</script>
		<div>
			<p>
				<label for="entry_postcode6">우편번호</label><input type="text"
					class="form-control" id="nomal_postcode5" readonly>
			</p>
			<p>
				<label for="entry_address">도로명주소</label><input type="text"
					class="form-control" id="nomal_address" readonly>
			</p>
			<p>
				<label for="entry_address">참고항목</label><input type="text"
					class="form-control" id="nomal_extra_info" readonly>
			</p>
			<p>
				<label for="entry_details">상세주소</label><input type="text"
					class="form-control" id="nomal_details" />
			</p>
		</div>
	</div>
	<div class="modal-footer">
		<button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
		<button type="button" class="btn btn-primary"
			onclick="insertAddFunction();" data-dismiss="modal">확인</button>
	</div>
</body>
</html>