package peachstore.domain;

import lombok.Data;

@Data
public class User {
	
	private int user_id;
	private String id;
    private String email;
    private String salt;
    private String hashedpassword;
    private String user_name;
    private String tel;
    private String address;
    private boolean is_active;
    private String created_at;
    private UserGrade user_grade;
    private SnsProvider sns_provider;
// 마이바티스에서 매핑 해야함.

}
