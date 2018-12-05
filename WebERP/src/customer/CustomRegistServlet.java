package customer;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/CustomRegistServlet")
public class CustomRegistServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		String companyCode = request.getParameter("companyCode");
		String customCode = request.getParameter("customCode");
		String division = request.getParameter("division");
		String customerName = request.getParameter("customerName");
		String businessLicenseNum = request.getParameter("businessLicenseNum");
		String chiefName = request.getParameter("chiefName");
		String postNum = request.getParameter("postNum");
		String address = request.getParameter("address");
		String tel = request.getParameter("tel");
		String fax = request.getParameter("fax");
		String businessCondition = request.getParameter("businessCondition");
		String businessType = request.getParameter("businessType");
		String homepage = request.getParameter("homepage");
		String monetaryUnit = request.getParameter("monetaryUnit");
		String project = request.getParameter("project");
		String customGroup = request.getParameter("customGroup");
		String customGrade = request.getParameter("customGrade");
		String collectCompany = request.getParameter("collectCompany");
		String tradeStartDate = request.getParameter("tradeStartDate");
		String tradeEndDate = request.getParameter("tradeEndDate");
		String useBoolean = request.getParameter("useBoolean");
		String tradeForm = request.getParameter("tradeForm");
		String discountRate = request.getParameter("discountRate");
		String contractSum = request.getParameter("contractSum");
		String paymentCondition = request.getParameter("paymentCondition");
		String loanLimit = request.getParameter("loanLimit");
		String limitReturnDate = request.getParameter("limitReturnDate");
		String financialInstitution = request.getParameter("financialInstitution");
		String branchName = request.getParameter("branchName");
		String accountNum = request.getParameter("accountNum");
		String accountHolder = request.getParameter("accountHolder");
		String payDueDate = request.getParameter("payDueDate");
		String accountCode = request.getParameter("accountCode");
		String collectionDueDate = request.getParameter("collectionDueDate");
		String chargeFieldCode = request.getParameter("chargeFieldCode");
		String chargeDeptCode = request.getParameter("chargeDeptCode");
		String positionCode = request.getParameter("positionCode");
		String chargeTask = request.getParameter("chargeTask");
		String chargeEmployeeCode = request.getParameter("chargeEmployeeCode");
		String employeeExtension = request.getParameter("employeeExtension");
		String chargeNote = request.getParameter("chargeNote");
		String receivePostNum = request.getParameter("receivePostNum");
		String receiveAddress = request.getParameter("receiveAddress");
		String receiveTel = request.getParameter("receiveTel");
		String receiveFax = request.getParameter("receiveFax");
		String lastSetting = request.getParameter("lastSetting");
		if(companyCode == null || companyCode.equals("") || customCode == null || customCode.equals("") || division == null || division.equals("") 
				|| customerName == null || customerName.equals("") || businessLicenseNum == null || businessLicenseNum.equals("")) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('*은 필수 입력입니다.')");
			script.println("location.href = 'generalCustomerRegist.jsp'");
			script.println("</script>");
			script.close();
			return;
		}
		if(discountRate == null || discountRate.equals("")) {
			discountRate = "0";
		}
		if(tradeStartDate == null || tradeStartDate.equals("")) {
			tradeStartDate = "0000-00-00";
		}
		if(tradeEndDate == null || tradeEndDate.equals("")) {
			tradeEndDate = "0000-00-00";
		}
		if(useBoolean.equals("true")) {
			useBoolean = "1";
		} else {
			useBoolean = "0";
		}
		if(limitReturnDate == null || limitReturnDate.equals("")) {
			limitReturnDate = "0";
		}
		int result = new CustomerDAO().registCustom(companyCode, customCode, division, customerName, businessLicenseNum, chiefName, postNum, address, 
				tel, fax, businessCondition, businessType, homepage, monetaryUnit, project, customGroup, customGrade, collectCompany, tradeStartDate, 
				tradeEndDate, useBoolean, tradeForm, discountRate, contractSum, paymentCondition, loanLimit, limitReturnDate, financialInstitution, 
				branchName, accountNum, accountHolder, payDueDate, accountCode, collectionDueDate, chargeFieldCode, chargeDeptCode, positionCode, chargeTask, chargeEmployeeCode, 
				employeeExtension, chargeNote, receivePostNum, receiveAddress, receiveTel, receiveFax, lastSetting);
		if (result == 1) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('거래처가 등록 되었습니다.')");
			script.println("location.href = 'generalCustomerRegist.jsp'");
			script.println("</script>");
			script.close();
			return;
		} else {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('죄송합니다. 다시 시도해 주세요.')");
			script.println("location.href = 'generalCustomerRegist.jsp'");
			script.println("</script>");
			script.close();
			return;
		}
	}

}
