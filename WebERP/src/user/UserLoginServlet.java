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
			script.println("alert('���̵� �Ǵ� ��й�ȣ�� �Է����� �ʾҽ��ϴ�.')");
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
			script.println("alert('��й�ȣ�� Ʋ�Ƚ��ϴ�.')");
			script.println("history.back();'");
			script.println("</script>");
			script.close();
			return;
		} else if(result == 0) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('�������� �ʴ� ���̵� �Դϴ�..')");
			script.println("history.back();'");
			script.println("</script>");
			script.close();
			return;
		} else if(result == -1) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('�˼��մϴ�. �����ͺ��̽� ������ �߻��߽��ϴ�. �ٽ� �õ��� �ּ���.')");
			script.println("history.back();'");
			script.println("</script>");
			script.close();
			return;
		}
	}

}
