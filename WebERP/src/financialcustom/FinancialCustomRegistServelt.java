package financialcustom;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/FinancialCustomRegistServelt")
public class FinancialCustomRegistServelt extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		String companyCode = request.getParameter("companyCode");
		String fcCode = request.getParameter("fcCode");
		String fcName = request.getParameter("fcName");
		String division = request.getParameter("division");
		String businessLicenseNum = request.getParameter("businessLicenseNum");
		String postNum = request.getParameter("postNum");
		String address = request.getParameter("address");
		String tel = request.getParameter("tel");
		String fax = request.getParameter("fax");
		String homepage = request.getParameter("homepage");
		String email = request.getParameter("email");
		String accountNum = request.getParameter("accountNum");
		String accountBranch = request.getParameter("accountBranch");
		String cardNum = request.getParameter("cardNum");
		String cardDivision = request.getParameter("cardDivision");
		String cardMember = request.getParameter("cardMember");
		String projectCode = request.getParameter("projectCode");
		String customGroup = request.getParameter("customGroup");
		String financialInstitutionCode = request.getParameter("financialInstitutionCode");
		String accountDivision = request.getParameter("accountDivision");
		String accountName = request.getParameter("accountName");
		String accountHolder = request.getParameter("accountHolder");
		String swiftCode = request.getParameter("swiftCode");
		String accountLimit = request.getParameter("accountLimit");
		String sum = request.getParameter("sum");
		String monthlyIncomeInterest = request.getParameter("monthlyIncomeInterest");
		String ttoacStart = request.getParameter("ttoacStart");
		String ttoacEnd = request.getParameter("ttoacEnd");
		String interestTransferDate = request.getParameter("interestTransferDate");
		String interestRatio = request.getParameter("interestRatio");
		String contractSum = request.getParameter("contractSum");
		String etdSum = request.getParameter("etdSum");
		String etdDate = request.getParameter("etdDate");
		String commissionRatio = request.getParameter("commissionRatio");
		String paymentAccount = request.getParameter("paymentAccount");
		String monthlyLimitSum = request.getParameter("monthlyLimitSum");
		String effectiveLife = request.getParameter("effectiveLife");
		String useBoolean = request.getParameter("useBoolean");
		String inquiryLimit = request.getParameter("inquiryLimit");
		String accountOpenDate = request.getParameter("accountOpenDate");
		String tradeStartDate = request.getParameter("tradeStartDate");
		String tradeEndDate = request.getParameter("tradeEndDate");
		String maturityDate = request.getParameter("maturityDate");
		String lastUser = request.getParameter("lastUser");
		
		if(companyCode == null || companyCode.equals("") || fcCode == null || fcCode.equals("") || fcName == null || fcName.equals("") || division == null || division.equals("")) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('*는 필수 입력입니다.')");
			script.println("history.back();");
			script.println("</script>");
			script.close();
			return;
		}
		if(lastUser == null || lastUser.equals("")) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인이 필요합니다.')");
			script.println("location.href = '../login.jsp'");
			script.println("</script>");
			script.close();
			return;
		}
		if(ttoacStart == null || ttoacStart.equals("")) {
			ttoacStart = "0000-00-00";
		}
		if(ttoacEnd == null || ttoacEnd.equals("")) {
			ttoacEnd = "0000-00-00";
		}
		if(accountOpenDate == null || accountOpenDate.equals("")) {
			accountOpenDate = "0000-00-00";
		}
		if(tradeStartDate == null || tradeStartDate.equals("")) {
			tradeStartDate = "0000-00-00";
		}
		if(tradeEndDate == null || tradeEndDate.equals("")) {
			tradeEndDate = "0000-00-00";
		}
		if(maturityDate == null || maturityDate.equals("")) {
			maturityDate = "0000-00-00";
		}
		if(interestRatio == null || interestRatio.equals("")) {
			interestRatio = "0";
		}
		if(commissionRatio == null || commissionRatio.equals("")) {
			commissionRatio = "0";
		}
		int result = 0;
		if (division.equals("fi")) {
			result = new FinancialCustomDAO().fiRegist(companyCode, fcCode, division, fcName, accountNum, accountBranch, businessLicenseNum, postNum, address, tel, fax, homepage, email, projectCode, customGroup, financialInstitutionCode, accountDivision, accountHolder, accountName, accountLimit, swiftCode, accountOpenDate, tradeEndDate, useBoolean, inquiryLimit, lastUser);
		} else if (division.equals("td")) {
			result = new FinancialCustomDAO().tdRegist(companyCode, fcCode, division, fcName, accountNum, accountBranch, businessLicenseNum, postNum, address, tel, fax, homepage, email, projectCode, customGroup, financialInstitutionCode, accountDivision, accountHolder, accountName, sum, monthlyIncomeInterest, ttoacStart, ttoacEnd, interestTransferDate, interestRatio, swiftCode, tradeStartDate, maturityDate, useBoolean, inquiryLimit, lastUser);
		} else if (division.equals("isd")) {
			result = new FinancialCustomDAO().isdRegist(companyCode, fcCode, division, fcName, accountNum, accountBranch, businessLicenseNum, postNum, address, tel, fax, homepage, email, projectCode, customGroup, financialInstitutionCode, accountDivision, accountHolder, accountName, contractSum, etdSum, ttoacStart, ttoacEnd, etdDate, interestRatio, swiftCode, tradeStartDate, maturityDate, useBoolean, inquiryLimit, lastUser);
		} else if (division.equals("ccc")) {
			result = new FinancialCustomDAO().cccRegist(companyCode, fcCode, division, fcName, accountNum, accountBranch, businessLicenseNum, postNum, address, tel, fax, homepage, email, projectCode, customGroup, financialInstitutionCode, paymentAccount, accountHolder, commissionRatio, swiftCode, tradeStartDate, tradeEndDate, useBoolean, inquiryLimit, lastUser);
		} else if (division.equals("cd")) {
			result = new FinancialCustomDAO().cdRegist(companyCode, fcCode, division, fcName, cardNum, cardDivision, accountBranch, businessLicenseNum, cardMember, postNum, address, tel, fax, homepage, email, projectCode, customGroup, financialInstitutionCode, paymentAccount, accountHolder, monthlyLimitSum, effectiveLife, tradeStartDate, tradeEndDate, useBoolean, inquiryLimit, lastUser);
		}
		
		if(result == 1) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('정상 등록되었습니다.')");
			script.println("location.href = 'financialCustomRegist.jsp'");
			script.println("</script>");
			script.close();
			return;
		} else {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('데이터베이스 오류입니다.')");
			script.println("history.back();");
			script.println("</script>");
			script.close();
			return;
		}
	}

}
