package core;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;


public class UserDAO {

	public static User makeUser(ResultSet resultSet) throws Exception{
		User user = new User();
		user.setId(resultSet.getString("id"));
		user.setPassword(resultSet.getString("password"));
		user.setBirth(resultSet.getString("birth"));
		user.setPhoneNumber(resultSet.getString("phoneNumber"));
		user.setDepartment_id(resultSet.getInt("department_id"));
		user.setState_id(resultSet.getInt("state_id"));
		user.setEmail(resultSet.getString("email"));
		user.setName(resultSet.getString("name"));
		user.setEquip_rent_id(resultSet.getInt("equip_rent_id"));
		user.setEquip_rent_state(resultSet.getInt("equip_rent_state"));
		user.setEquip_request_day(resultSet.getString("equip_request_day"));
		return user;
	}
	
	public static User selectById(String id) throws Exception{
        String sql = "SELECT * FROM [User] WHERE [id] = ?";
        try (Connection con = DB.getConnection();
             PreparedStatement stmt= con.prepareStatement(sql)) {
            stmt.setString(1, id);
            try (ResultSet rs = stmt.executeQuery()) {
                return rs.next() ? makeUser(rs) : null;
            }
        }

	}
	
	public static ArrayList<User> selectByPassword(String password) throws Exception{
		Connection connection = null;
		PreparedStatement statement=null;
		ResultSet resultSet = null;
		try{
			connection = DB.getConnection();
			String sql="SELECT * FROM [user] WHERE CHARINDEX(?, [password]) = 1";
			statement=connection.prepareStatement(sql);
			statement.setString(1, password);
			resultSet=statement.executeQuery();
			ArrayList<User> list = new ArrayList<User>();
			while(resultSet.next())
				list.add(makeUser(resultSet));
			return list;
		}finally{
			if(resultSet!=null) resultSet.close();
			if(statement!=null) statement.close();
			if(connection!=null) connection.close();
		}
	}
	
	public static ArrayList<User> selectByBirth(String birth) throws Exception{
		Connection connection =null;
		PreparedStatement statement = null;
		ResultSet resultSet = null;
		try{
			connection=DB.getConnection();
			String sql="SELECT * FROM[user] WHERE CHARINDEX(?, [birth]) = 1";
			statement=connection.prepareStatement(sql);
			statement.setString(1, birth);
			resultSet=statement.executeQuery();
			ArrayList<User> list = new ArrayList<User>();
			while(resultSet.next())
				list.add(makeUser(resultSet));
			return list;
		}finally{
			if(resultSet!=null) resultSet.close();
			if(statement!=null) statement.close();
			if(connection!=null) connection.close();
		}
	}
	
	public static User selectByPhoneNumber(String phoneNumber) throws Exception{
		User user=null;
		Connection connection=null;
		PreparedStatement statement=null;
		ResultSet resultSet = null;
		try{
			connection= DB.getConnection();
			String sql="SELECT * FROM[user] WHERE CHARINDEX(?,[phoneNumber])=1";
			statement=connection.prepareStatement(sql);
			statement.setString(1, phoneNumber);
			resultSet=statement.executeQuery();
			if(resultSet.next()) user = makeUser(resultSet);
		}finally{
			if(resultSet!=null) resultSet.close();
			if(statement!=null) statement.close();
			if(connection!=null) connection.close();
		}
		return user;
	}
	
	public static User selectByEmail(String email) throws Exception{
		User user = null;
		Connection connection = null;
		PreparedStatement statement = null;
		ResultSet resultSet = null;
		try{
			connection = DB.getConnection();
			String sql="SELECT * FROM[user] WHERE [email]=?";
			statement=connection.prepareStatement(sql);
			statement.setString(1,email);
			resultSet=statement.executeQuery();
			if(resultSet.next()) user = makeUser(resultSet);
		}finally{
			if(resultSet!=null) resultSet.close();
			if(statement!=null) statement.close();
			if(connection!=null) connection.close();
		}
		return user;
	}
	
