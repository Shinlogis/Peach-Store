package peachstore.service;

import peachstore.domain.User;

public interface UserService {
	public User selectById(String name);
	public void register(User user);
	public User select(int user_id);
	public User login(User user);
}
