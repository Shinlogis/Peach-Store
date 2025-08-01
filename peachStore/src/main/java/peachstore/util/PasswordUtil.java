package peachstore.util;

import java.security.MessageDigest;
import java.security.SecureRandom;
import java.util.Base64;

import org.springframework.stereotype.Component;

import lombok.extern.slf4j.Slf4j;
import peachstore.exception.UserException;

@Slf4j
@Component
public class PasswordUtil {
   
   //salt 객체를 생성
   public static String generateSalt() {
      //보안에 사용할 난수 생성기
      SecureRandom sr = new SecureRandom();//보안에 사용할 난수 생성기
      byte[] salt = new byte[16];//16바이트배열 128비트
      sr.nextBytes(salt);//배열에 무작위 바이트값으로 채움
      return Base64.getEncoder().encodeToString(salt);
   }
   
   //salt와 비밀번호를 조합한 해시를 만듦
   public static String hashPassword(String password, String salt) throws UserException{
      //문자열을 일정길이의 고정된 해시값으로 바꿔주는 객체
      String result= null;
      try {
         MessageDigest md = MessageDigest.getInstance("SHA-256");
         md.update(salt.getBytes("UTF-8"));//salt를 digest에 추가(누적)
         byte[] hashedByte = md.digest(password.getBytes("UTF-8"));
         result = Base64.getEncoder().encodeToString(hashedByte);
      } catch (Exception e) {
         e.printStackTrace();
         throw new UserException("비밀번호 암호화 실패",e);
      }
      return result;
   }
   
   
   public static void main(String[] args) {
      String salt = generateSalt();
      log.warn(salt);
      String password = "123";
      String result = hashPassword(password, salt);
      log.warn("리절트는" +result);
   }
}