	public static ArrayList<User> selectByDepartment_id(int department_id) throws Exception{
		Connection connection=null;
		PreparedStatement statement =null;
		ResultSet resultSet = null;
		try{
			connection=DB.getConnection();
			String sql="SELECT * FROM[user] WHERE [department_id]=?";
			statement=connection.prepareStatement(sql);
			statement.setInt(1, department_id);
			resultSet=statement.executeQuery();
			ArrayList<User> list = new ArrayList<User>();
			while(resultSet.next())
				list.add(makeUser(resultSet));
			return list;
		}finally{
			if(resultSet!=null) resultSet.close();
			if(statement!=null) statement.close();
			if(connection!=null) connection.close();
		}
	}
	
	public static ArrayList<User> selectByState_id(int state_id) throws Exception{
		Connection connection = null;
		PreparedStatement statement = null;
		ResultSet resultSet = null;
		try{
			connection=DB.getConnection();
			String sql="SELECT * FROM[user] WHERE [state_id]=?";
			statement=connection.prepareStatement(sql);
			statement.setInt(1, state_id);
			resultSet=statement.executeQuery();
			ArrayList<User> list = new ArrayList<User>();
			while(resultSet.next())
				list.add(makeUser(resultSet));
			return list;
		}finally{
			if(resultSet!=null) resultSet.close();
			if(statement!=null) statement.close();
			if(connection!=null) connection.close();
		}
	}
	
	public static ArrayList<User> selectAll() throws Exception{
		Connection connection = DB.getConnection();
		PreparedStatement statement = null;
		ResultSet resultSet = null;
		try{
			connection=DB.getConnection();
			String sql="SELECT * FROM[user]";
			statement=connection.prepareStatement(sql);
			resultSet=statement.executeQuery();
			ArrayList<User> list = new ArrayList<User>();
			while(resultSet.next())
				list.add(makeUser(resultSet));
			return list;
		}finally{
			if(resultSet!=null) resultSet.close();
			if(statement!=null) statement.close();
			if(connection!=null) connection.close();
		}
	}
	
	public static void insert(User user) throws Exception{
		Connection connection =null;
		PreparedStatement statement=null;
		try{
			connection = DB.getConnection();
			String sql = "INSERT [user]([id],[password],[birth],[phoneNumber],[department_id],[state_id],[name],[email],[equip_rent_state]) VALUES(?,?,?,?,?,?,?,?,?)";
			statement=connection.prepareStatement(sql);
			statement.setString(1,user.getId());
			statement.setString(2,UserService.encryptPasswd(user.getPassword()));
			statement.setString(3,user.getBirth());
			statement.setString(4,user.getPhoneNumber());
			statement.setInt(5,user.getDepartment_id());
			statement.setInt(6,user.getState_id());
			statement.setString(7,user.getName());
			statement.setString(8, user.getEmail());
			statement.setInt(9, 4);
			statement.executeUpdate();
		} finally{
			if(statement !=null) statement.close();
			if(connection !=null) connection.close();
		}
	}
	
	public static User makeUser(){
		User user = new User();
		user.setId("");
		user.setPassword("");
		user.setBirth("");
		user.setPhoneNumber("");
		user.setName("");
		return user;
	}
	
	public static void updatePasswd(String id, String password) throws Exception{
		Connection connection = null;
		PreparedStatement statement=null;
		ResultSet resultSet=null;
		try{
			connection=DB.getConnection();
			String sql="UPDATE [user] SET [password]=? WHERE [id]=?";
			statement=connection.prepareStatement(sql);
			statement.setString(1, password);
			statement.setString(2, id);
			statement.executeUpdate();
		}finally{
			if(resultSet!=null) resultSet.close();
			if(statement!=null) statement.close();
			if(connection!=null) connection.close();
		}
	}
	
