package core;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

public class Equip_rent_DAO {

	private static Equip_rent makeEquip_rent(ResultSet resultSet) throws SQLException{
		Equip_rent equip_rent = new Equip_rent();
		equip_rent.setId(resultSet.getInt("id"));
		equip_rent.setUser_id(resultSet.getString("user_id"));
		equip_rent.setEquip_id(resultSet.getInt("equip_id"));
		equip_rent.setEquip_rent_day(resultSet.getString("equip_rent_day"));
		equip_rent.setEquip_return_day(resultSet.getString("equip_return_day"));
		return equip_rent;
	}
	
	public static Equip_rent selectById(String id) throws Exception{
		Equip_rent equip_rent = null;
		Connection connection = null;
		PreparedStatement statement = null;
		ResultSet resultSet = null;
		try{
			connection = DB.getConnection();
			String sql ="SELECT * FROM[Equip_rent] WHERE [id]=?";
			statement = connection.prepareStatement(sql);
			statement.setString(1,id);
			resultSet=statement.executeQuery();
			if(resultSet.next())
				equip_rent = makeEquip_rent(resultSet);
		}finally{
			if(resultSet!=null) resultSet.close();
			if(statement!=null) statement.close();
			if(connection!=null) connection.close();
		}
		return equip_rent;
	}
	
	public static Equip_rent selectByUser_id(String id) throws Exception{
		Equip_rent equip_rent = null;
		Connection connection = null;
		PreparedStatement statement = null;
		ResultSet resultSet = null;
		try{
			connection = DB.getConnection();
			String sql="SELECT * FROM[equip_rent] WHERE [user_id]=?";
			statement = connection.prepareStatement(sql);
			statement.setString(1, id);
			resultSet = statement.executeQuery();
			if(resultSet.next())
				equip_rent = makeEquip_rent(resultSet);
		}finally{
			if(resultSet!=null) resultSet.close();
			if(statement!=null) statement.close();
			if(connection!=null) connection.close();
		}
		return equip_rent;
	}
	public static void insert(Equip_rent equip_rent) throws Exception{
		Connection connection = null;
		PreparedStatement statement = null;
		try{
			connection = DB.getConnection();
			String sql="INSERT[equip_rent] ([user_id], [equip_id],[equip_rent_day],[equip_return_day]) VALUES(?,?,?,?)";
			statement = connection.prepareStatement(sql);
			statement.setString(1, equip_rent.getUser_id());
			statement.setInt(2, equip_rent.getEquip_id());
			statement.setString(3, equip_rent.getEquip_rent_day());
			statement.setString(4, equip_rent.getEquip_return_day());
			statement.executeUpdate();
		}finally{
			if(statement!=null) statement.close();
			if(connection!=null) connection.close();
		}
	}
	
	public static void delete(String user_id) throws Exception{
		Connection connection = null;
		PreparedStatement statement = null;
		try{
			connection = DB.getConnection();
			String sql ="DELETE FROM[equip_rent] WHERE [user_id]=?";
			statement = connection.prepareStatement(sql);
			statement.setString(1 , user_id);
			statement.executeUpdate();
		}finally{
			if(statement!=null) statement.close();
			if(connection!=null) connection.close();
		}
	}
	
	public static int countByEquip_id(int equip_id) throws Exception{
		int count=0;
		Connection connection = null;
		PreparedStatement statement = null;
		ResultSet resultSet = null;
		try{
			connection = DB.getConnection();
			String sql ="SELECT COUNT(*) FROM[Equip_rent] WHERE [equip_id]=?";
			statement = connection.prepareStatement(sql);
			statement.setInt(1 , equip_id);
			resultSet = statement.executeQuery();
			if(resultSet.next())
				count=resultSet.getInt(1);
		}finally{
			if(resultSet!=null) resultSet.close();
			if(statement!=null) statement.close();
			if(connection!=null) connection.close();
		} 
		return count;
	}
	
	public static ArrayList<Equip_rent> equipSelectByReturn(int currentPage, int pageSize) throws Exception{
		Connection connection = null;
		PreparedStatement statement = null;
		ResultSet resultSet = null;
		try{
			connection = DB.getConnection();
			String sql ="EXEC equipSelectByReturn ?,?";
			statement = connection.prepareStatement(sql);
			statement.setInt(1, currentPage);
			statement.setInt(2, pageSize);
			resultSet = statement.executeQuery();
			ArrayList<Equip_rent> list = new ArrayList<Equip_rent>();
			while(resultSet.next())
				list.add(makeEquip_rent(resultSet));
			return list;
		}finally{
			if(resultSet!=null) resultSet.close();
			if(statement!=null) statement.close();
			if(connection!=null) connection.close();
		}
	}
	
	public static int getRecordCount() throws Exception{
		int count=0;
		Connection connection = null;
		PreparedStatement statement = null;
		ResultSet resultSet = null;
		try{
			connection = DB.getConnection();
			String sql = "SELECT COUNT(*) FROM[equip_rent]";
			statement = connection.prepareStatement(sql);
			resultSet = statement.executeQuery();
			if(resultSet.next())
				count=resultSet.getInt(1);
		}finally{
			if(resultSet!=null) resultSet.close();
			if(statement!=null) statement.close();
			if(connection!=null) connection.close();
		}
		return count;
	}
	public static ArrayList<Equip_rent> equipSelectByReturn_userId(int currentPage, int pageSize, String id) throws Exception{
		Connection connection = null;
		PreparedStatement statement = null;
		ResultSet resultSet = null;
		try{
			connection = DB.getConnection();
			String sql = "EXEC equipSelectByReturn_userId ?,?,?";
			statement = connection.prepareStatement(sql);
			statement.setInt(1,currentPage);
			statement.setInt(2 , pageSize);
			statement.setString(3, id);
			resultSet = statement.executeQuery();
			ArrayList<Equip_rent> list = new ArrayList<Equip_rent>();
			while(resultSet.next())
				list.add(makeEquip_rent(resultSet));
			return list;
		}finally{
			if(resultSet!=null) resultSet.close();
			if(statement!=null) statement.close();
			if(connection!=null) connection.close();
		}
	}
	public static int getRecordCountById(String id) throws Exception{
		int count=0;
		Connection connection = null;
		PreparedStatement statement = null;
		ResultSet resultSet = null;
		try{
			connection = DB.getConnection();
			String sql="SELECT COUNT(*) FROM[equip_rent] WHERE CHARINDEX([user_id],?)";
			statement = connection.prepareStatement(sql);
			resultSet = statement.executeQuery();
			if(resultSet.next())
				count = resultSet.getInt(1);
		}finally{
			if(resultSet!=null) resultSet.close();
			if(statement!=null) statement.close();
			if(connection!=null) connection.close();
		} 
		return count;
	}
}