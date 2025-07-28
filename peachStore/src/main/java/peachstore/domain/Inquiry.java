package peachstore.domain;

import java.time.LocalDateTime;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;
/**
 * 문의하기 엔티티
 * @author 성유진 
 * @since 2025-07-26
 */
@Data
public class Inquiry {

	private int inquiry_id;
	private String title;
	private String inquiry_text;
	private LocalDateTime created_at;
	private String answer_text;
	private LocalDateTime answered_at;
	private boolean is_active;
	private User user;
	private Integer admin_id;
	
	private List<InquiryImg> imgList;
	private MultipartFile[] photo;

}
