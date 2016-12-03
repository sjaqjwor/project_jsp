package core;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DB {

	private static final String JDBC_DIRVER_NAME="com.microsoft.sqlserver.jdbc.SQLServerDriver";
	private static final String DB_URL="jdbc:sqlserver://127.0.0.1;databaseName=Equipment";
	private static final String USER_ID="sa";
	private static final String USER_PASSWORD="test123";
	
	public static Connection getConnection() throws ClassNotFoundException, SQLException{
		Class.forName(JDBC_DIRVER_NAME);
		Connection connection = DriverManager.getConnection(DB_URL,USER_ID,USER_PASSWORD);
		return connection;
	}
}
