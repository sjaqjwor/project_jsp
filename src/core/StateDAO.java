package core;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class StateDAO {

	private static State makeState(ResultSet resultSet) throws SQLException{
		State state = new State();
		state.setId(resultSet.getInt("id"));
		state.setName(resultSet.getString("name"));
		return state;
	}
	
	public static State selectById(int id) throws Exception{
		State state = new State();
		Connection connection = null;
		PreparedStatement statement = null;
		ResultSet resultSet = null;
		try{
			connection=DB.getConnection();
			String sql = "SELECT * FROM[state] WHERE[id]=?";
			statement=connection.prepareStatement(sql);
			statement.setInt(1, id);
			resultSet=statement.executeQuery();
			if(resultSet.next()) state= makeState(resultSet);
		}finally{
			if(resultSet!=null) resultSet.close();
			if(statement!=null) statement.close();
			if(connection!=null) connection.close();
		}
		return state;
	}
	
	public static State selectByName(String name) throws Exception{
		State state = new State();
		Connection connection = null;
		PreparedStatement statement= null;
		ResultSet resultSet = null;
		try{
			connection=DB.getConnection();
			String sql="SELECT * FROM[state] WHERE [name]=?";
			statement=connection.prepareStatement(sql);
			statement.setString(1, name);
			resultSet=statement.executeQuery();
			if(resultSet.next()) state = makeState(resultSet);
		}finally{
			if(resultSet!=null) resultSet.close();
			if(statement!=null) statement.close();
			if(connection!=null) connection.close();
		}
		return state;
	}
	
	public static ArrayList<State> selectAll() throws Exception{
		Connection connection = null;
		PreparedStatement statement=null;
		ResultSet resultSet = null;
		try{
			connection=DB.getConnection();
			String sql = "SELECT * FROM[State]";
			statement=connection.prepareStatement(sql);
			resultSet=statement.executeQuery();
			ArrayList<State> list = new ArrayList<State>();
			while(resultSet.next()){
				list.add(makeState(resultSet));
			}
			return list;
		}finally{
			 if (resultSet != null) resultSet.close();
	            if (statement != null) statement.close();
	            if (connection != null) connection.close();
		}
	}
}
