package core;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

public class EquipDAO {
	
	public static Equip makeEquip(ResultSet resultSet) throws SQLException{
		Equip equip = new Equip();
		equip.setId(resultSet.getInt("id"));
		equip.setName(resultSet.getString("name"));
		equip.setDepartment_id(resultSet.getInt("department_id"));
		equip.setCount(resultSet.getInt("count"));
		equip.setOs(resultSet.getString("os"));
		equip.setMemory(resultSet.getString("memory"));
		equip.setCpu(resultSet.getString("cpu"));
		equip.setImage(resultSet.getString("image"));
		return equip;
	}
	
	public static Equip selectById(int id) throws Exception{
		Equip equip=null;
		Connection connection=null;
		PreparedStatement statement=null;
		ResultSet resultSet = null;
		try{
			connection=DB.getConnection();
			String sql="SELECT * FROM [equip] WHERE [id]=?";
			statement=connection.prepareStatement(sql);
			statement.setInt(1, id);
			resultSet=statement.executeQuery();
			if(resultSet.next()) equip = makeEquip(resultSet);
		}finally{
			if(resultSet!=null) resultSet.close();
			if(statement!=null) statement.close();
			if(connection!=null) connection.close();
		}
		return equip;
	}
	
	public static ArrayList<Equip> selectByName(String name) throws Exception{
		Connection connection = null;
		PreparedStatement statement = null;
		ResultSet resultSet = null;
		try{
			connection=DB.getConnection();
			String sql="SELECT * FROM [equip] WHERE CHARINDEX(?,[name])=1";
			statement=connection.prepareStatement(sql);
			statement.setString(1, name);
			resultSet=statement.executeQuery();
			ArrayList <Equip> list = new ArrayList<Equip>();
			while(resultSet.next()){
				list.add(makeEquip(resultSet));
			}
			return list;
		}finally{
			if(resultSet!=null) resultSet.close();
			if(statement!=null) statement.close();
			if(connection!=null) connection.close();
		}
	}
	
	public static ArrayList<Equip> selectByDepartment_id(int department_id) throws Exception{
		Connection connection=null;
		PreparedStatement statement=null;
		ResultSet resultSet = null;
		try{
			connection=DB.getConnection();
			String sql="SELECT * FROM [equip] WHERE [department_id]=?";
			statement=connection.prepareStatement(sql);
			statement.setInt(1, department_id);
			resultSet=statement.executeQuery();
			ArrayList<Equip> list = new ArrayList<Equip>();
			while(resultSet.next())
				list.add(makeEquip(resultSet));
			return list;
		}finally{
			if(resultSet!=null) resultSet.close();
			if(statement!=null) statement.close();
			if(connection!=null) connection.close();
		}
	}
	
	public static ArrayList<Equip> selectAll() throws Exception{
		Connection connection = null;
		PreparedStatement statement = null;
		ResultSet resultSet=null;
		try{
			connection=DB.getConnection();
			String sql="SELECT * FROM[equip];";
			statement = connection.prepareStatement(sql);
			resultSet=statement.executeQuery();
			ArrayList<Equip> list = new ArrayList<Equip>();
			while(resultSet.next())
				list.add(makeEquip(resultSet));
			return list;
		}finally{
			if(resultSet!=null) resultSet.close();
			if(statement!=null) statement.close();
			if(connection!=null) connection.close();
		}
	}
	
	public static ArrayList<Equip> selectByDepartment_name(String department_name) throws Exception{
		Connection connection = null;
		PreparedStatement statement = null;
		ResultSet resultSet = null;
		try{
			connection=DB.getConnection();
			String sql="SELECT * FROM[equip] WHERE department_id=(SELECT * FROM[department] WHERE [department_name]=?)";
			statement = connection.prepareStatement(sql);
			statement.setString(1,department_name);
			resultSet = statement.executeQuery();
			ArrayList<Equip> list = new ArrayList<Equip>();
			if(resultSet.next())
				list.add(makeEquip(resultSet));
			return list;
		}finally{
			if(resultSet!=null) resultSet.close();
			if(statement!=null) statement.close();
			if(connection!=null) connection.close();
		}
	}
	
	public static ArrayList<Equip> selectAll(int currentPage, int pageSize) throws Exception{
		Connection connection = null;
		PreparedStatement statement=null;
		ResultSet resultSet = null;
		try{
			connection = DB.getConnection();
			String sql ="EXEC selectEquip ?,?";
			statement = connection.prepareStatement(sql);
			statement.setInt(1, currentPage);
			statement.setInt(2, pageSize);
			resultSet = statement.executeQuery();
			ArrayList<Equip> list = new ArrayList<Equip>();
			while(resultSet.next())
				list.add(makeEquip(resultSet));
			return list;
		}finally{
			if(resultSet!=null) resultSet.close();
			if(statement!=null) statement.close();
			if(connection!=null) connection.close();
		} 
	}
	public static ArrayList<Equip> selectPage(int currentPage, int pageSize, int department_id) throws Exception{
		Connection connection = null;
		PreparedStatement statement = null;
		ResultSet resultSet = null;
		try{
			connection = DB.getConnection();
			String sql="EXEC equipByDepartment_id ?,?,?";;
			statement = connection.prepareStatement(sql);
			statement.setInt(1, currentPage);
			statement.setInt(2, pageSize);
			statement.setInt(3, department_id);
			resultSet = statement.executeQuery();
			ArrayList<Equip> list = new ArrayList<Equip>();
			while(resultSet.next())
				list.add(makeEquip(resultSet));
			return list;
		}finally{
			if(resultSet!=null) resultSet.close();
			if(statement!=null) statement.close();
			if(connection!=null) connection.close();
		}
	}
	