	public static void update(User user) throws Exception{
		Connection connection = null;
		PreparedStatement statement = null;
		try{
			connection = DB.getConnection();
			String sql = "update [user] set [password]=?,[phoneNumber]=?,[department_id]=?,[state_id]=?,[email]=? where[id]=?";
			statement=connection.prepareStatement(sql);
			statement.setString(1,user.getPassword());
			statement.setString(2,user.getPhoneNumber());
			statement.setInt(3,user.getDepartment_id());
			statement.setInt(4, user.getState_id());
			statement.setString(5, user.getEmail());
			statement.setString(6, user.getId());
			statement.executeUpdate();
		}finally{
			if(statement !=null) statement.close();
			if(connection !=null) connection.close();
		}
	}
	
	public static ArrayList<User> selectByEquip_rent(int rent_id) throws Exception{
		Connection connection = null;
		PreparedStatement statement = null;
		ResultSet resultSet = null;
		try{
			connection =DB.getConnection();
			String sql="SELECT * from [user] WHERE [equip_rent] IN(SELECT * FROM [equip] WHERE [id]=[rent_id])=?";
			statement=connection.prepareStatement(sql);
			statement.setInt(1, rent_id);
			resultSet=statement.executeQuery();
			ArrayList<User> list = new ArrayList<User>();
			while(resultSet.next())
				list.add(makeUser(resultSet));
			return list;
		}finally{
			if(resultSet != null) resultSet.close();
			if(statement != null) statement.close();
			if(connection != null) connection.close();
		}
	}
	
	public static ArrayList<User> selectByEquip_rent_id(int equip_rent_id) throws Exception{
		Connection connection = null;
		PreparedStatement statement = null;
		ResultSet resultSet = null;
		try{
			connection = DB.getConnection();
			String sql="SELECT * FROM[user] where [equip_rent_id]=?";
			statement = connection.prepareStatement(sql);
			statement.setInt(1, equip_rent_id);
			resultSet= statement.executeQuery();
			ArrayList<User> list = new ArrayList<User>();
			while(resultSet.next())
				list.add(makeUser(resultSet));
			return list;
		}finally{
			if(resultSet!=null) resultSet.close();
			if(statement != null) statement.close();
			if(connection !=null ) connection.close();
		}
	}
	
	public static ArrayList<User> selectByEquip_rent_state(int equip_rent_state) throws Exception{
		Connection connection = null;
		PreparedStatement statement = null;
		ResultSet resultSet = null;
		try{
			connection = DB.getConnection();
			String sql = "SELECT * FROM [user] where [equip_rent_state]=?";
			statement = connection.prepareStatement(sql);
			statement.setInt(1, equip_rent_state);
			resultSet = statement.executeQuery();
			ArrayList<User> list = new ArrayList<User>();
			while(resultSet.next())
				list.add(makeUser(resultSet));
			return list;
		}finally{
			if(resultSet != null) resultSet.close();
			if(statement !=null) statement.close();
			if(connection !=null) connection.close();
		}
	}
	
	public static ArrayList<User> selectByEquip_rent_day(String equip_rent_day) throws Exception{
		Connection connection = null;
		PreparedStatement statement = null;
		ResultSet resultSet = null;
		String sql = "SELECT * FROM[user] where [eqip_rent_day]=?";
		try{
			connection = DB.getConnection();
			statement = connection.prepareStatement(sql);
			statement.setString(1, equip_rent_day);
			resultSet=statement.executeQuery();
			ArrayList<User> list = new ArrayList<User>();
			while(resultSet.next())
				list.add(makeUser(resultSet));
			return list;
		}finally{
			if(resultSet!=null) resultSet.close();
			if(statement!=null) statement.close(); 
			if(connection!=null) connection.close();
		}
	}
	
	public static ArrayList<User> selectByEquip_return_day(String equip_return_day) throws Exception{
		Connection connection = null;
		PreparedStatement statement = null;
		ResultSet resultSet = null;
		String sql = "SELECT * FROM[user] where [equip_rent_day]=?";
		try{
			connection = DB.getConnection();
			statement = connection.prepareStatement(sql);
			statement.setString(1,equip_return_day);
			resultSet=statement.executeQuery();
			ArrayList<User> list = new ArrayList<User>();
			while(resultSet.next())
				list.add(makeUser(resultSet));
			return list;
		}finally{
			if(resultSet!=null) resultSet.close();
			if(statement!=null) statement.close();
			if(connection !=null) connection.close();
		}
	}
	
