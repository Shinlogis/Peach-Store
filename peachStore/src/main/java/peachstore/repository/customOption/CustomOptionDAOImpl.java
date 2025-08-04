package peachstore.repository.customOption;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import peachstore.domain.CustomOption;

@Repository
public class CustomOptionDAOImpl implements CustomOptionDAO{
	
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	@Override
	public void insert(CustomOption customOption) {
		sqlSessionTemplate.insert("CustomOption.insert", customOption);
	}
	
}
