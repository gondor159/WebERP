<%
	/* 세션 가져오기 */
	String 변수명 = null;	// null 또는 ""
	if (session.getAttribute("세션명") != null) {
		변수명 = (String) session.getAttribute("세션명");
	}

	/* 파라미터 가져오기 */ 
	String 변수명 = null;	// null 또는 ""
		if(request.getParameter("파라미터명") != null) {
			변수명 = request.getParameter("파라미터명");
		}

	/* 페이지 작성하기 */
	/*<%@ page import="java.java.io.PrintWriter %> 필요 */
	PrintWriter script = response.getWriter();
	script.println("<script>");		// 주로 <script></script> 또는 html태그 사용
	script.println("</script>");
	script.close();
	return;

	/* 모든 세션 삭제 */
	session.invalidate();
%>