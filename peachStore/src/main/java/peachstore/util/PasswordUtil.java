package peachstore.util;

import java.security.SecureRandom;
import java.util.Base64;

import org.springframework.stereotype.Component;

//salt + password를 통한 해시생성
@Component
public class PasswordUtil {
	public static String generateSalt() {
		SecureRandom sr = new SecureRandom();
		byte[] salt = new byte[16];
		sr.nextBytes(salt);
		return Base64.getEncoder().encodeToString(salt);
	}
	
	public static String hashPassword(String password, String salt) {
		String result= null;
		return null;
	}
}
