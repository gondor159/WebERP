package businesstype;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class BusinessTypeGetNameServlet
 */
@WebServlet("/BusinessTypeGetNameServlet")
public class BusinessTypeGetNameServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		String businessCondition = request.getParameter("businessCondition");
		String businessType = request.getParameter("businessType");
		if (businessCondition == null || businessCondition.equals("") || businessType == null
				|| businessType.equals("")) {
			response.getWriter().write("");
		} else {
			try {
				response.getWriter().write(getTypeName(businessCondition, businessType));
			} catch (Exception e) {
				e.printStackTrace();
				response.getWriter().write("");
			}
		}
	}

	public String getTypeName(String businessCondition, String businessType) {
		StringBuffer result = new StringBuffer("");
		BusinessTypeDAO businessTypeDAO = new BusinessTypeDAO();
		BusinessTypeDTO businessTypeDTO = businessTypeDAO.getBusinessType(businessCondition, businessType);
		if(businessTypeDTO == null) return "";
		result.append("{\"result\":[{\"value\": \"" + businessTypeDTO.getBusinessConditionName() + "\"},");
		result.append("{\"value\": \"" + businessTypeDTO.getBusinessTypeName() + "\"}]}");
		return result.toString();
	}
}
