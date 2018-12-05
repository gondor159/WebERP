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
    
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		/* ENCODING */
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		
		/* PARAMETER SETTING */
		String 변수명 = request.getParameter("파라미터명");
		...
		
		/* PARAMETER 검증 */
		if(변수명 == null || 변수명.equals("") || ...) response.getWriter().write("반환 값");
		
		/* 메서드 실행후 결과값 반환 */
		response.getWriter().write(new DAO객체().메서드(파라미터) + "");	// 결과값을 문자열(String)타입으로 반환 시키기 위해 공백문자열("")을 추가한다. 
	}
}