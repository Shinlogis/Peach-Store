package peachstore.advice;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ModelAttribute;

import peachstore.domain.User;
import peachstore.service.review.ReviewService;
import peachstore.service.topcategory.ProductTopcategoryService;
import peachstore.service.user.UserService;

@ControllerAdvice
public class ShopGlobalModelAdvice {
	//쇼핑몰의 메인 네비게이션에 출력된 최상위 카테고리는 jsp를 매핑하는 모든 컨트롤러에서 
		//처리해야할 공통 코드이므로, 여기서 처리 
		@Autowired
		private ProductTopcategoryService productTopcategoryService;
		@Autowired
		private ReviewService reviewService;
		@Autowired
		private UserService userService;
		
		@ModelAttribute("topList") //모든 하위 컨트롤러에서 사용할 모델의 데이터를 저장 
		public List getTopList() { //동작 시점 모든 @RequestMapping() 명시된 하위 컨트롤러의 메서드가 동작하기 전에 자동으로 실행 됨 
			return productTopcategoryService.selectAll("");
		}
		
		@ModelAttribute("reviewCount") //모든 하위 컨트롤러에서 사용할 모델의 데이터를 저장 
		public int getReview(HttpSession session) { //동작 시점 모든 @RequestMapping() 명시된 하위 컨트롤러의 메서드가 동작하기 전에 자동으로 실행 됨 
			User user = (User)session.getAttribute("user");
			int count = 0;
			if(user != null) {
				 count = reviewService.countByUserId(user);
			}
			return count;
		}
		
		@ModelAttribute("userGrade") //모든 하위 컨트롤러에서 사용할 모델의 데이터를 저장 
		public User getUserGrage(HttpSession session) { //동작 시점 모든 @RequestMapping() 명시된 하위 컨트롤러의 메서드가 동작하기 전에 자동으로 실행 됨 
			User user = (User)session.getAttribute("user");
			
			User getUser = null;
			
			if(user != null) {
				getUser = userService.selectByUserId(user.getUser_id());
			}
			return getUser;
		}
		
}
