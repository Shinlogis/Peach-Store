package peachstore.domain;

import java.sql.Date;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

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
	
	private List<ReviewImg> imgList;
	private MultipartFile[] photo;
}
