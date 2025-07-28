package peachstore.repository;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import peachstore.domain.SnsProvider;

@Repository
public class SnsProviderDAOImpl implements SnsProviderDAO{
	
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	@Override
	public List selectAll() {
		return sqlSessionTemplate.selectList("SnsProvider.selectAll");
	}
	
	@Override
	public SnsProvider selectByName(String name) {
		return sqlSessionTemplate.selectOne("Snsprovider.selectByName", name);
	}
}
