package peachstore.service;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class TestServiceImpl implements TestService{
	@Override
	@Transactional()
	public String test() {
		return "ok";
	}
}
