package com.adp.ABC_Cars_Portal.configuration;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.core.userdetails.User.UserBuilder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

import com.adp.ABC_Cars_Portal.model.Role;
import com.adp.ABC_Cars_Portal.model.User;
import com.adp.ABC_Cars_Portal.repository.UserRepository;

import jakarta.transaction.Transactional;

@Configuration
@Transactional
public class UserDetailsServiceImpl implements UserDetailsService {

	@Autowired
	private UserRepository userRepo;
	

	
	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		User user = userRepo.findByEmail(username);
		System.out.println("Loading user by username: " + username);		
		if (user == null) {
			throw new UsernameNotFoundException("The email " + username + "you entered is not valid. Please re-enter.");
		}
		UserBuilder userBuilder = org.springframework.security.core.userdetails.User.builder();
		String[] roleNames = user.getRoles().stream().map(Role::getName).toArray(String[]:: new);
		System.out.println("Current user role is " + roleNames);
		return userBuilder.username(user.getEmail())
				.password(user.getPassword())
				.roles(roleNames)
				.build();
	}
}
