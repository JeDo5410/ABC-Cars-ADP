package com.adp.ABC_Cars_Portal.model;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashSet;
import java.util.Set;

import org.springframework.data.annotation.CreatedDate;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.OneToMany;
import jakarta.persistence.PrePersist;

@Entity
public class Car {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private long id;
	
	@Column(nullable = true, length = 64)
	private String photos;
	
	@Column(nullable = true, length = 64)
	private String photoImagePath;
	
	@OneToMany(mappedBy = "car")
	private Set<CarBidding> biddings = new HashSet<CarBidding>();
	
	private String name;
	
	private String make;
	
	private String model;
	
	private String registration;;
	
	private String price;
	
	private long sellerId;
	
	private String sellStatus;
	
	@CreatedDate
	private String postDate;
	
	@PrePersist
	private void onCreate() {
		DateFormat dateOnly = new SimpleDateFormat("EEEEE dd MMMMM yyyy");
		postDate = dateOnly.format(new Date());
	}
	
	public Car() {

	}


	public Car(Long id, String photos, String photoImagePath, String name, String make, String model,
			String registration, String price, Long sellerId) {
		super();
		this.id = id;
		this.photos = photos;
		this.photoImagePath = photoImagePath;
		this.name = name;
		this.make = make;
		this.model = model;
		this.registration = registration;
		this.price = price;
		this.sellerId = sellerId;
	}

	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public String getPhotos() {
		return photos;
	}

	public void setPhotos(String photos) {
		this.photos = photos;
	}

	public String getPhotoImagePath() {
		return photoImagePath;
	}

	public void setPhotoImagePath(String photoImagePath) {
		this.photoImagePath = photoImagePath;
	}

	public Set<CarBidding> getBiddings() {
		return biddings;
	}

	public void setBiddings(Set<CarBidding> biddings) {
		this.biddings = biddings;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getMake() {
		return make;
	}

	public void setMake(String make) {
		this.make = make;
	}

	public String getModel() {
		return model;
	}

	public void setModel(String model) {
		this.model = model;
	}

	public String getRegistration() {
		return registration;
	}

	public void setRegistration(String registration) {
		this.registration = registration;
	}

	public String getPrice() {
		return price;
	}

	public void setPrice(String price) {
		this.price = price;
	}

	public long getSellerId() {
		return sellerId;
	}

	public void setSellerId(long sellerId) {
		this.sellerId = sellerId;
	}

	public String getSellStatus() {
		return sellStatus;
	}

	public void setSellStatus(String sellStatus) {
		this.sellStatus = sellStatus;
	}

	public String getPostDate() {
		return postDate;
	}

	public void setPostDate(String postDate) {
		this.postDate = postDate;
	}
	
	@Override
	public String toString() {
		return "Car [id=" + id + ", photos=" + photos + ", photoImagePath=" + photoImagePath + ", name=" + name
				+ ", make=" + make + ", model=" + model + ", registration=" + registration + ", price=" + price
				+ ", sellerId=" + sellerId + ", postDate=" + postDate + "]";
	}
	
}
