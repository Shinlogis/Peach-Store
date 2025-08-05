package peachstore.config;

import javax.naming.NamingException;
import javax.sql.DataSource;

import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.SqlSessionFactoryBean;
import org.mybatis.spring.SqlSessionTemplate;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.io.ClassPathResource;
import org.springframework.http.converter.json.MappingJackson2HttpMessageConverter;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.jndi.JndiTemplate;
import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.annotation.EnableTransactionManagement;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.SerializationFeature;
import com.fasterxml.jackson.datatype.jsr310.JavaTimeModule;

@Configuration
@EnableTransactionManagement
@ComponentScan(basePackages = {
	    "peachstore.service",
	    "peachstore.repository",
	    "peachstore.util",
	})
@MapperScan("peachstore.repository.statistics")
public class RootConfig {
	
	@Bean
	public DataSource dataSource() throws NamingException {
		JndiTemplate jndi = new JndiTemplate();
		return jndi.lookup("java:comp/env/jndi/mysql", DataSource.class);
	}


	// Mybatis에 사용할 트랜잭션 매니저 선택
	@Bean
	public PlatformTransactionManager platformTransactionManager(SqlSessionFactory sqlSessionFactory) {
		return new DataSourceTransactionManager(sqlSessionFactory.getConfiguration().getEnvironment().getDataSource());
	}

	@Bean
	public SqlSessionFactory sqlSessionFactory() throws Exception {
		SqlSessionFactoryBean sqlSessionFactoryBean = new SqlSessionFactoryBean();
		sqlSessionFactoryBean.setConfigLocation(new ClassPathResource("peachstore/mybatis/mybatis-config.xml")); // mybatis
		// 설정파일위치
		sqlSessionFactoryBean.setDataSource(dataSource());
		return sqlSessionFactoryBean.getObject();
	}

	@Bean
	public SqlSessionTemplate sqlSessionTemplate() throws Exception {
		return new SqlSessionTemplate(sqlSessionFactory());
	}
	
	/*파일 업로드 설정*/
	@Bean
	public CommonsMultipartResolver multipartResolver() {
		CommonsMultipartResolver resolver = new CommonsMultipartResolver();
		resolver.setMaxUploadSize(20*1024*1024); //10M
		
		return resolver;
	}
	
	  @Bean
	    public RestTemplate restTemplate() {
	        ObjectMapper mapper = new ObjectMapper();
	        // 자바8 날짜/시간 타입 처리 모듈 등록
	        mapper.registerModule(new JavaTimeModule());
	        // 날짜를 타임스탬프 형태가 아닌 ISO 포맷으로 직렬화
	        mapper.disable(SerializationFeature.WRITE_DATES_AS_TIMESTAMPS);

	        MappingJackson2HttpMessageConverter converter = new MappingJackson2HttpMessageConverter();
	        converter.setObjectMapper(mapper);

	        RestTemplate restTemplate = new RestTemplate();
	        // 맨 앞에 넣어서 우선적으로 이 컨버터 사용
	        restTemplate.getMessageConverters().add(0, converter);

	        return restTemplate;
	    }


}
