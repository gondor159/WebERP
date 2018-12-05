package ex;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/서블릿 URL 패턴")
public class 서블릿명 extends HttpServlet {
	private static final long serialVersionUID = 1L;
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request,response);
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		/* ENCODING */
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");

		/* PARAMETER SETTING */
		String 변수명 = request.getParameter("파라미터명");
		...
		
		/* 파라미터 검증 */
		if(변수명 == null || 변수명.equals("") || 변수명 == null || 변수명.equals("") || ...) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('내용');");
			script.println("history.back();");
			script.println("</script>");
			script.close();
			return;
		}
		
		/* 필요시 추가 파라미터 검증 */
		if(조건) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('내용');");
			script.println("history.back();");		// 또는 location.href = '이동할 url';
			script.println("</script>");
			script.close();
			return;
		}
		
		/* DATA ACCESS */
		변수타입 결과변수명(대체로 result 사용) = new DAO객체().메서드(파라미터[, 파라미터, ..., 파라미터]);
		
		/* DATA ACCESS 결과에 따른 if문 */
		if(결과변수명 == 결과값) {
			//세션설정(필요시)
			request.getSession().setAttribute("세션명", 세션값);
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("location.href = '이동할 url'");
			script.println("</script>");
			script.close();
			return;
		} else if(결과변수명 == 결과값) [또는 else] {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('내용');");
			script.println("history.back();");		// 또는 location.href = '이동할 url';
			script.println("</script>");
			script.close();
			return;
		}
	}

}