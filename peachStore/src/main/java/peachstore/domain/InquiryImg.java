package peachstore.domain;
import lombok.Data;
/**
 * 문의사진 엔티티
 * @author 성유진 
 * @since 2025-07-26
 */
@Data
public class InquiryImg {
	private int inquiry_img_id;
	private String filename;
	private Inquiry inquiry;

}
