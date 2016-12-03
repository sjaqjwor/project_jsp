
package core;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

public class DepartmentDAO {

	private static Department makeDepartment(ResultSet resultSet) throws SQLException{
		Department department = new Department();
		department.setId(resultSet.getInt("id"));
		department.setName(resultSet.getString("name"));
		return department;
	}
	
	public static Department selectById(int id) throws Exception{
		Department department=null;
		Connection connection = null;
		PreparedStatement statement = null;
		ResultSet resultSet= null;
		try{
			connection=DB.getConnection();
			String sql = "SELECT * FROM[department] WHERE[id]=?";
			statement=connection.prepareStatement(sql);
			statement.setInt(1, id);
			resultSet=statement.executeQuery();
			if(resultSet.next()) department = makeDepartment(resultSet);
		}finally{
			if(resultSet!=null) resultSet.close();
			if(statement!=null) statement.close();
			if(connection!=null) connection.close();
		}
		return department;
	}
	
	public static Department selectByName(String name) throws Exception{
		Department department=null;
		Connection connection=null;
		PreparedStatement statement=null;
		ResultSet resultSet= null;
		try{
			connection=DB.getConnection();
			String sql="SELECT * FROM[department] WHERE[name]=?";
			statement=connection.prepareStatement(sql);
			statement.setString(1, name);
			resultSet=statement.executeQuery();
			if(resultSet.next()) department = makeDepartment(resultSet);
		}finally{
			if(resultSet!=null) resultSet.close();
			if(statement!=null) statement.close();
			if(connection!=null) connection.close();
		}
		return department;
	}

	public static ArrayList<Department> selectAll() throws Exception {
        Connection connection = null;
        PreparedStatement statement = null;
        ResultSet resultSet = null;        
        try {
            connection = DB.getConnection();
            String sql = "SELECT * FROM [Department]"; 
            statement = connection.prepareStatement(sql);
            resultSet = statement.executeQuery();
            ArrayList<Department> list = new ArrayList<Department>();            
            while (resultSet.next()) 
                list.add(makeDepartment(resultSet));
            return list;            
        } finally {
            if (resultSet != null) resultSet.close();
            if (statement != null) statement.close();
            if (connection != null) connection.close();
        }
    }
}
