package com.adp.ABC_Cars_Portal.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.adp.ABC_Cars_Portal.model.Car;
import com.adp.ABC_Cars_Portal.model.CarBidding;
import com.adp.ABC_Cars_Portal.model.User;

@Repository
public interface BidRepository extends JpaRepository<CarBidding, Long>{
	List<CarBidding> findByUserAndCar(User user, Car car);
	List<CarBidding> findByUser(User user);
}
