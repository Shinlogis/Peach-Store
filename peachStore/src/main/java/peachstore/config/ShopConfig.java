package peachstore.config;

import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.PropertySource;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.servlet.view.InternalResourceViewResolver;

import com.github.scribejava.apis.GoogleApi20;
import com.github.scribejava.core.builder.ServiceBuilder;
import com.github.scribejava.core.oauth.OAuth20Service;

import peachstore.shop.model.KakaoApi20;
import peachstore.shop.model.NaverApi20;

@Configuration
@EnableWebMvc
@PropertySource("classpath:application.properties")
@ComponentScan(basePackages = { "peachstore.advice","peachstore.shop.controller" })
public class ShopConfig {
	//Client ID, Secret, callback주소 보안매핑
	
	/*============구글 매핑===========*/
	@Value("${oauth.google.clientId}")
	private String googleClientId;
	
	@Value("${oauth.google.clientSecret}")
	private String googleClientSecret;
	
	@Value("${oauth.google.callback}")
	private String googleCallbackUrl;
	
	/*============네이버 매핑===========*/
	@Value("${oauth.naver.clientId}")
	private String naverClientId;
	
	@Value("${oauth.naver.clientSecret}")
	private String naverClientSecret;
	
	@Value("${oauth.naver.callback}")
	private String naverCallbackUrl;
	
	/*============카카오 매핑===========*/
	@Value("${oauth.kakao.clientId}")
	private String kakaoClientId;
	
//	@Value("${oauth.kakao.clientSecret}")
//	private String kakaoClientSecret;
	
	@Value("${oauth.kakao.callback}")
	private String kakaoCallbackUrl;
	
	
	@Bean
	public InternalResourceViewResolver viewResolver() {
		InternalResourceViewResolver resolver = new InternalResourceViewResolver();
		resolver.setPrefix("/WEB-INF/views/");
		resolver.setSuffix(".jsp");
		return resolver;
	}
	
	/*Google용 입니다*/
	// 구글 로그인 관련 서비스 객체 등록
	@Bean
	public OAuth20Service googleOAuthService() {
		System.out.println("구글클라이언트 아이디는" + googleClientId);
		System.out.println("구글클라이언트 시크릿은"+googleClientSecret);
		System.out.println("구글콜백 유알엘은"+googleCallbackUrl);
		// 클라이언트 ID(properties에 매핑)
		ServiceBuilder builder = new ServiceBuilder(googleClientId);
		//시크릿(properties에 매핑)
		builder.apiSecret(googleClientSecret);
		
		//접근범위
		builder.defaultScope("email profile openid");
		//콜백 주소 동의 완료 후 아래의 url로 요청 보낸다고 생각하면됨
		builder.callback(googleCallbackUrl);
		return builder.build(GoogleApi20.instance());
	}
	
	@Bean
	public OAuth20Service naverOAuthService() {
		System.out.println("클라이언트 아이디는" + naverClientId);
		System.out.println("클라이언트 시크릿은"+naverClientSecret);
		System.out.println("콜백 유알엘은"+naverCallbackUrl);
		// 클라이언트 ID(properties에 매핑)
		ServiceBuilder builder = new ServiceBuilder(naverClientId);
		//시크릿(properties에 매핑)
		builder.apiSecret(naverClientSecret);
		
		//접근범위
		builder.defaultScope("email profile openid");
		//콜백 주소 동의 완료 후 아래의 url로 요청 보낸다고 생각하면됨
		builder.callback(naverCallbackUrl);
		return builder.build(NaverApi20.instance());
	}
	
	@Bean
	@Qualifier("kakaoOAuthService")
	public OAuth20Service kakaoOAuthService() {
		System.out.println("클라이언트 아이디는" + kakaoClientId);
		System.out.println("콜백 유알엘은"+kakaoCallbackUrl);
		// 클라이언트 ID(properties에 매핑)
		ServiceBuilder builder = new ServiceBuilder(kakaoClientId);
		//시크릿(properties에 매핑)
//		builder.apiSecret(kakaoClientSecret);
//		
		//접근범위
		builder.defaultScope("profile_nickname profile_image");
		//콜백 주소 동의 완료 후 아래의 url로 요청 보낸다고 생각하면됨
		builder.callback(kakaoCallbackUrl);
		return builder.build(KakaoApi20.instance());
	}
}
