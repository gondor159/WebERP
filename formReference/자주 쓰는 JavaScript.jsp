<!-- jQuery 사용 -->
<script>
	/* 페이지 이동 */
	location.href = '경로';

	/* 페이지 새로고침 */
	window.location.reload();

	/* 지정한 위치의 value 값 가져오기 */
	var 변수명 = $('#이름').val();							// 지정한 위치를 id로 분류 할때 
	var 변수명 = $('.이름').val();							// 지정한 위치를 class로 분류 할때
	var 변수명 = $('input[name="이름"]:checked'). val();		// 가져오고자 하는 값이 select 태그형식인 경우

	/* 지정한 위치에 value 값 넣기 */
	$('지정한 위치').attr('value', 넣을 값);

	/* 지정한 위치에 HTML 소스 작성 */
	$('지정한 위치').append(HTML 소스);
	/*
	*	지정한 위치를 id 값으로 나타낼때는 '#이름'
	*	지정한 위치를 class 값으로 나타낼때는 '.이름'
	*/
	/* 또는 */
	$('지정한 위치').html(HTML 소스);

	/* AJAX */
	$.ajax({
		type : 'GET 또는 POST',
		url : 전송할 URL,
		data : {
			전송할파라미터명 : 전송할 변수 또는 값,
			...
			전송할파라미터명 : 전송할 변수 또는 값
		},
		success : function(반환받은 변수 혹은 값) {
			자바코드
		}
	});

	/* AJAX에서 반환된 값이 JSON 형식일 때 */
	$.ajax({
		type : 'GET 또는 POST',
		url : 전송할 URL,
		data : {
			전송할파라미터명 : 전송할 변수 또는 값,
			...
			전송할파라미터명 : 전송할 변수 또는 값
		},
		success : function(반환받은 변수 혹은 값[대체로 data사용]) {
			var parsed = JSON.parse(반환받은 변수 혹은 값);
			var result = parsed.result;		// JSON형식의 결과 값이 result에 담긴다. (배열 일 경우 result[].value 형식으로 사용가능)
			/* for문을 이용하여 배열을 사용할 때 */
			for (var i = 0; i < result.length; i++) {
				result[i].value;
			}
		}
	});

	/* 외부 JSP 파일을 팝업으로 열기 */
	function 함수명() {
		var 변수명 = 'width=0, height=0, left=0, top=0, toolbar=no, location=no, status=no, menubar=no, resizable=no, scrollbars=no';
		/*
		*	width : 팝업창 가로 길이
		*	height : 팝업창 세로 길이
		*	left : 팝업창이 화면 왼쪽에서부터 떨어지는 크기
		*	top : 팝업창이 화면 위쪽에서부터 떨어지는 크기
		*	toolbar : 툴바 생성 여부 (yes , no)
		*	location : 사이트 URL 표시 여부 (yes, no)
		*	status : 아래 상태표시줄 표시 여부 (yes, no)
		*	menubar : 메뉴바 표시 여부 (yes, no)
		*	resizable : 팝업창 크기 변경 여부 (yes, no)
		*	scrollbars : 스크롤바 생성 여부 (yes,no)
		*/
		windowObj = window.open("JSP파일명","팝업창이름", 변수명);
	}

	/* 부트스트랩 모달을 버튼 클릭으로 외부페이지 출력 */
	$(function() {
		$('#버튼의 id').click(function() {
			$('#모달창의 id').modal({
				remote : '출력할 파일명'
			});
		});
	});
</script>