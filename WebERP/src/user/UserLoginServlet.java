package user;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/UserLoginServlet")
public class UserLoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		String userID = request.getParameter("userID");
		String userPassword = request.getParameter("userPassword");
		if(userID == null || userID.equals("") || userPassword == null || userPassword.equals("")) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('아이디 또는 비밀번호를 입력하지 않았습니다.')");
			script.println("location.href = 'join.jsp'");
			script.println("</script>");
			script.close();
			return;
		}
		int result = new UserDAO().login(userID, userPassword);
		if(result == 1) {
			request.getSession().setAttribute("userID", userID);
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("location.href = 'index.jsp'");
			script.println("</script>");
			script.close();
			return;
		} else if(result == 2) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('비밀번호가 틀렸습니다.')");
			script.println("history.back();'");
			script.println("</script>");
			script.close();
			return;
		} else if(result == 0) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('존재하지 않는 아이디 입니다..')");
			script.println("history.back();'");
			script.println("</script>");
			script.close();
			return;
		} else if(result == -1) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('죄송합니다. 데이터베이스 오류가 발생했습니다. 다시 시도해 주세요.')");
			script.println("history.back();'");
			script.println("</script>");
			script.close();
			return;
		}
	}

}
