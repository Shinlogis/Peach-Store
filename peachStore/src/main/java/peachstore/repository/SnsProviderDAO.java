package peachstore.repository;

import java.util.List;

import peachstore.domain.SnsProvider;

public interface SnsProviderDAO {
	public List selectAll();
	public SnsProvider selectByName(String name);
}
