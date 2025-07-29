package peachstore.service;

import java.util.List;

import peachstore.domain.SnsProvider;

public interface SnsProviderService {
	public List selectAll();
	public SnsProvider selectByName(String name);
}
