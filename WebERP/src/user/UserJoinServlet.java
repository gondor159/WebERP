package user;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/UserJoinServlet")
public class UserJoinServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		String userID = request.getParameter("userID");
		String userPassword = request.getParameter("userPassword");
		String userPasswordRe = request.getParameter("userPasswordRe");
		String userName = request.getParameter("userName");
		String userEngName = request.getParameter("userEngName");
		String userHanName = request.getParameter("userHanName");
		String identityNum = request.getParameter("identityNum");
		String postNum = request.getParameter("postNum");
		String address = request.getParameter("address");
		String homeTel = request.getParameter("homeTel");
		String phoneNum = request.getParameter("phoneNum");
		String email = request.getParameter("email");
		if(userID == null || userID.equals("") || userPassword == null || userPassword.equals("")
				|| userPasswordRe == null || userPasswordRe.equals("") || userName == null || userName.equals("")
				|| userEngName == null || userEngName.equals("") || userHanName == null || userHanName.equals("")
				|| identityNum == null || identityNum.equals("") || postNum == null || postNum.equals("")
				|| address == null || address.equals("") || homeTel == null || homeTel.equals("") || phoneNum == null
				|| phoneNum.equals("") || email == null || email.equals("")) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('모든 내용을 입력하세요.')");
			script.println("location.href = 'join.jsp'");
			script.println("</script>");
			script.close();
			return;
		}
		if(!userPassword.equals(userPasswordRe)) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('비밀번호를 확인하세요.')");
			script.println("location.href = 'join.jsp'");
			script.println("</script>");
			script.close();
			return;
		}
		int result = new UserDAO().join(userID, userPassword, "icon.png", userName, userEngName, userHanName, identityNum, postNum, address, homeTel, phoneNum, email);
		if(result == 1) {
			request.getSession().setAttribute("userID", userID);
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('회원가입에 성공했습니다.')");
			script.println("location.href = 'index.jsp'");
			script.println("</script>");
			script.close();
			return;
		} else {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('이미 존재하는 회원입니다.')");
			script.println("location.href = 'join.jsp'");
			script.println("</script>");
			script.close();
			return;
		}
	}
}
