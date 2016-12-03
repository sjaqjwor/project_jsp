package core;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.Locale;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.UnsupportedEncodingException;

public class UserService {
	  private static final String CURRENT_USER = "CURRENT_USER";

	    public static void login(HttpSession session, User user) throws Exception {
	        session.setAttribute(CURRENT_USER,  user);
	    }

	    public static void logout(HttpSession session) {
	        session.removeAttribute(CURRENT_USER);
	    }

	    public static User getCurrentUser(HttpSession session) {
	        return (User)session.getAttribute(CURRENT_USER);
	    }

	    public static String getCurrentUserName(HttpSession session) {
	        User user = (User)session.getAttribute(CURRENT_USER);
	        return user == null ? "손님" : user.getId();
	    }

	    public static boolean isCurrentUserLoggedIn(HttpSession session) {
	        return session.getAttribute(CURRENT_USER) != null;
	    }

	    public static String encryptPasswd(String passwd) throws NoSuchAlgorithmException {
	        MessageDigest md = MessageDigest.getInstance("MD5");
	        byte[] passBytes = passwd.getBytes();
	        md.reset();
	        byte[] digested = md.digest(passBytes);
	        StringBuffer sb = new StringBuffer();
	        for(int i=0;i<digested.length;i++)
	            sb.append(Integer.toHexString(0xff & digested[i]));
	        return sb.toString();
	    }

	    public static String makeTempPassword() {
	        String s = "a";
	        for (int i=0; i < 4; ++i)
	            s += (int)(Math.random() * 10) % 10;
	        return s;
	    }
	    
	    public static String BeforeInsert(User user) throws Exception{
			String s=user.getId();
			if(Util.isEmptyOrNull(s))
				return "아이디를 입력하세요";
			
			s=user.getPassword();
			if(Util.isEmptyOrNull(s))
				return "비밀번호을 입력하세요";
			
			s=user.getName();
			if(Util.isEmptyOrNull(s))
				return "이름을 입력하세요";
			
			s=user.getBirth();
			if(Util.isEmptyOrNull(s))
				return "생일을 입력하세요";
			s=user.getPhoneNumber();
			if(Util.isEmptyOrNull(s))
				return "연락처를 입력하세요";
			if(user.getState_id()==0)
				return "상태를 기입하세요";
			else if(user.getState_id()==5)
				return "잘못기입하셨습니다.";
			s=user.getEmail();
			if(Util.isEmptyOrNull(s))
				return "이메일을 입력하세요";
			
			s=user.getId();
			User user2 = UserDAO.selectById(s);
			if(user2 !=null)
				return "아이디가 중복 됩니다.";
			
			return null;
		}
	    public static String beforeInsert(Equip equip) throws Exception{
	    	
	    	String s = equip.getName();
	    	if(Util.isEmptyOrNull(s))
	    		return "기자재명을 입력하세요.";
	    	
	    	int s1 = equip.getDepartment_id();
	    	if(s1==0)
	    		return "학과를 선택하세요.";
	    	
	    	s1 = equip.getCount();
	    	if(s1==0)
	    		return "숫자를 정확히 입력하세요";
	    	
	    	s=equip.getOs();
	    	if(Util.isEmptyOrNull(s))
	    		return "OS를 입력하세요.";
	    	
	    	s=equip.getMemory();
	    	if(Util.isEmptyOrNull(s))
	    		return "메모리를 입력하세요.";
	    	
	    	s=equip.getCpu();
	    	if(Util.isEmptyOrNull(s))
	    		return "CPU를 입력하세요.";
	    	
	    	return null;
	    }
	    
	    public static String BeforeInsert2(User user) throws Exception{
			String s=user.getId();
			if(Util.isEmptyOrNull(s))
				return "아이디를 입력하세요";
			
			s=user.getPassword();
			if(Util.isEmptyOrNull(s))
				return "비밀번호을 입력하세요";
			
			s=user.getName();
			if(Util.isEmptyOrNull(s))
				return "이름을 입력하세요";
			
			s=user.getBirth();
			if(Util.isEmptyOrNull(s))
				return "생일을 입력하세요";
			s=user.getPhoneNumber();
			if(Util.isEmptyOrNull(s))
				return "연락처를 입력하세요";
			if(user.getState_id()==0)
				return "상태를 기입하세요";
			else if(user.getState_id()==5)
				return "잘못기입하셨습니다.";
			s=user.getEmail();
			if(Util.isEmptyOrNull(s))
				return "이메일을 입력하세요";
						
			return null;
		}
	    