	public static void rent(String id, int equip_rent_id) throws Exception{
		Connection connection = null;
		PreparedStatement statement = null;
		try{
			connection = DB.getConnection();
			String sql="update [user] set [equip_rent_id]=?,[equip_rent_state]=2,[equip_request_day]=? where [id]=?";
			statement=connection.prepareStatement(sql);
			statement.setInt(1,equip_rent_id);
			statement.setString(2,UserService.rent_day());
			statement.setString(3, id);
			statement.executeUpdate();
		}finally{
			if(statement!=null) statement.close();
			if(connection!=null) connection.close();
		}
	}
	
	public static void turn_in(String id) throws Exception{
		Connection connection = null;
		PreparedStatement statement = null;
		try{
			connection=DB.getConnection();
			String sql="update [user] set [equip_rent_id]=null,[equip_rent_state]=4 where [id]=?";
			statement=connection.prepareStatement(sql);
			statement.setString(1,id);
			statement.executeUpdate();
		}finally{
			if(statement!=null) statement.close();
			if(connection!=null) connection.close();
		}
	}
	
	public static void blackList_approve(String id) throws Exception{
		Connection connection = null;
		PreparedStatement statement = null;
		try{
			connection = DB.getConnection();
			String sql="update [user] set [equip_rent_state]=3 where [id]=?";
			statement = connection.prepareStatement(sql);
			statement.setString(1,id);
			statement.executeUpdate();
		}finally{
			if(statement!=null) statement.close();
			if(connection!=null) connection.close();
		}
	}
	
	public static void blackList_cancel(String id) throws Exception{
		Connection connection = null;
		PreparedStatement statement  = null;
		try{
			connection = DB.getConnection();
			String sql="update [user] set [equip_rent_state]=4 where [id]=?";
			statement = connection.prepareStatement(sql);
			statement.setString(1, id);
			statement.executeUpdate();
		}finally{
			if(statement!=null) statement.close();
			if(connection!=null) connection.close();
		}
	}
	public static void approve_rent(String id) throws Exception{
		Connection connection = null;
		PreparedStatement statement = null;
		try{
			connection = DB.getConnection();
			String sql="update [user] set [equip_rent_state]=1 where [id]=?";
			statement=connection.prepareStatement(sql);
			statement.setString(1, id);
			statement.executeUpdate();
		}finally{
			if(statement!=null) statement.close();
			if(connection!=null) connection.close();
		}
	}
	
	public static void refuse(String id) throws Exception{
		Connection connection = null;
		PreparedStatement statement = null;
		try{
			connection = DB.getConnection();
			String sql = "update [user] set [equip_rent_state]=4 , [equip_rent_id]=null,[equip_request_day]=null where [id]=?";
			statement=connection.prepareStatement(sql);
			statement.setString(1, id);
			statement.executeUpdate();
		}finally{
			if(statement!=null) statement.close();
			if(connection!=null) connection.close();
		}
	}
	
