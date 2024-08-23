package com.adp.ABC_Cars_Portal.controller;

import java.io.IOException;
import java.io.InputStream;
import java.lang.StackWalker.Option;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.security.Principal;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Optional;
import java.util.Set;
import java.util.function.Predicate;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.adp.ABC_Cars_Portal.model.Car;
import com.adp.ABC_Cars_Portal.model.CarBidding;
import com.adp.ABC_Cars_Portal.model.User;
import com.adp.ABC_Cars_Portal.service.CarService;
import com.adp.ABC_Cars_Portal.service.UserService;

import jakarta.persistence.Entity;

@Controller
public class CarController {

	@Autowired
	CarService carService;

	@Autowired
	UserService userService;

	@GetMapping("/")
	public String handleRootRequest(Model model) {
		return "redirect:cars";
	}

	@GetMapping("cars")
	public ModelAndView viewCars(@ModelAttribute("car") Car car) {

		List<Car> cars = carService.getAllCars();
		System.out.println(cars);

		return new ModelAndView("viewCars", "cars", cars);
	}
	
	@GetMapping(value = "car_detail")
	public String viewCarDetails(@RequestParam long cid, Model model) {
		Optional<Car> car_info = carService.getCarInfo(cid);
		System.out.println(car_info);
		Car cardata = car_info.get();
		List<Car> car = new ArrayList<>();
		car.add(cardata);
		model.addAttribute("car", car);
		// Show Bidding data
		Predicate<CarBidding> byCar = ucar -> ucar.getCar().equals(cardata);
		List<CarBidding> bdata = carService.getAllBids().stream().filter(byCar).collect(Collectors.toList());
		model.addAttribute("bid", bdata);
		if (bdata.size() > 0) {
			double highest = bdata.get(0).getBidderPrice();
			System.out.println(highest);
			model.addAttribute("highest", highest);
		}
		return "carDetail";
	}
	
	@PostMapping("car_post")
	public String saveCar(@ModelAttribute("car") Car car, RedirectAttributes ra,
			@RequestParam("fileImage") MultipartFile multipartFile, Principal principal) throws IOException {

		String fileName = StringUtils.cleanPath(multipartFile.getOriginalFilename());

		car.setPhotos(fileName);

		Car savedCar = carService.save(car);

		String uploadDir = "./src/main/resources/static/images/car-photo/" + savedCar.getId();

		Path uploadPath = Paths.get(uploadDir);

		if (!Files.exists(uploadPath)) {
			Files.createDirectories(uploadPath);
		}

		try (InputStream inputStream = multipartFile.getInputStream()) {
			Path filePath = uploadPath.resolve(fileName);
			System.out.println(filePath.toFile().getAbsolutePath());
			Files.copy(inputStream, filePath, StandardCopyOption.REPLACE_EXISTING);
		} catch (IOException e) {
			throw new IOException("Could not save uploaded file: " + fileName);

		}

		car.setPhotoImagePath("/images/car-photo/" + savedCar.getId() + "/" + savedCar.getPhotos());

		// Get User name
		String uname = principal.getName();

		User user = userService.findLoginUser(uname);

		car.setSellerId(user.getId());

		carService.save(car);

		ra.addFlashAttribute("success_post", "Post has been saved successfully");

		return "redirect:cars";
	}
	
	@PostMapping(value = "edit_car1")
	public String editCar1(@ModelAttribute("car") Car car, @RequestParam long cid) {
		Optional<Car> car_info = carService.getCarInfo(cid);
		System.out.println(car_info);
		Car edit = car_info.get();
		edit.setMake(car.getMake());
		edit.setModel(car.getModel());
		edit.setName(car.getName());
		edit.setPrice(car.getPrice());
		edit.setRegistration(car.getRegistration());
		edit.setSellerId(car.getSellerId());
		edit.setPhotos(car.getPhotos());
		edit.setPhotoImagePath(car.getPhotoImagePath());
		carService.save(edit);
		return "redirect:profile";
	}
	
	@GetMapping(value = "delete_car1")
	public String deleteCar1(@RequestParam long cid) {
		carService.deleteCar(cid);
		return "redirect:profile";
	}
	
