package peachstore.repository;

import peachstore.domain.SnsProvider;

public interface SnsProviderDAO {
	public SnsProvider selectByName(String name);
}
