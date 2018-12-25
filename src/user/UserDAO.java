package user;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class UserDAO {
	
	DataSource dataSource;
	public UserDAO() {
		try {
			InitialContext initContext = new InitialContext();
			Context envContext = (Context) initContext.lookup("java:/comp/env");
			dataSource = (DataSource) envContext.lookup("jdbc/WebERP");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	/* 로그인 */
	public int login(String userID, String userPassword) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String SQL = "SELECT * FROM USER WHERE userID = ?";
		try {
			conn = dataSource.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				if(rs.getString("userPassword").equals(userPassword)) {
					return 1;
				}
				return 2;
			} else {
				return 0;
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(conn != null); conn.close();
			} catch(Exception e) {
				e.printStackTrace();
			}
		}
		return -1;
	}
	/* 회원가입 */
	public int join(String userID, String userPassword, String userProfile, String userName, String userEngName, String userHanName, String identityNum, String postNum, String address, String homeTel, String phoneNum, String email) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		String SQL = "INSERT INTO USER VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
		try {
			conn = dataSource.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			pstmt.setString(2, userPassword);
			pstmt.setString(3, userProfile);
			pstmt.setString(4, userName);
			pstmt.setString(5, userEngName);
			pstmt.setString(6, userHanName);
			pstmt.setString(7, identityNum);
			pstmt.setString(8, postNum);
			pstmt.setString(9, address);
			pstmt.setString(10, homeTel);
			pstmt.setString(11, phoneNum);
			pstmt.setString(12, email);
			return pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if(pstmt != null) pstmt.close();
				if(conn != null); conn.close();
			} catch(Exception e) {
				e.printStackTrace();
			}
		}
		return -1;
	}
	/* 아이디 중복체크 */
	public int checkId(String userID) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String SQL = "SELECT * FROM USER WHERE userID = ?";
		try {
			conn = dataSource.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return 0;
			} else {
				return 1;
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(conn != null); conn.close();
			} catch(Exception e) {
				e.printStackTrace();
			}
		}
		return -1;
	}
	/* 단일 유저이름 검색  (아이디)*/
	public String findUserName(String userID) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String SQL = "SELECT userName FROM USER WHERE userID = ?";
		try {
			conn = dataSource.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getString("userName");
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(conn != null); conn.close();
			} catch(Exception e) {
				e.printStackTrace();
			}
		}
		return "";
	}
	/* 리스트 유저ID 검색 (유저이름) */
	public ArrayList<String> findUserID(String userName) {
		ArrayList<String> userIDs = null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String SQL = "SELECT userID FROM USER WHERE userName LIKE ?";
		try {
			conn = dataSource.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, "%" + userName + "%");
			rs = pstmt.executeQuery();
			userIDs = new ArrayList<String>();
			while(rs.next()) {
				String userID = rs.getString(1);
				userIDs.add(userID);
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(conn != null); conn.close();
			} catch(Exception e) {
				e.printStackTrace();
			}
		}
		return userIDs;
	}
	/* 단일 유저 검색 (유저ID) */
	public UserDTO getUser(String userID) {
		UserDTO user = new UserDTO();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String SQL = "SELECT * FROM USER WHERE userID = ?";
		try {
			conn = dataSource.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				user.setUserID(rs.getString("userID"));
				user.setUserPassword(rs.getString("userPassword"));
				user.setUserProfile(rs.getString("userProfile"));
				user.setUserName(rs.getString("userName"));
				user.setUserEngName(rs.getString("userEngName"));
				user.setUserHanName(rs.getString("userHanName"));
				user.setIdentityNum(rs.getString("identityNum"));
				user.setPostNum(rs.getString("postNum"));
				user.setAddress(rs.getString("address"));
				user.setHomeTel(rs.getString("homeTel"));
				user.setPhoneNum(rs.getString("phoneNum"));
				user.setEmail(rs.getString("email"));
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(conn != null); conn.close();
			} catch(Exception e) {
				e.printStackTrace();
			}
		}
		return user;
	}
	/* 리스트 유저 검색 (이름) */
	public ArrayList<UserDTO> getUserToName(String userName) {
		ArrayList<UserDTO> userList = null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String SQL = "SELECT * FROM USER WHERE userName = ?";
		try {
			conn = dataSource.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userName);
			rs = pstmt.executeQuery();
			userList = new ArrayList<UserDTO>();
			while(rs.next()) {
				UserDTO list = new UserDTO();
				list.setUserID(rs.getString("userID"));
				list.setUserPassword(rs.getString("userPassword"));
				list.setUserProfile(rs.getString("userProfile"));
				list.setUserName(rs.getString("userName"));
				list.setUserEngName(rs.getString("userEngName"));
				list.setUserHanName(rs.getString("userHanName"));
				list.setIdentityNum(rs.getString("identityNum"));
				list.setPostNum(rs.getString("postNum"));
				list.setAddress(rs.getString("address"));
				list.setHomeTel(rs.getString("homeTel"));
				list.setPhoneNum(rs.getString("phoneNum"));
				list.setEmail(rs.getString("email"));
				userList.add(list);
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(conn != null); conn.close();
			} catch(Exception e) {
				e.printStackTrace();
			}
		}
		return userList;
	}
}
