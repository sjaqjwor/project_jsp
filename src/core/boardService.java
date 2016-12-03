package core;

import java.io.UnsupportedEncodingException;
import java.security.NoSuchAlgorithmException;
import java.util.Date;
import java.text.SimpleDateFormat;

import javax.servlet.http.HttpServletRequest;

public class boardService {
	public static Board makeBoard(HttpServletRequest request, String smt)
			throws UnsupportedEncodingException, NoSuchAlgorithmException {
		request.setCharacterEncoding("UTF-8");
		Board board = new Board();

		String s = smt;

		if (s == null)
			s = "";
		board.setBoard_message(s);

		s = request.getParameter("title");
		if (s == null)
			s = "";
		board.setTitle(s);

		s = request.getParameter("name");
		if (s == null)
			s = "";
		board.setUser_id(s);

		s = request.getParameter("date");
		Date date = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("YYYY.MM.dd HH:mm");
		s = sdf.format(date);
		if (s == null)
			s = "";
		board.setDate(s);

		return board;
	}

	public static Board makeBoard() {
		Board board = new Board();
		board.setTitle("");
		board.setBoard_message("");
		return board;
	}
}
