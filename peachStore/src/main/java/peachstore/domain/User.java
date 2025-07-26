package peachstore.domain;

import lombok.Data;

@Data
public class User {
	
	private int user_id;
    private String email;
    private String id;
    private String password;
    private String name;
    private String tel;
    private String address;
    private int gradeId;
    private boolean isActive;
    private java.sql.Timestamp createAt;
    private int snsPrviderId;


}
