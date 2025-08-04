package peachstore.domain;

import lombok.Data;

@Data
public class ReviewImg {
	
	private int review_img_id;
	private String filename;
	private Review review;

}
