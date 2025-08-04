package peachstore.util;

public class test {
	public static void main(String[] args) {
	    String password = "1234";
	    String salt = PasswordUtil.generateSalt();
	    String hashedPw = PasswordUtil.hashPassword(password, salt);

	    System.out.println("salt: " + salt);
	    System.out.println("hashedPw: " + hashedPw);
	}
}
