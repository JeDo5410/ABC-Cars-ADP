package com.adp.ABC_Cars_Portal.controller;

import java.lang.StackWalker.Option;
import java.security.Principal;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.adp.ABC_Cars_Portal.model.Car;
import com.adp.ABC_Cars_Portal.model.CarBidding;
import com.adp.ABC_Cars_Portal.model.User;
import com.adp.ABC_Cars_Portal.service.CarService;
import com.adp.ABC_Cars_Portal.service.UserService;

@Controller
public class LoginController {

	@Autowired
	UserService userService;
	
	@Autowired
	CarService carService;
	
	@GetMapping("login")
    public String onLogin(Model model) {
		model.addAttribute("user", new User());
        return "login";
    }
	
	@GetMapping("login_error")
    public String onLoginError(Model model) {
        String error_msg = "Incorrect username or password. Try Again.";
        model.addAttribute("error_string", error_msg);
        return "login";
    }
	
	@GetMapping(value = "registration_form")
	public String showRegistrationForm(@ModelAttribute("user") User user) {
		return "register";
	}
	
	@PostMapping(value = "registration_process")
	public String saveUser(@Valid @ModelAttribute("user") User user, Model model, BindingResult bindingResult) {
		if (bindingResult.hasErrors()) {
			return "register";
		}
		
		if (!userService.isEmailUnique(user.getEmail())) {
			bindingResult.rejectValue("email", "error.user", "Email already exists");
			return "register";
		}
		userService.save(user);
		String success_register = "Registration Successful!";
		model.addAttribute("success_register", success_register);
		return "login";
	}
	
	@GetMapping(value = "profile")
	public String showProfile(Model model, Principal principal) {
		//Get the user's information
		String uname = principal.getName();
		System.out.println(uname);
		User userdata = userService.findLoginUser(uname);
		long uid = userdata.getId();
		List<User> user = new ArrayList<User>();
		user.add(userdata);
		model.addAttribute("user", user);
		System.out.println(user);
		//Get the user's car posts
		List<Car> cars = carService.findCarPosts(uid);
		System.out.println(cars);
		model.addAttribute("cars", cars);
		//Get the user's bidding or bookings
		List<CarBidding> bids = carService.getUserBids(userdata);
		System.out.println(bids);
		model.addAttribute("bids", bids);
		return "profile";
	} 
	
	@PostMapping(value = "update")
	public String updateUser(Principal principal, @ModelAttribute("user") User u) {
		String username = principal.getName();
		User user = userService.findLoginUser(username);
		user.setName(u.getName());
		user.setUserName(u.getUserName());
		user.setEmail(u.getEmail());
		user.setMobile(u.getMobile());
		user.setAddress(u.getAddress());
		userService.update(user);
		System.out.println("User update successful");
		System.out.println(user);
		return "redirect:profile";
	}
	
	@GetMapping(value = "view")
	public  String userProfile(Model model, @RequestParam long uid) {
		Optional<User> user_info = userService.getUserInfo(uid);
		User userdata = user_info.get();
		List<User> user = new ArrayList<User>();
		user.add(userdata);
		model.addAttribute("user", user);
		List<Car> cars = carService.findCarPosts(uid);
		model.addAttribute("cars", cars);
		return "profile";
	}
	
	@GetMapping(value = "users")
	public ModelAndView showAllUser() {
		List<User> user = userService.showAllUsers();
		return new ModelAndView ("allUser", "user", user); 
	}
	 
	@PostMapping(value = "assign_role")
	public String assignRole(@RequestParam long uid, @RequestParam("role") String role, @ModelAttribute("user") User u) {
		Optional<User> user_info = userService.getUserInfo(uid);
		User user = user_info.get();
		userService.assignNewRole(user, role);
		return "redirect:users";
	}
	
	@PostMapping(value = "edit")
	public String editUser(@ModelAttribute("user") User u, @RequestParam long uid) {
		Optional<User> user_info = userService.getUserInfo(uid);
		User user = user_info.get();
		user.setName(u.getName());
		user.setUserName(u.getUserName());
		user.setEmail(u.getEmail());
		user.setMobile(u.getMobile());
		user.setAddress(u.getAddress());
		userService.save(user);
		return "redirect:users";
	}
	
	@GetMapping(value = "delete")
	public String deleteUser(@RequestParam long uid) {
		userService.deleteUser(uid);
		return "redirect:users";
	}
}
