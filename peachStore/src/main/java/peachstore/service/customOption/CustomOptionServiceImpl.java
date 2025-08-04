package peachstore.service.customOption;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import peachstore.domain.CustomOption;
import peachstore.exception.CustomOptionException;
import peachstore.repository.customOption.CustomOptionDAO;

@Service
public class CustomOptionServiceImpl implements CustomOptionService {
	@Autowired
	CustomOptionDAO customOptionDAO;
	
	@Override
	public void regist(CustomOption customOption) throws CustomOptionException{
		customOptionDAO.insert(customOption);
	}

}