	@PostMapping(value = "book")
	public String carBooking(@ModelAttribute("booking") CarBidding book, @RequestParam(value = "cid", required=false) long id, Principal principal, Model model, @RequestParam("bookDate") String date) {
		//Get user
		String uname = principal.getName();
		User user = userService.findLoginUser(uname);
		//Get car info
		Optional<Car> car_info = carService.getCarInfo(id);
		System.out.println("car_info");
		Car car_data = car_info.get();
		book.setUser(user);
		book.setCar(car_data);
		book.setBidderName(user.getName());
		//Before saving test drive booking, checks if user already placed a booking and a bidding before saving
		List<CarBidding> userBooking = carService.findUserBid(user, car_data);
		System.out.println(userBooking);
		if (userBooking.size() > 0) {
			long bookId = userBooking.stream().findAny().get().getId();
			Optional<CarBidding> book_info = carService.getBidInfo(bookId);
			System.out.println(book_info);
			CarBidding book_data  = book_info.get();
			book_data.setBookDate(date);
			carService.saveBid(book_data);
		} else {
			carService.saveBid(book);
		}
		//Show car data
		List<Car> car = new ArrayList<>();
		car.add(car_data);
		model.addAttribute("car", car);
		//Show bidding data
		Predicate<CarBidding> byCar = ucar -> ucar.getCar().equals(car_data);
		List<CarBidding> bdata = carService.getAllBids().stream().filter(byCar).collect(Collectors.toList());
		System.out.println(bdata);
		model.addAttribute("bid", bdata);
		if (bdata.size() > 0) {
			double highest = bdata.get(0).getBidderPrice();
			System.out.println(highest);
			model.addAttribute("highest", highest);
		}
		Set<CarBidding> highbid = new HashSet<CarBidding>();
		highbid.add(bdata.get(0));
		car_data.setBiddings(highbid);
		carService.save(car_data);
		System.out.println(car_data.getBiddings());
		return "carDetail";
	}
	
	@PostMapping(value = "bid")
	public String carBidding(@ModelAttribute("bidding") CarBidding bid, @RequestParam(value = "cid", required = false) long id, Principal principal, Model model, @RequestParam("bidderPrice") double price) {
		//Get user
		String uname = principal.getName();
		User user = userService.findLoginUser(uname);
		//Get car
		Optional<Car> car_info = carService.getCarInfo(id);
		Car car_data = car_info.get();
		bid.setBidderName(user.getName());
		bid.setUser(user);
		bid.setCar(car_data);
		//Before saving test drive booking, checks if user already placed a booking and a bidding before saving
		List<CarBidding> userBid = carService.findUserBid(user, car_data);
		System.out.println(userBid);
		if (userBid.size() > 0) {
			long bidId = userBid.stream().findAny().get().getId();
			Optional<CarBidding> bid_info = carService.getBidInfo(bidId);
			CarBidding bidData =  bid_info.get();
			bidData.setBidderPrice(price);
			carService.saveBid(bidData);
		} else {
			carService.save(car_data);
		}
		//Show car data
		List<Car> car = new ArrayList<Car>();
		car.add(car_data);
		model.addAttribute("car", car);
		//Show bidding data
		Predicate<CarBidding> byCar = ucar -> ucar.getCar().equals(car_data);
		List<CarBidding> bdata = carService.getAllBids().stream().filter(byCar).collect(Collectors.toList());
		model.addAttribute("bid", bdata);
		if (bdata.size() > 0) {
			double highest = bdata.get(0).getBidderPrice();
			model.addAttribute("highest", highest);
		}
		Set<CarBidding> highBid = new HashSet<CarBidding>();
		highBid.add(bdata.get(0));
		car_data.setBiddings(highBid);
		carService.save(car_data);
		System.out.println(car_data.getBiddings());
		return "carDetail";
	}
	
	@GetMapping(value = "all_cars")
	public ModelAndView showAllCar(@ModelAttribute("car") Car car) {
		List<Car> cars = carService.getAllCars();
		return new ModelAndView ("allCar", "cars", cars); 
	} 
	
	@PostMapping(value = "edit_car")
	public String editCar(@ModelAttribute("car") Car car, @RequestParam long cid) {
		Optional<Car> car_info = carService.getCarInfo(cid);;
		Car edit = car_info.get();
		edit.setMake(car.getMake());
		edit.setModel(car.getModel());
		edit.setName(car.getName());
		edit.setPrice(car.getPrice());
		edit.setRegistration(car.getRegistration());
		edit.setSellerId(car.getSellerId());
		edit.setPhotos(car.getPhotos());
		edit.setPhotoImagePath(car.getPhotoImagePath());
		carService.save(edit);
		return "redirect:all_cars";
	}
	
	@GetMapping(value = "delete_car")
	public String deleteCar(@RequestParam long cid) {
		carService.deleteCar(cid);
		return "redirect:all_cars";
	}
	
	@PostMapping(value = "sale_status")
	public String setCarSaleStatus(@ModelAttribute("car") Car car, @RequestParam long cid) {
		Optional<Car> car_info = carService.getCarInfo(cid);
		Car car_sale = car_info.get();
		car_sale.setSellStatus(car.getSellStatus());
		carService.save(car_sale);
		return "redirect:all_cars";
	}
	
	@PostMapping(value = "booking_status")
	public String setCarBookingStatus(@RequestParam long bid, @ModelAttribute("book") CarBidding book) {
		Optional<CarBidding> car_info = carService.getBidInfo(bid);
		CarBidding car_booking = car_info.get();
		car_booking.setBookStatus(book.getBookStatus());
		carService.saveBid(car_booking);
		return "redirect:all_cars";
	}
	
	@GetMapping(value = "search")
	public ModelAndView searchCars(@RequestParam String keyword, Model model) {
		List<Car> searchCar = carService.search(keyword);
		System.out.println(searchCar);
		model.addAttribute(keyword, searchCar);
		return new ModelAndView("searchResults", "searchCar", searchCar);
	}
}
