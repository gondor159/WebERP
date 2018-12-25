package user;

import java.io.IOException;
import java.net.URLDecoder;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/UserFindToIDServlet")
public class UserFindToIDServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		String userID = request.getParameter("userID");
		if(userID == null || userID.equals("")) {
			response.getWriter().write("");
		} else {
			try {
				response.getWriter().write(getUser(URLDecoder.decode(userID, "UTF-8")));
			} catch(Exception e) {
				e.printStackTrace();
				response.getWriter().write("");
			}
		}
	}
	public String getUser(String userID) {
		StringBuffer result = new StringBuffer("");
		UserDAO userDAO = new UserDAO();
		UserDTO user = userDAO.getUser(userID);
		if(user.getUserID().equals("null") || user == null) { 
			return ""; 
		} else {
			result.append("{\"result\":[");
			result.append("{\"value\": \"" + user.getUserID() + "\"},");
			result.append("{\"value\": \"" + user.getUserName() + "\"},");
			result.append("{\"value\": \"" + user.getIdentityNum().substring(0, 6) + "\"},");
			result.append("{\"value\": \"" + user.getHomeTel() + "\"}]}");
		}
		return result.toString();
	}
}
