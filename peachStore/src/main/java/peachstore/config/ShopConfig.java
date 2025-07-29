package peachstore.config;

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

@Configuration
@EnableWebMvc
@PropertySource("classpath:application.properties")
@ComponentScan(basePackages = { "peachstore.shop.controller" })
public class ShopConfig {
	//Client ID, Secret, callback주소 보안매핑
	@Value("${oauth.google.clientId}")
	private String googleClientId;
	
	@Value("${oauth.google.clientSecret}")
	private String googleClientSecret;
	
	@Value("${oauth.google.callback}")
	private String callbackUrl;
	
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
	public OAuth20Service googleAuthService() {
		System.out.println("클라이언트 아이디는" + googleClientId);
		System.out.println("클라이언트 시크릿은"+googleClientSecret);
		System.out.println("콜백 유알엘은"+callbackUrl);
		// 클라이언트 ID(properties에 매핑)
		ServiceBuilder builder = new ServiceBuilder(googleClientId);
		//시크릿(properties에 매핑)
		builder.apiSecret(googleClientSecret);
		
		//접근범위
		builder.defaultScope("email profile openid");
		//콜백 주소 동의 완료 후 아래의 url로 요청 보낸다고 생각하면됨
		builder.callback(callbackUrl);
		return builder.build(GoogleApi20.instance());
	}
}
