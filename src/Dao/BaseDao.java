package Dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;



public class BaseDao {
	// ���ӳ�
	static ArrayList<Connection> list = new ArrayList<>();
	// ���ӳش�С
	private static final int CONNECTIONPOOL_SIZE = 5; 
	/**
	 * ��ȡ����
	 * @return ���Ӷ���
	 */
	public static synchronized Connection getConnection() {
		if(list.size() == 0) {
			Connection con = null;
			// ����һ���û�����ʱ����ָ�����������ӳ�
			for(int i = 0; i < CONNECTIONPOOL_SIZE; i++) {
				try {
					Class.forName("com.mysql.jdbc.Driver");
					con = DriverManager.getConnection("jdbc:mysql://localhost:3306/shop?characterEncoding=utf8","root","123456");
					list.add(con);
				}catch(ClassNotFoundException e){
					e.printStackTrace();
				}catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}
		return list.remove(0);
	}
	/**
	 * �رս����
	 * @param rs
	 */
	public static void close(ResultSet rs) {
		if(rs != null) {
			try {
				rs.close();
			}catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}
	/**
	 * �ر�Ԥ����
	 * @param ps
	 */
	public static void close(PreparedStatement ps) {
		if(ps != null) {
			try {
				ps.close();
			}catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}
	
	/**
	 * �黹����
	 * @param con
	 */
	public static void close(Connection con) {
		if(con != null) {
			list.add(con);
		}
	}
	/**
	 * �ر����ж���
	 * @param rs
	 * @param ps
	 * @param con
	 */
	public static void close(ResultSet rs,PreparedStatement ps,Connection con) {
		close(rs);
		close(ps);
		close(con);
	}
	public static List<Map<String,Object>> select(String sql,Object [] param) {
		Connection con = getConnection();
		PreparedStatement st = null;
		ResultSet rs = null;
		List<Map<String,Object>> result = new ArrayList<Map<String,Object>>();
		try {
			st = con.prepareStatement(sql);
			if(param != null) {
				for(int i = 0; i < param.length ; i++) {
					st.setObject(i+1, param[i]);
				}
			}
			rs = st.executeQuery();
			ResultSetMetaData rm = rs.getMetaData();
			int count = rm.getColumnCount();
			while(rs.next()) {
				Map<String,Object> map = new HashMap<String, Object>();
				for(int i = 1; i <= count;i++) {
					map.put(rm.getCatalogName(i).toLowerCase(), rs.getObject(i));
				}
				result.add(map);
			}
			
			
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rs,st,con);
		}
		return result;
		
	}
	

}
