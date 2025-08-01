package peachstore.domain;

import lombok.Getter;
import lombok.Setter;

/**
 * 관리자 도메인입니다
 * @author 김예진
 * @since 2025-08-01
 */
@Getter
@Setter
public class Admin {

	private int adminId; // pk
	private String email;
	private String id; // 로그인 id
	private String password;
	private String name;
	private String role;
	private boolean isActive;
}
