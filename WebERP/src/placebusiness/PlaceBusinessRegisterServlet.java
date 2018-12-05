package placebusiness;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/PlaceBusinessRegisterServlet")
public class PlaceBusinessRegisterServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	@SuppressWarnings("deprecation")
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		String companyCode = request.getParameter("companyCode");
		String placeCode = request.getParameter("placeCode");
		String businessLicenseNum = request.getParameter("businessLicenseNum");
		String corporateLicenseNum = request.getParameter("corporateLicenseNum");
		String companyName = request.getParameter("companyName");
		String companyEngName = request.getParameter("companyEngName");
		String chiefID = request.getParameter("chiefID");
		String postNum = request.getParameter("postNum");
		String address = request.getParameter("address");
		String addressEng = request.getParameter("addressEng");
		String tel = request.getParameter("tel");
		String fax = request.getParameter("fax");
		String businessCondition = request.getParameter("businessCondition");
		String businessType = request.getParameter("businessType");
		String establishmentDate = request.getParameter("establishmentDate");
		String startDate = request.getParameter("startDate");
		String monetaryUnit = request.getParameter("monetaryUnit");
		String taxOfiice = request.getParameter("taxOfiice");
		String headBooleanSt = request.getParameter("headBoolean");
		if(companyCode == null || companyCode.equals("") || placeCode == null || placeCode.equals("")
				|| businessLicenseNum == null || businessLicenseNum.equals("") || companyName == null
				|| companyName.equals("") || chiefID == null || chiefID.equals("") || postNum == null
				|| postNum.equals("") || address == null || address.equals("") || tel == null || tel.equals("")
				|| businessCondition == null || businessCondition.equals("") || businessType == null
				|| businessType.equals("") || establishmentDate == null || establishmentDate.equals("")
				|| startDate == null || startDate.equals("") || taxOfiice == null || taxOfiice.equals("")
				|| headBooleanSt == null || headBooleanSt.equals("")) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('필수 요소 중 입력 되지 않은 요소가 있습니다.')");
			script.println("location.href = 'placeRegist.jsp'");
			script.println("</script>");
			script.close();
			return;
		}
		boolean headBoolean = new Boolean(headBooleanSt).booleanValue();
		int result = new PlaceBusinessDAO().registPlace(companyCode, placeCode, businessLicenseNum, corporateLicenseNum,
				companyName, companyEngName, chiefID, postNum, address, addressEng, tel, fax, businessCondition,
				businessType, establishmentDate, startDate, monetaryUnit, taxOfiice, headBoolean);
		if(result == 1) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('등록되었습니다.')");
			script.println("location.href = 'placeRegist.jsp'");
			script.println("</script>");
			script.close();
			return;
		} else {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('죄송합니다. 오류가 발생했습니다.')");
			script.println("location.href = 'placeRegist.jsp'");
			script.println("</script>");
			script.close();
			return;
		}
	}

}
