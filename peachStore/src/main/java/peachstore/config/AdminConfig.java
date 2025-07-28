package peachstore.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.servlet.view.InternalResourceViewResolver;

@Configuration
@EnableWebMvc
@ComponentScan(basePackages = "peachstore.admin.controller")
public class AdminConfig {

	@Bean
	public InternalResourceViewResolver adminViewResolver() {
		InternalResourceViewResolver resolver = new InternalResourceViewResolver();
		resolver.setPrefix("/WEB-INF/views/secure"); // 관리자 JSP 위치
		resolver.setSuffix(".jsp");
		return resolver;
	}

}