	public static ArrayList<User> selectPage (int currentPage, int pageSize) throws Exception{
		Connection connection = null;
		PreparedStatement statement = null;
		ResultSet resultSet = null;
		try{
			connection = DB.getConnection();
			String sql = "EXEC userSelectPage ?,?";
			statement = connection.prepareStatement(sql);
			statement.setInt(1, currentPage);
			statement.setInt(2, pageSize);
			resultSet = statement.executeQuery();
			ArrayList<User> list = new ArrayList<User>();
			while(resultSet.next())
				list.add(makeUser(resultSet));
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
			String sql="SELECT COUNT(*) FROM [user]";
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
	
	public static int getReocrdCountByEquip_state_id(int equip_state,String id) throws Exception{
		int count =0;
		Connection connection = null;
		PreparedStatement statement = null;
		ResultSet resultSet = null;
		try{
			connection = DB.getConnection();
			String sql= "SELECT COUNT(*) FROM [user] WHERE [equip_rent_state]=? and CHARINDEX(?,[id])=1";
			statement = connection.prepareStatement(sql);
			statement.setInt(1, equip_state);
			statement.setString(2, id);
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
	
	public static int getRecordCountByEquip_state_name(int equip_state,String name) throws Exception{
		int count =0 ;
		Connection connection = null;
		PreparedStatement statement = null;
		ResultSet resultSet = null;
		try{
			connection = DB.getConnection();
			String sql = "SELECT COUNT(*) FROM [user] WHERE [equip_rent_state]=? and CHARINDEX(?,[name])=1";
			statement = connection.prepareStatement(sql);
			statement.setInt(1, equip_state);
			statement.setString(2, name);
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
	
	public static int getRecordCountByEquip_state_department(int equip_state, String department) throws Exception{
		int count =0;
		Connection connection = null;
		PreparedStatement statement = null;
		ResultSet resultSet = null;
		try{
			connection = DB.getConnection();
			String sql ="SELECT COUNT(*) FROM [user] WHERE [equip_rent_state]=? and [department_id]=(select [id] from[department] where charindex(?,[name])=1)";
			statement = connection.prepareStatement(sql);
			statement.setInt(1, equip_state);
			statement.setString(2, department);
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
	public static int getRecordCountById(String id) throws Exception{
		int count=0;
		Connection connection = null;
		PreparedStatement statement = null;
		ResultSet resultSet = null;
		try{
			connection = DB.getConnection();
			String sql =" SELECT COUNT(*) FROM [user] WHERE CHARINDEX(?,[id])=1";
			statement = connection.prepareStatement(sql);
			statement.setString(1, id);
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
	
	public static int getRecordCountByName(String name) throws Exception{
		int count =0 ;
		Connection connection = null;
		PreparedStatement statement = null;
		ResultSet resultSet = null;
		try{
			connection = DB.getConnection();
			String sql ="SELECT COUNT(*) FROM [user] WHERE CHARINDEX(?,[name])=1";
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
		int count =0;
		Connection connection = null;
		PreparedStatement statement = null;
		ResultSet resultSet = null;
		try{
			connection = DB.getConnection();
			String sql ="SELECT COUNT(*) FROM[user] WHERE department_id=(select [id] from [department] where charindex(?,[name])=1)";
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
	public static ArrayList<User> selectPage(int currentPage, int pageSize, int equip_rent_state) throws Exception{
		Connection connection = null;
		PreparedStatement statement = null;
		ResultSet resultSet = null;
		try{
			connection = DB.getConnection();
			String sql="EXEC userSelectByequip_rent_state ?,?,?";
			statement = connection.prepareStatement(sql);
			statement.setInt(1, currentPage);
			statement.setInt(2, pageSize);
			statement.setInt(3, equip_rent_state);
			resultSet = statement.executeQuery();
			ArrayList<User> list = new ArrayList<User>();
			while(resultSet.next())
				list.add(makeUser(resultSet));
			return list;
		}finally{
			if(resultSet!=null) resultSet.close();
			if(statement!=null) statement.close();
			if(connection!=null) connection.close();
		}
	}
	
	public static ArrayList<User> selectpage_id(int currentPage, int pageSize, String id, int equip_rent_state) throws Exception{
		Connection connection = null;
		PreparedStatement statement = null;
		ResultSet resultSet = null;
		try{
			connection = DB.getConnection();
			String sql="EXEC userSelectEId ?,?,?,?";
			statement = connection.prepareStatement(sql);
			statement.setInt(1, currentPage);
			statement.setInt(2, pageSize);
			statement.setString(3, id);
			statement.setInt(4, equip_rent_state);
			resultSet = statement.executeQuery();
			ArrayList<User> list = new ArrayList<User>();
			while(resultSet.next())
				list.add(makeUser(resultSet));
			return list;
		}finally{
			if(resultSet!=null) resultSet.close();
			if(statement!=null) statement.close();
			if(connection!=null) connection.close();
		}
	}
	
	public static ArrayList<User> selectpage_name(int currentPage, int pageSize, String name, int equip_rent_state) throws Exception{
		Connection connection = null;
		PreparedStatement statement = null;
		ResultSet resultSet = null;
		try{
			connection = DB.getConnection();
			String sql="EXEC userSelectName ?,?,?,?";
			statement = connection.prepareStatement(sql);
			statement.setInt(1, currentPage);
			statement.setInt(2, pageSize);
			statement.setString(3, name);
			statement.setInt(4, equip_rent_state);
			resultSet = statement.executeQuery();
			ArrayList<User> list = new ArrayList<User>();
			while(resultSet.next())
				list.add(makeUser(resultSet));
			return list;
		}finally{
			if(resultSet!=null) resultSet.close();
			if(statement!=null) statement.close();
			if(connection!=null) connection.close();
		}
	}
	
	public static ArrayList<User> selectpage_department(int currentPage, int pageSize, String department, int equip_rent_state) throws Exception{
		Connection connection = null;
		PreparedStatement statement = null;
		ResultSet resultSet = null;
		try{
			connection = DB.getConnection();
			String sql="EXEC userSelectDepartment ?,?,?,?";
			statement = connection.prepareStatement(sql);
			statement.setInt(1, currentPage);
			statement.setInt(2, pageSize);
			statement.setString(3, department);
			statement.setInt(4, equip_rent_state);
			resultSet = statement.executeQuery();
			ArrayList<User> list = new ArrayList<User>();
			while(resultSet.next())
				list.add(makeUser(resultSet));
			return list;
		}finally{
			if(resultSet!=null) resultSet.close();
			if(statement!=null) statement.close();
			if(connection!=null) connection.close();
		}
	}
	
	public static ArrayList<User> selectUserAll(int currentPage, int pageSize, String id) throws Exception{
		Connection connection = null;
		PreparedStatement statement = null;
		ResultSet resultSet = null;
		try{
			connection = DB.getConnection();
			String sql="EXEC selectUserName ?,?,?";
			statement = connection.prepareStatement(sql);
			statement.setInt(1, currentPage);
			statement.setInt(2, pageSize);
			statement.setString(3, id);
			resultSet = statement.executeQuery();
			ArrayList<User> list = new ArrayList<User>();
			while(resultSet.next())
				list.add(makeUser(resultSet));
			return list;
		}finally{
			if(resultSet!=null) resultSet.close();
			if(statement!=null) statement.close();
			if(connection!=null) connection.close();
		}
	}
	
	public static ArrayList<User> selectUserName(int currentPage, int pageSize, String name) throws Exception{
		Connection connection = null;
		PreparedStatement statement = null;
		ResultSet resultSet = null;
		try{
			connection = DB.getConnection();
			String sql="EXEC selectUserName ?,?,?";
			statement = connection.prepareStatement(sql);
			statement.setInt(1, currentPage);
			statement.setInt(2, pageSize);
			statement.setString(3, name);
			resultSet = statement.executeQuery();
			ArrayList<User> list = new ArrayList<User>();
			while(resultSet.next())
				list.add(makeUser(resultSet));
			return list;
		}finally{
			if(resultSet!=null) resultSet.close();
			if(statement!=null) statement.close();
			if(connection!=null) connection.close();
		}
	}
	
	public static ArrayList<User> selectUserDepartment(int currentPage, int pageSize, String department_name) throws Exception{
		Connection connection = null;
		PreparedStatement statement = null;
		ResultSet resultSet = null;
		try{
			connection = DB.getConnection();
			String sql="EXEC selectUserDepartment ?,?,?";
			statement = connection.prepareStatement(sql);
			statement.setInt(1, currentPage);
			statement.setInt(2, pageSize);
			statement.setString(3, department_name);
			resultSet = statement.executeQuery();
			ArrayList<User> list = new ArrayList<User>();
			while(resultSet.next())
				list.add(makeUser(resultSet));
			return list;
		}finally{
			if(resultSet!=null) resultSet.close();
			if(statement!=null) statement.close();
			if(connection!=null) connection.close();
		}
	}
}