	    public static Equip makeEquip(HttpServletRequest request) throws UnsupportedEncodingException, NoSuchAlgorithmException{
	    	request.setCharacterEncoding("UTF-8");
	    	Equip equip = new Equip();
	 
	    	String s = request.getParameter("name");
	    	if(s==null) s="";
	    	equip.setName(s);
	    	
	    	s=request.getParameter("memory");
	    	if(s==null) s="";
	    	equip.setMemory(s);
	    	
	    	s=request.getParameter("cpu");
	    	if(s==null) s="";
	    	equip.setCpu(s);
	    	
	    	s=request.getParameter("OS");
	    	if(s==null) s="";
	    	equip.setOs(s);
	    	
	    	s=request.getParameter("count");
	    	int s1=Util.parseInt(s, 0);
	    	equip.setCount(s1);
	    	
	    	s=request.getParameter("department_id");
	    	s1 = Util.parseInt(s,0);
	    	equip.setDepartment_id(s1);
	    	
	    	equip.setImage("default.jpg");
	    	
	    	return equip;
	    }
	    public static User makeUser(HttpServletRequest request) throws UnsupportedEncodingException, NoSuchAlgorithmException{
			request.setCharacterEncoding("UTF-8");
			User user = new User();
			
			String s = request.getParameter("id");
			if(s==null) s="";
			user.setId(s);
			
			s = request.getParameter("password");
			if(s==null) s="";
			user.setPassword(s);
			
			s = request.getParameter("birth");
			if(s==null) s="";
			user.setBirth(s);
			
			s = request.getParameter("phoneNumber");
			if(s==null) s="";
			user.setPhoneNumber(s);
			
			s = request.getParameter("department_id");
			if(s==null) s="";
			int dept = Util.parseInt(s, 0);
			user.setDepartment_id(dept);
			
			s = request.getParameter("state_id");
			int state=0;
			
			if(s.equals("professor123")){
				state=3;
			}
			else if(s.equals("worker123")){
				state=4;
			}
			else if(s.equals("재학생")){
				state=1;
			}
			else if(s.equals("휴학생")){
				state=2;
			}
			else
				state=5;
			user.setState_id(state);
			
			s = request.getParameter("name");
			if(s==null) s="";
			user.setName(s);
			
			s = request.getParameter("email");
			if(s==null) s="";
			user.setEmail(s);
			
			return user;
		}
	    public static String Overlap(User user) throws Exception{
			String s = user.getId();
			if(Util.isEmptyOrNull(s))
				return "아이디를 입력하세요";
			User user2 = UserDAO.selectById(s);
			if(user2 !=null)
				return "아이디가 중복 됩니다.";
			else
				return "사용가능합니다.";
			
		}
	    
	    public static User makeUser(){
			User user = new User();
			user.setId("");
			user.setPassword("");
			user.setName("");
			user.setBirth("");
			user.setPhoneNumber("");
			user.setEmail("");
			user.setEquip_rent_state(4);
			return user;
		}
	    
	    public static Equip makeEquip(){
	    	Equip equip = new Equip();
	    	equip.setName("");
	    	equip.setCpu("");
	    	equip.setCount(0);
	    	equip.setDepartment_id(0);
	    	equip.setMemory("");
	    	equip.setOs("");
	    	equip.setImage("");
	    	return equip;
	    }
	    public static Equip_rent makeEquip_rent() throws Exception{
	    	Equip_rent equip_rent = new Equip_rent();
	    	equip_rent.setEquip_id(0);
	    	equip_rent.setEquip_rent_day(rent_day());
	    	equip_rent.setEquip_return_day(return_day());
	    	return equip_rent;
	    }
	    
	    public static String Password( String m1, String m2) throws Exception{
	         String password,password2;
	         password=m1;
	         password2=m2;
	               if(password.equals(password2)){
	                  return null;
	               }
	               else               {
	                  return  "일치하지 않습니다.";
	               }
	               
	    }
	    
	    public static String rent_day() throws Exception{//현재날짜
	    	Date date = new Date();
	    	SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
	    	
	    	return sdf.format(date);
	    }
	    
	    public static String return_day() throws Exception{//1달후 날짜
	    	Date date = new Date();
	    	SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
	    	
	    	Calendar cal = new GregorianCalendar(Locale.KOREA);
	    	cal.setTime(new Date());
	    	cal.add(Calendar.DAY_OF_YEAR, 30);
	    	
	    	SimpleDateFormat sdf2 = new SimpleDateFormat("yyyyMMdd");
	    	
	    	return sdf2.format(cal.getTime());
	    }
	    
	    public static long late_day(Equip_rent equip_rent) throws Exception{//연체날짜 계산 메소드
	    	if(equip_rent.getEquip_rent_day()!=null){
		    	String first=equip_rent.getEquip_rent_day();
		    	String last = equip_rent.getEquip_return_day();
		    	
		    	SimpleDateFormat format = new SimpleDateFormat("yyyyMMdd");
		    	Date rent_day = format.parse(first);
		    	Date return_day = format.parse(last);
		    	
		    	long diff = return_day.getTime() - rent_day.getTime();
		    	long diffDays = diff/(24 *60 * 60*1000);
		 
		    	return diffDays;
	    	}else
	    		return 0;
	    }
	    
	    public static void resotre(HttpSession session,User user){
	    	 session.setAttribute(CURRENT_USER,  user);
	    }
}