	public static ArrayList<Equip> equipSelectName(int currentPage, int pageSize, String name) throws Exception{
		Connection connection = null;
		PreparedStatement statement = null;
		ResultSet resultSet = null;
		try{
			connection = DB.getConnection();
			String sql = "EXEC equipSelectName ?,?,?";
			statement = connection.prepareStatement(sql);
			statement.setInt(1, currentPage);
			statement.setInt(2, pageSize);
			statement.setString(3, name);
			resultSet = statement.executeQuery();
			ArrayList<Equip> list = new ArrayList<Equip>();
			while(resultSet.next())
				list.add(makeEquip(resultSet));
			return list;
		}finally{
			if(resultSet!=null) resultSet.close();
			if(statement!=null) statement.close();
			if(connection!=null) connection.close();
		}
	}
	
	public static ArrayList<Equip> equipSelectDepartment(int currentPage, int pageSize, String department) throws Exception{
		Connection connection = null;
		PreparedStatement statement = null;
		ResultSet resultSet = null;
		try{
			connection = DB.getConnection();
			String sql = "EXEC equipSelectDepartment ?,?,?";
			statement = connection.prepareStatement(sql);
			statement.setInt(1, currentPage);
			statement.setInt(2, pageSize);
			statement.setString(3, department);
			resultSet = statement.executeQuery();
			ArrayList<Equip> list = new ArrayList<Equip>();
			while(resultSet.next())
				list.add(makeEquip(resultSet));
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
			String sql="SELECT COUNT(*) FROM [equip]";
			statement = connection.prepareStatement(sql);
			resultSet=statement.executeQuery();
			if(resultSet.next())
				count=resultSet.getInt(1);
		}finally{
			if(resultSet!=null) resultSet.close();
			if(statement!=null) statement.close();
			if(connection!=null) connection.close();
		}
		return count;
	}
	
	public static int getRecordCountByName(String name) throws Exception{
		int count =0;
		Connection connection = null;
		PreparedStatement statement = null;
		ResultSet resultSet = null;
		try{
			connection = DB.getConnection();
			String sql = "SELECT COUNT(*) FROM [equip] WHERE CHARINDEX(?,[name])=1";
			statement = connection.prepareStatement(sql);
			statement.setString(1, name);
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
	
	public static int getRecordCountByDepartment(String department) throws Exception{
		int count = 0;
		Connection connection = null;
		PreparedStatement statement = null;
		ResultSet resultSet = null;
		try{
			connection = DB.getConnection();
			String sql ="SELECT COUNT(*) FROM [equip] WHERE [department_id]=(select [id] from [department] where CHARINDEX(?,[name])=1)";
			statement = connection.prepareStatement(sql);
			statement.setString(1, department);
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
	public static int getRecordCount(int department_id) throws Exception{
		int count=0;
		Connection connection = null;
		PreparedStatement statement = null;
		ResultSet resultSet = null;
		try{
			connection = DB.getConnection();
			String sql = "SELECT COUNT(*) FROM [equip] WHERE [department_id]=?";
			statement = connection.prepareStatement(sql);
			statement.setInt(1,department_id);
			resultSet=statement.executeQuery();
			if(resultSet.next())
				count=resultSet.getInt(1);
		}finally{
			if(resultSet!=null) resultSet.close();
			if(statement!=null) statement.close();
			if(connection!=null) connection.close();
		}
		return count;
	}
	public static void insert(Equip equip) throws Exception{
		Connection connection = null;
		PreparedStatement statement = null;
		try{
			connection = DB.getConnection();
			String sql = "INSERT [Equip] VALUES(?, ?, ?, ?, ?, ?, ?)";
			statement = connection.prepareStatement(sql);
			statement.setString(1, equip.getName());
			statement.setInt(2, equip.getDepartment_id());
			statement.setInt(3, equip.getCount());
			statement.setString(4, equip.getOs());
			statement.setString(5, equip.getMemory());
			statement.setString(6, equip.getCpu());
			statement.setString(7, equip.getImage());
			statement.executeUpdate();
		}finally{
			if(statement!=null) statement.close();
			if(connection!=null) connection.close();
		}
	}
	
	public static void update(String name, int department_id, int count, String os, String memory, String cpu, int id) throws Exception{
		Connection connection = null;
		PreparedStatement statement = null;
		try{
			connection = DB.getConnection();
			String sql = "UPDATE [Equip] SET [name]=?, [department_id]=?, [count]=?, [os]=?, [memory]=?, [cpu]=? WHERE [id]=?";
			statement = connection.prepareStatement(sql);
			statement.setString(1, name);
			statement.setInt(2, department_id);
			statement.setInt(3, count);
			statement.setString(4, os);
			statement.setString(5, memory);
			statement.setString(6, cpu);
			statement.setInt(7, id);
			statement.executeUpdate();
		}finally{
			if(statement!=null) statement.close();
			if(connection!=null) connection.close();
		}
	}
	public static void update(String image,int id) throws Exception{
		Connection connection = null;
		PreparedStatement statement = null;
		try{
			connection = DB.getConnection();
			String sql ="UPDATE [equip] SET [image]=? WHERE [id]=?";
			statement = connection.prepareStatement(sql);
			statement.setString(1,image);
			statement.setInt(2 , id);
			statement.executeUpdate();
		}finally{
			if(statement!=null) statement.close();
			if(connection!=null) connection.close();
		}
	}
	public static void delete(int id) throws Exception{
		Connection connection = null;
		PreparedStatement statement = null;
		try{
			connection = DB.getConnection();
			String sql = "DELETE FROM[Equip] WHERE [id]=?";
			statement = connection.prepareStatement(sql);
			statement.setInt(1, id);
			statement.executeUpdate();
		}finally{
			if(statement!=null) statement.close();
			if(connection!=null) connection.close();
		}
	}
}
