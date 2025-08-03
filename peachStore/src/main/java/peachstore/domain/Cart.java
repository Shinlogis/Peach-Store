package peachstore.domain;

import lombok.Data;

/**
 * 장바구니 도메인
 * @author 이세형
 * @since 2025-08-02
 */
@Data
public class Cart {
	private int cart_id;
	private User user;
}
