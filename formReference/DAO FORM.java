package ex;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class ExampleDAO {
	
	/* DATABASE ACCESS */
	
	DataSource dataSource;
	
	public DAO이름() {
		try {
			InitialContext initContext = new InitialContext();
			Context envContext = 
					(Context) initContext.lookup("java:/comp/env");
			dataSource = 
					(DataSource) envContext.lookup("jdbc/데이터베이스명");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	/* INSERT, UPDATE, DELETE METHOD */
	
	public int 메서드명(파리미터타입 파라미터명[,파리미터타입 파라미터명, ..., 파리미터타입 파라미터명]) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		String SQL = "INSERT INTO 테이블명 VALUES(?, ..., ?)";		// SQL QUERY는 변할 수 있음
		// UPDATE일 경우 "UPDATE 테이블명 SET 컬럼명 = ?[컬럼명 = ?, ..., 컬럼명 = ?]";
		// DELETE일 경우 "DELETE FROM 테이블명 WHERE 조건";
		try {
			conn = dataSource.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(? 위치, 대입할 값 또는 변수); 	// 데이터베이스에서 ?에 들어가는 타입이 VARCHAR, TEXT, DATETIME 등 문자일경우
			pstmt.setInt(? 위치, 대입할 값 또는 변수);  	// 데이터베이스에서 ?에 들어가는 타입이 정수형(INT)일 경우
			pstmt.setBoolean(? 위치, 대입할 값 또는 변수); // 데이터베이스에서 ?에 들어가는 타입이 Boolean일 경우
			return pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
			} catch(Exception e) {
				e.printStackTrace();
			}
		}
		return -1;
	}
	
	/* SELECT METHOD (배열이 아닌 단일 변수 반환) */
	
	public 반환타입 메서드명(파리미터타입 파라미터명[,파리미터타입 파라미터명, ..., 파리미터타입 파라미터명]) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		반환타입 반환될변수명 = null;
		String SQL = "SELECT 검색할컬럼(전체 = *) FROM 테이블명 WHERE 조건";
		try {
			conn = dataSource.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(? 위치, 대입할 값 또는 변수); 	// 데이터베이스에서 ?에 들어가는 타입이 VARCHAR, TEXT, DATETIME 등 문자일경우
			pstmt.setInt(? 위치, 대입할 값 또는 변수);  	// 데이터베이스에서 ?에 들어가는 타입이 정수형(INT)일 경우
			pstmt.setBoolean(? 위치, 대입할 값 또는 변수); // 데이터베이스에서 ?에 들어가는 타입이 Boolean일 경우
			rs = pstmt.executeQuery();
			
			/* 반환될 타입이 단일, 즉 2차원이상의 배열이 아닐경우 */
			if(rs.next()) {							// if문 안에 다른 경우 if,while,do 또는 추가적인 소스 적용가능
				/* 검색한 값이 한 개일 경우 */
				반환될변수명 = rs.getString("컬럼명");
					/* 또는 */
				반환될변수명 = rs.getInt("컬럼순서");
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
			} catch(Exception e) {
				e.printStackTrace();
			}
		}
		return 반환될변수명;
	}
	
	/* SELECT METHOD (1차원 배열 변수 반환) */
	
	public 반환타입 메서드명(파리미터타입 파라미터명[,파리미터타입 파라미터명, ..., 파리미터타입 파라미터명]) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		반환타입 반환될변수명 = null;
		String SQL = "SELECT 검색할컬럼(전체 = *) FROM 테이블명 WHERE 조건";
		try {
			conn = dataSource.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(? 위치, 대입할 값 또는 변수); 	// 데이터베이스에서 ?에 들어가는 타입이 VARCHAR, TEXT, DATETIME 등 문자일경우
			pstmt.setInt(? 위치, 대입할 값 또는 변수);  	// 데이터베이스에서 ?에 들어가는 타입이 정수형(INT)일 경우
			pstmt.setBoolean(? 위치, 대입할 값 또는 변수); // 데이터베이스에서 ?에 들어가는 타입이 Boolean일 경우
			rs = pstmt.executeQuery();
			반환될변수명 = new 반환타입객체();
			if(rs.next()) {							// if문 안에 다른 경우 if,while,do 또는 추가적인 소스 적용가능
				반환될변수명.set메서드 = rs.getString("컬럼명");
				...
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
			} catch(Exception e) {
				e.printStackTrace();
			}
		}
		return 반환될변수명;
	}
	
	/* SELECT METHOD (2차원 이상의 배열 변수 반환) */
	
	public 반환타입 메시드명(파리미터타입 파라미터명[,파리미터타입 파라미터명, ..., 파리미터타입 파라미터명]) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		반환타입 반환될변수명 = null;
		String SQL = "SELECT 검색할컬럼(전체 = *) FROM 테이블명 WHERE 조건";
		try {
			conn = dataSource.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(? 위치, 대입할 값 또는 변수); 	// 데이터베이스에서 ?에 들어가는 타입이 VARCHAR, TEXT, DATETIME 등 문자일경우
			pstmt.setInt(? 위치, 대입할 값 또는 변수);  	// 데이터베이스에서 ?에 들어가는 타입이 정수형(INT)일 경우
			pstmt.setBoolean(? 위치, 대입할 값 또는 변수); // 데이터베이스에서 ?에 들어가는 타입이 Boolean일 경우
			rs = pstmt.executeQuery();
			반환될변수명 = new 반환타입객체();
			while(rs.next()) {
				1차원배열타입 1차원배열명 = new 1차원배열타입객체();
				1차월배열명.set메서드 = rs.getString("컬럼명");
				...
				반활될변수명.add(1차원배열명);
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
			} catch(Exception e) {
				e.printStackTrace();
			}
		}
		return 반환될변수명;
	}
}
