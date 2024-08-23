package com.adp.ABC_Cars_Portal.service;

import java.util.Comparator;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.adp.ABC_Cars_Portal.model.Car;
import com.adp.ABC_Cars_Portal.model.CarBidding;
import com.adp.ABC_Cars_Portal.model.User;
import com.adp.ABC_Cars_Portal.repository.BidRepository;
import com.adp.ABC_Cars_Portal.repository.CarRepository;

import jakarta.transaction.Transactional;

@Service
@Transactional
public class CarService {
	
	@Autowired
	private CarRepository carRepo;
	
	@Autowired
	private BidRepository bidRepo;
	
	public List<Car> getAllCars(){
		return carRepo.findAll();
	}
	
	public Car save(Car car) {
		return carRepo.save(car);
	}
	
	public Optional<Car> getCarInfo(long cid){
		return carRepo.findById(cid);
	}
	
	public List<Car> findCarPosts(long uid){
		return carRepo.findBySellerId(uid);
	}
	
	public void deleteCar(long cid) {
		carRepo.deleteById(cid);
	}
	
	public List<Car> search(String keyword){
		return carRepo.search(keyword);
	}
	
	public CarBidding saveBid(CarBidding bid) {
		return bidRepo.save(bid);
	}
	
	public List<CarBidding> getAllBids(){
		List<CarBidding> allBid = bidRepo.findAll();
		List<CarBidding> sortedList = allBid.stream().sorted(Comparator.comparingDouble(CarBidding::getBidderPrice).reversed()).collect(Collectors.toList());
		return sortedList;
	}
	
	public List<CarBidding> findUserBid(User user, Car car){
		return bidRepo.findByUserAndCar(user, car);
	}
	
	public Optional<CarBidding> getBidInfo(long bid){
		return bidRepo.findById(bid);
	}
	
	public List<CarBidding> getUserBids(User user){
		return bidRepo.findByUser(user);
	}
	
	public void deleteBid(long bid) {
		bidRepo.deleteById(bid);
	}
}
