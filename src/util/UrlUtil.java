package util;

import javax.servlet.http.HttpServletRequest;

public class UrlUtil {

	public static String getFullURL(HttpServletRequest request){
		StringBuffer url = request.getRequestURL();
		String queryString = request.getQueryString();
		if(queryString !=null) url.append('?').append(queryString);
		return url.toString();
	}
}
