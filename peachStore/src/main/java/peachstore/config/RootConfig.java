package peachstore.config;

import javax.naming.NamingException;
import javax.sql.DataSource;

import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.SqlSessionFactoryBean;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.io.ClassPathResource;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.jndi.JndiTemplate;
import org.springframework.transaction.PlatformTransactionManager;

@Configuration
@ComponentScan(basePackages = {
	    "peachstore.service",
	    "peachstore.repository",
	    "peachstore.util"
	})

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


}
