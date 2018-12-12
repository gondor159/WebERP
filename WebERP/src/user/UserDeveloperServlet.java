package user;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/UserDeveloperServlet")
public class UserDeveloperServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		String developerPass = request.getParameter("developerPass");
		if(developerPass == null || developerPass.equals("")) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('인증번호를 입력하세요.')");
			script.println("history.back();");
			script.println("</script>");
			script.close();
			return;
		}
		if(developerPass.equals("studioour")) {
			request.getSession().setAttribute("developerPass", developerPass);
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("location.href = 'developer/menu.jsp';");
			script.println("</script>");
			script.close();
			return;
		} else {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('인증번호가 일치하지 않습니다.')");
			script.println("history.back();");
			script.println("</script>");
			script.close();
			return;
		}
	}

}
