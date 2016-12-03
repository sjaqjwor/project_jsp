package util;

import java.io.InputStream;
import java.util.Properties;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

public class SMTP {

	public static String GMAIL_USERNAME="sumusb34@gamil.com";
	public static String GMAIL_PASSWORD="sc5203nv!@";
	
	static {
		try{
			Properties properties = new Properties();
			InputStream inputstream = SMTP.class.getClassLoader().getResourceAsStream("SMTP.properties");
			properties.load(inputstream);
			GMAIL_USERNAME=properties.getProperty("GMAIL_USERNAME");
			GMAIL_PASSWORD=properties.getProperty("GMAIL_PASSWORD");
		}catch(Exception e){
			
		}
	}
	
	public static void sendGMail(String email, String title, String body) throws AddressException, MessagingException{
		String host="smtp.gmail.com";
		
		Properties props= new Properties();
		props.put("mail.smtps.auth", "true");
		Session session = Session.getDefaultInstance(props);
		MimeMessage msg= new MimeMessage(session);
		
		msg.setSubject(title);
		msg.setText(body);
		msg.setFrom(new InternetAddress(GMAIL_USERNAME));
		msg.addRecipient(Message.RecipientType.TO, new InternetAddress(email));
		
		Transport transport = session.getTransport("smtps");
		transport.connect(host,GMAIL_USERNAME,GMAIL_PASSWORD);
		transport.sendMessage(msg,msg.getAllRecipients());
		transport.close();
	}
	
	public static boolean isValidEmail(String email){
		try{
			InternetAddress emailAddr = new InternetAddress(email);
			emailAddr.validate();
			return true;
		}catch(AddressException ex){
			return false;
		}
	}
}
