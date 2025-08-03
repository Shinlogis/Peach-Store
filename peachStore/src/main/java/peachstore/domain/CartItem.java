package peachstore.domain;

import lombok.Data;

/**
 * 장바구니 품목 도메인
 * @author 이세형
 * @since 2025-08-02
 */
@Data
public class CartItem {
	private int cart_item_id;
	private int quantity;
	private Cart cart;
	private Product product;
	private CustomOption custom_option;
}
