package com.app.ABC_Cars_Portal.validation;

import javax.validation.ConstraintValidator;
import javax.validation.ConstraintValidatorContext;

import org.springframework.beans.factory.annotation.Autowired;

import com.adp.ABC_Cars_Portal.model.User;
import com.adp.ABC_Cars_Portal.repository.UserRepository;

public class UniqueEmailValidator implements ConstraintValidator<UniqueEmail, String>{

	@Autowired
	private UserRepository userRepo;
	
	@Override
	public boolean isValid(String email, ConstraintValidatorContext context) {
		User existingUser =  userRepo.findByEmail(email);
		return existingUser == null;
	}
	

}
