package peachstore.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import peachstore.domain.SnsProvider;
import peachstore.repository.SnsProviderDAO;

@Service
public class SnsProviderServiceImpl implements SnsProviderService{
	@Autowired
	private SnsProviderDAO snsProviderDAO;
	
	@Override
	public List selectAll() {
		return null;
	}
	
	@Override
	public SnsProvider selectByName(String name) {
		return snsProviderDAO.selectByName(name);
	}
}
