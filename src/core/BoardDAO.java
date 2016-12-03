package core;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import org.apache.catalina.connector.Request;

public class BoardDAO {

	private static Board makeBoard(ResultSet resultSet) throws SQLException {
		Board board = new Board();
		board.setBoard_id(resultSet.getInt("board_id"));
		board.setBoard_message(resultSet.getString("board_message"));
		board.setUser_id(resultSet.getString("user_id"));
		board.setDate(resultSet.getString("date"));
		board.setTitle(resultSet.getString("title"));
		board.setCount(resultSet.getInt("count"));
		return board;

	}

	public static ArrayList<Board> selectAll() throws Exception {
		Connection connection = null;
		PreparedStatement statement = null;
		ResultSet resultset = null;
		try {
			connection = DB.getConnection();
			String sql = "select * from[board] order by [date] desc,[board_id] desc ";
			statement = connection.prepareStatement(sql);
			resultset = statement.executeQuery();
			ArrayList<Board> list = new ArrayList<Board>();
			while (resultset.next()) {
				list.add(makeBoard(resultset));
			}
			return list;
		} finally {
			if (resultset != null)
				resultset.close();
			if (statement != null)
				statement.close();
			if (connection != null)
				connection.close();
		}
	}

	public static ArrayList<Board> selectState() throws Exception {
		Connection connection = null;
		PreparedStatement statement = null;
		ResultSet resultset = null;
		try {
			connection = DB.getConnection();
			String sql = "select * from[board] b join [user] u on b.user_id=u.id where state_id=4 order by [board_id] desc";
			statement = connection.prepareStatement(sql);
			resultset = statement.executeQuery();
			ArrayList<Board> list = new ArrayList<Board>();
			while (resultset.next()) {
				list.add(makeBoard(resultset));
			}
			return list;
		} finally {
			if (resultset != null)
				resultset.close();
			if (statement != null)
				statement.close();
			if (connection != null)
				connection.close();
		}
	}

	public static Board selectById(int id) throws Exception {
		Board board = null;
		Connection connection = null;
		PreparedStatement statement = null;
		ResultSet resultSet = null;
		try {
			connection = DB.getConnection();
			String sql = "select * from [board] where [board_id]=?";
			statement = connection.prepareStatement(sql);
			statement.setInt(1, id);
			resultSet = statement.executeQuery();
			if (resultSet.next())
				board = makeBoard(resultSet);
		} finally {
			if (resultSet != null)
				resultSet.close();
			if (statement != null)
				statement.close();
			if (connection != null)
				connection.close();
		}
		return board;
	}

	public static Board selectByUser_id(String id) throws Exception {
		Board board = null;
		Connection connection = null;
		PreparedStatement statement = null;
		ResultSet resultSet = null;
		try {
			connection = DB.getConnection();
			String sql = "select * from [board] where [user_id]=?";
			statement = connection.prepareStatement(sql);
			statement.setString(1, id);
			resultSet = statement.executeQuery();
			if (resultSet.next())
				board = makeBoard(resultSet);
		} finally {
			if (resultSet != null)
				resultSet.close();
			if (statement != null)
				statement.close();
			if (connection != null)
				connection.close();
		}
		return board;
	}

	public static void updateCount(int board_id) throws Exception {

		Connection connection = null;
		PreparedStatement statement = null;

		try {
			connection = DB.getConnection();
			String sql = "UPDATE [board] SET [count]=[count]+1 WHERE [board_id]=?";
			statement = connection.prepareStatement(sql);
			statement.setInt(1, board_id);
			statement.executeUpdate();

		} finally {

			if (statement != null)
				statement.close();
			if (connection != null)
				connection.close();
		}
	}

	public static void insert(Board board) throws Exception {
		Connection connection = null;
		PreparedStatement statement = null;
		try {
			connection = DB.getConnection();
			String sql = "insert [board]([board_message],[user_id],[date],[title],[count]) values(?,?,?,?,?)";
			statement = connection.prepareStatement(sql);
			System.out.println(board.getBoard_message());
			statement.setString(1, board.getBoard_message());
			statement.setString(2, board.getUser_id());
			statement.setString(3, board.getDate());
			statement.setString(4, board.getTitle());
			statement.setInt(5, 0);
			statement.executeUpdate();

		} finally {

			if (statement != null)
				statement.close();
			if (connection != null)
				connection.close();
		}
	}

	public static ArrayList<Board> selectPage(int currentPage, int pageSize) throws Exception {
		Connection connection = null;
		PreparedStatement statement = null;
		ResultSet resultSet = null;
		try {
			connection = DB.getConnection();
			String sql = "exec board_page ?,?";
			statement = connection.prepareStatement(sql);
			statement.setInt(1, currentPage);
			statement.setInt(2, pageSize);
			resultSet = statement.executeQuery();
			ArrayList<Board> list = new ArrayList<Board>();
			while (resultSet.next()) {
				list.add(makeBoard(resultSet));
			}
			return list;
		} finally {
			if (resultSet != null)
				resultSet.close();
			if (statement != null)
				statement.close();
			if (connection != null)
				connection.close();
		}
	}

