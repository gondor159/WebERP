package track;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class TrackDAO {
	DataSource dataSource;

	public TrackDAO() {
		try {
			InitialContext initContext = new InitialContext();
			Context envContext = (Context) initContext.lookup("java:/comp/env");
			dataSource = (DataSource) envContext.lookup("jdbc/WebERP");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	/* 품목군 등록 */
	public int registTrack(String companyCode, String trackCode, String trackName, String useBoolean, String trackInfo, String lastUser) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		String SQL = "INSERT INTO TRACK VALUES(?, ?, ?, ?, ?, ?, now())";
		try {
			conn = dataSource.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, companyCode);
			pstmt.setString(2, trackCode);
			pstmt.setString(3, trackName);
			pstmt.setString(4, useBoolean);
			pstmt.setString(5, trackInfo);
			pstmt.setString(6, lastUser);
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
	
	/* 리스트 품목군 불러오기 */
	public ArrayList<TrackDTO> getTrackList(String companyCode) {
		ArrayList<TrackDTO> list = null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String SQL = "SELECT * FROM TRACK WHERE companyCode = ?";
		try {
			conn = dataSource.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, companyCode);
			rs = pstmt.executeQuery();
			list = new ArrayList<TrackDTO>();
			while(rs.next()) {
				TrackDTO track = new TrackDTO();
				track.setCompanyCode(rs.getString("companyCode"));
				track.setTrackCode(rs.getString("trackCode"));
				track.setTrackName(rs.getString("trackName"));
				track.setUseBoolean(rs.getString("useBoolean"));
				track.setTrackInfo(rs.getString("trackInfo"));
				track.setLastUser(rs.getString("lastUser"));
				track.setLastDate(rs.getString("lastDate"));
				list.add(track);
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
		return list;
	}
}
