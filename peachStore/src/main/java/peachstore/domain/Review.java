package peachstore.domain;

import java.sql.Date;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class Review {
	private int reviewId;
	private String content;
	private Date regdate;
	private String status;
	private User user;
	private OrderDetail orderDetail;
}