	public static ArrayList<Board> title_search(String title, int currentPage, int pageSize) throws Exception {
		Connection connection = null;
		PreparedStatement statement = null;
		ResultSet resultSet = null;
		try {
			connection = DB.getConnection();
			String sql = "exec board_search ?,?,?";
			statement = connection.prepareStatement(sql);
			statement.setString(1, title);
			statement.setInt(2, currentPage);
			statement.setInt(3, pageSize);
			resultSet = statement.executeQuery();
			ArrayList<Board> list = new ArrayList<Board>();
			while (resultSet.next()) {
				list.add(makeBoard(resultSet));
			}
			return list;
		} finally {
			if (resultSet != null)
				resultSet.close();
			if (statement != null)
				statement.close();
			if (connection != null)
				connection.close();
		}
	}

	public static ArrayList<Board> id_search(String id, int currentPage, int pageSize) throws Exception {
		Connection connection = null;
		PreparedStatement statement = null;
		ResultSet resultSet = null;
		try {
			connection = DB.getConnection();
			String sql = "exec board_search_user ?,?,?";
			statement = connection.prepareStatement(sql);
			statement.setString(1, id);
			statement.setInt(2, currentPage);
			statement.setInt(3, pageSize);
			resultSet = statement.executeQuery();
			ArrayList<Board> list = new ArrayList<Board>();
			while (resultSet.next()) {
				list.add(makeBoard(resultSet));
			}
			return list;
		} finally {
			if (resultSet != null)
				resultSet.close();
			if (statement != null)
				statement.close();
			if (connection != null)
				connection.close();
		}
	}

	public static int getRecordCount() throws Exception {

		int count = 0;
		Connection connection = null;
		PreparedStatement statement = null;
		ResultSet resultSet = null;
		try {
			connection = DB.getConnection();
			String sql = "SELECT COUNT(*) FROM [board] b join [user] u on b.user_id=u.id where state_id!=4";
			statement = connection.prepareStatement(sql);
			resultSet = statement.executeQuery();
			if (resultSet.next())
				count = resultSet.getInt(1);
		} finally {
			if (resultSet != null)
				resultSet.close();
			if (statement != null)
				statement.close();
			if (connection != null)
				connection.close();
		}
		return count;
	}

	public static int getRecordCountBy(String title) throws Exception {
		int count = 0;
		Connection connection = null;
		PreparedStatement statement = null;
		ResultSet resultSet = null;
		try {
			connection = DB.getConnection();
			String sql = "SELECT COUNT(*) FROM [board] where CHARINDEX(?,[title])=1";
			statement = connection.prepareStatement(sql);
			statement.setString(1, title);
			resultSet = statement.executeQuery();
			if (resultSet.next())
				count = resultSet.getInt(1);
		} finally {
			if (resultSet != null)
				resultSet.close();
			if (statement != null)
				statement.close();
			if (connection != null)
				connection.close();

		}
		return count;

	}

	public static int getRecordCountById(String id) throws Exception {
		int count = 0;
		Connection connection = null;
		PreparedStatement statement = null;
		ResultSet resultSet = null;

		try {
			connection = DB.getConnection();
			String sql = "SELECT COUNT(*) FROM [board] where CHARINDEX(?,[user_id])=1";
			statement = connection.prepareStatement(sql);
			statement.setString(1, id);
			resultSet = statement.executeQuery();
			if (resultSet.next())
				count = resultSet.getInt(1);
		} finally {
			if (resultSet != null)
				resultSet.close();
			if (statement != null)
				statement.close();
			if (connection != null)
				connection.close();
		}
		return count;
	}

	public static void deleteBoard(int id) throws Exception {
		Connection connection = null;
		PreparedStatement statement = null;
		try {
			connection = DB.getConnection();
			String sql = "DELETE FROM [board] WHERE [board_id] = ?";
			statement = connection.prepareStatement(sql);
			statement.setInt(1, id);
			statement.executeUpdate();
		} finally {
			if (statement != null)
				statement.close();
			if (connection != null)
				connection.close();
		}

	}

	public static void update(String id, String mss) throws Exception {
		Connection connection = null;
		PreparedStatement statement = null;
		try {
			connection = DB.getConnection();
			String sql = "update [board] set [board_message]=? where[board_id]=?";
			statement = connection.prepareStatement(sql);
			statement.setString(1, mss);
			statement.setInt(2, Integer.parseInt(id));
			statement.executeUpdate();
		} finally {
			if (statement != null)
				statement.close();
			if (connection != null)
				connection.close();
		}

	}
}
