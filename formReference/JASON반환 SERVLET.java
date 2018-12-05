package ex;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/서블릿 URL 패턴")
public class 서블릿명 extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		/* ENCODING */
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		
		/* PARAMETER SETTING */
		String 변수명 = request.getParameter("파라미터명");
		...
		
		/* PARAMETER 검증 */
		if(변수명 == null || 변수명.equals("") || ...) {
			response.getWriter().write("");
		} else {
			/* PARAMETER의 문제가 없을때  */
			try {
				response.getWriter().write(함수명(파라미터변수));
			} catch(Exception e) {
				e.printStackTrace();
				response.getWriter().write("");
			}
		}
	}
	
	/* 반한되는 JSON이 2차원 배열일 경우 함수 선언 */
	public String 함수명(파라미터타입 파라미터명) {
		/* StringBuffer 선언 */
		StringBuffer result = new StringBuffer("");
		/* JSON 시작 */
		result.append("{\"result\":[");
		
		/* 각종 메서드(아래는 일반적 예시) */
		DAO객체타입 객체명 = new DAO객체();
		배열변수타입 배열변수명 = 객체명.메서드(파라미터);
		
		/* 배열의 SIZE 검증 */
		if(배열변수명.size() == 0) return "";
		
		/* JSON 작성 */
		for(int i = 0; i < 배열변수명.size(); i++) {
			result.append("[{\"value\": \"" + 배열변수명.get(i)[.get메서드()] + "\"},");
			result.append("{\"value\": \"" + 배열변수명.get(i)[.get메서드()] + "\"},");
			...
			result.append("{\"value\": \"" + 배열변수명.get(i)[.get메서드()] + "\"}]");
			/* 배열변수에서 배열이 더 존재 할 때 */
			if(i != 배열변수명.size() -1) result.append(",");
		}
		
		/* JSON 작성 마무리 */
		result.append("]}");
		/* StringBuffer타입인 result를 String 타입으로 변환 후 반환 */
		return result.toString();
	}
	
	/* 반한되는 JSON이 1차원 배열일 경우 함수 선언 */
	public String 함수명(파라미터타입 파라미터명) {
		/* StringBuffer 선언 */
		StringBuffer result = new StringBuffer("");
		/* JSON 시작 */
		result.append("{\"result\":");
		
		/* 각종 메서드(아래는 일반적 예시) */
		DAO객체타입 객체명 = new DAO객체();
		배열변수타입 배열변수명 = 객체명.메서드(파라미터);
		
		/* 배열의 SIZE 검증 */
		if(배열변수명 == null) return "";
		
		/* JSON 작성 */
		result.append("{\"value\": \"" + 배열변수명.get메서드() + "\"},");
		result.append("{\"value\": \"" + 배열변수명.get메서드() + "\"},");
		...
		result.append("{\"value\": \"" + 배열변수명.get메서드() + "\"}");
		
		/* JSON 작성 마무리 */
		result.append("}");
		/* StringBuffer타입인 result를 String 타입으로 변환 후 반환 */
		return result.toString();
	}

}



/*
*	StringBuffer란?
*
*	String 클래스의 인스턴스는 한 번 생성되면 그 값을 읽기만 할 수 있고, 변경할 수는 없습니다.
*	하지만 StringBuffer 클래스의 인스턴스는 그 값을 변경할 수도 있고, 추가할 수도 있습니다.
*	
*	이를 위해 StringBuffer 클래스는 내부적으로 버퍼(buffer)라고 하는 독립적인 공간을 가집니다.
*	버퍼 크기의 기본값은 16개의 문자를 저장할 수 있는 크기이며, 생성자를 통해 그 크기를 별도로 설정할 수도 있습니다.
*	하지만 인스턴스 생성 시 사용자가 설정한 크기보다 언제나 16개의 문자를 더 저장할 수 있도록 여유 있는 크기로 생성됩니다.
*
*	덧셈(+) 연산자를 이용해 String 인스턴스의 문자열을 결합하면, 내용이 합쳐진 새로운 String 인스턴스를 생성합니다.
*	따라서 문자열을 많이 결합하면 결합할수록 공간의 낭비뿐만 아니라 속도 또한 매우 느려지게 됩니다.
*
*	하지만 StringBuffer 인스턴스를 사용하면 문자열을 바로 추가할 수 있으므로, 공간의 낭비도 없으며 속도도 매우 빨라집니다.
*	이러한 StringBuffer 클래스는 java.lang 패키지에 포함되어 제공됩니다.
*/

/*
*	JSON이란?
*	
*	JSON은 경량(Lightweight)의 DATA-교환 형식입니다.
*	Javascript에서 객체를 만들 때 사용하는 표현식을 의미합니다.
*	JSON 표현식은 사람과 기계 모두 이해하기 쉬우며 용량이 작아서, 최근에는 JSON이 XML을 대체해서 데이터 전송 등에 많이 사용합니다.
*	특정 언어에 종속되지 않으며, 대부분의 프로그래밍 언어에서 JSON 포맷의 데이터를 핸들링 할 수 있는 라이브러리를 제공합니다.
*
*	JSON형식
*	
*	단일
*	{ "String-Key(이름)" : "String-Value" }
*	
*	배열명이 없는 1차원 배열
*	{
*		"String-Key" : "String-Value",
*		"String-Key" : "String-Value",
*		...
*		"String-Key" : "String-Value"
*	}
*	
*	배열명이 존재하는 1차원 배열
*	{
*		"배열명" : {
*					"String-Key" : "String-Value",
*					"String-Key" : "String-Value",
*					...
*					"String-Key" : "String-Value"
*				}
*	}
*
*	배열명이 존재하는 2차원 배열
*	{
*		"배열명" : {
*					["String-Key" : "String-Value", "String-Key" : "String-Value", ..., "String-Key" : "String-Value"],
*					["String-Key" : "String-Value", "String-Key" : "String-Value", ..., "String-Key" : "String-Value"],
*					...
*					["String-Key" : "String-Value", "String-Key" : "String-Value", ..., "String-Key" : "String-Value"]
*				}
*	}
*/