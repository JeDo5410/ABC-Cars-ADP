package com.adp.ABC_Cars_Portal.model;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

import org.springframework.data.annotation.CreatedDate;


import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.PrePersist;

@Entity
public class CarBidding {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private long id;
	
	private String bidderName;
	
	private double bidderPrice;
	
	@CreatedDate
	private String bidDate;
	
	@PrePersist
	private void onCreate() {
		DateFormat dateOnly = new SimpleDateFormat("EEEEE dd MMMM yyyy");
		bidDate = dateOnly.format(new Date());
	}
	
	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "car_id")
	private Car car;
	
	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "user_id")
	private User user;
	
	private String bookDate;
	
	private String bookStatus;
	
	public CarBidding() {
	}
	
	public CarBidding(Long id, String bidderName, double bidderPrice, String bidDate, Car car, User user,
			String bookDate) {
		super();
		this.id = id;
		this.bidderName = bidderName;
		this.bidderPrice = bidderPrice;
		this.bidDate = bidDate;
		this.car = car;
		this.user = user;
		this.bookDate = bookDate;
	}

	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public String getBidderName() {
		return bidderName;
	}

	public void setBidderName(String bidderName) {
		this.bidderName = bidderName;
	}

	public double getBidderPrice() {
		return bidderPrice;
	}

	public void setBidderPrice(double bidderPrice) {
		this.bidderPrice = bidderPrice;
	}

	public String getBidDate() {
		return bidDate;
	}

	public void setBidDate(String bidDate) {
		this.bidDate = bidDate;
	}

	public Car getCar() {
		return car;
	}

	public void setCar(Car car) {
		this.car = car;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public String getBookDate() {
		return bookDate;
	}

	public void setBookDate(String bookDate) {
		this.bookDate = bookDate;
	}

	public String getBookStatus() {
		return bookStatus;
	}

	public void setBookStatus(String bookStatus) {
		this.bookStatus = bookStatus;
	}
	
	@Override
	public String toString() {
		return "CarBidding [id=" + id + ", bidderName=" + bidderName + ", bidderPrice=" + bidderPrice + ", bidDate="
				+ bidDate + ", car=" + car + ", user=" + user + ", bookDate=" + bookDate + "]";
	}
}
