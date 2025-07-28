package peachstore.domain;

import lombok.Data;

@Data
public class User {
	
	private int user_id;
	private String id;
    private String email;
    private String password;
    private String user_name;
    private String tel;
    private String address;
    private boolean isActive;
    private String createAt;
    private UserGrade userGrade;
    private SnsProvider snsProvider;


}
