package user;

import java.io.IOException;
import java.net.URLDecoder;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/UserFindToNameServlet")
public class UserFindToNameServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		String userName = request.getParameter("userName");
		if(userName == null || userName.equals("")) {
			response.getWriter().write("");
		} else {
			try {
				response.getWriter().write(getUser(URLDecoder.decode(userName, "UTF-8")));
			} catch(Exception e) {
				e.printStackTrace();
				response.getWriter().write("");
			}
		}
	}
	public String getUser(String userName) {
		StringBuffer result = new StringBuffer("");
		result.append("{\"result\":[");
		UserDAO userDAO = new UserDAO();
		ArrayList<UserDTO> user = userDAO.getUserToName(userName);
		if(user == null) { 
			return ""; 
		} else {
			for(int i = 0; i < user.size(); i++) {
				result.append("[{\"value\": \"" + user.get(i).getUserID() + "\"},");
				result.append("{\"value\": \"" + user.get(i).getUserName() + "\"},");
				result.append("{\"value\": \"" + user.get(i).getIdentityNum().substring(0, 6) + "\"},");
				result.append("{\"value\": \"" + user.get(i).getHomeTel() + "\"}]");
				if(i != user.size() -1) result.append(",");
			}
		}
		result.append("]}");
		return result.toString();
	}
}
