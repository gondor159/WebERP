package track;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/TrackRegistServlet")
public class TrackRegistServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		String companyCode = request.getParameter("companyCode");
		String trackCode = request.getParameter("trackCode");
		String trackName = request.getParameter("trackName");
		String useBoolean = request.getParameter("useBoolean");
		String trackInfo = request.getParameter("trackInfo");
		String lastUser = request.getParameter("lastUser");
		if(companyCode == null || companyCode.equals("") || trackCode == null || trackCode.equals("") || trackName == null || trackName.equals("") ||
				useBoolean == null || useBoolean.equals("") || lastUser == null || lastUser.equals("")) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('설명을 제외한 모든 값을 입력해주세요.')");
			script.println("history.back();");
			script.println("</script>");
			script.close();
			return;
		}
		
		int result = new TrackDAO().registTrack(companyCode, trackCode, trackName, useBoolean, trackInfo, lastUser);
		if(result == 1) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('등록에 성공하였습니다.')");
			script.println("location.href = 'trackRegist.jsp'");
			script.println("</script>");
			script.close();
			return;
		} else {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('등록에 실패하였습니다.')");
			script.println("history.back();");
			script.println("</script>");
			script.close();
			return;
		}
	}

}
