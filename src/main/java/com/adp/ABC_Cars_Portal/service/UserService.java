package com.adp.ABC_Cars_Portal.service;

import java.util.HashSet;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import com.adp.ABC_Cars_Portal.model.User;
import com.adp.ABC_Cars_Portal.repository.RoleRepository;
import com.adp.ABC_Cars_Portal.repository.UserRepository;

import jakarta.transaction.Transactional;

@Service
@Transactional
public class UserService {

	@Autowired
	UserRepository userRepo;
	
	@Autowired
	RoleRepository roleRepo;
	
	@Autowired
	private PasswordEncoder passwordEncoder;
	
	public String save(User user) {
		if (!isEmailUnique(user.getEmail())) {
			return "Email Already Exists";
		}
		
		String encodePassword = passwordEncoder.encode(user.getPassword());
		user.setPassword(encodePassword);
		user.setRoles(new HashSet<>(roleRepo.findBySpecificRoles("Users")));
		userRepo.save(user);
		return "User Saved Succefully";
	}
	
	public User findLoginUser(String email) {
		return userRepo.findByEmail(email);
	}
	
	public List<User> showAllUsers(){
		return userRepo.findAll();
	}
	
	public void update(User user) {
		userRepo.save(user);
	}
	
	public Optional<User> getUserInfo(long uid){
		return userRepo.findById(uid);
	}
	
	public void deleteUser(long uid) {
		userRepo.deleteById(uid);
	}
	
	public void assignNewRole(User user, String role) {
		user.getRoles().clear();
		user.setRoles(new HashSet<>(roleRepo.findBySpecificRoles(role)));
		userRepo.save(user);
	}
	
	public boolean isEmailUnique(String email) {
		User existingUser = userRepo.findByEmail(email);
		return existingUser == null;
	}	
}
