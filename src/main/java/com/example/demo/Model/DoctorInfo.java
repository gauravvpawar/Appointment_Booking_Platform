package com.example.demo.Model;

import java.sql.Timestamp;
import java.time.LocalDate;
import java.time.LocalDateTime;

import javax.persistence.Column;
import javax.persistence.Embeddable;

import org.springframework.format.annotation.DateTimeFormat;

@Embeddable
public class DoctorInfo 
{
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private LocalDate dob;
	private String address;
    private String bloodGroup;
    private String emergencyContact;
    
    private String license_number;
    private String fileName;
    
    @Column(columnDefinition = "timestamp default current_timestamp")
    private Timestamp dateCreated = Timestamp.valueOf(LocalDateTime.now());

	public LocalDate getDob() {
		return dob;
	}

	public void setDob(LocalDate dob) {
		this.dob = dob;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getBloodGroup() {
		return bloodGroup;
	}

	public void setBloodGroup(String bloodGroup) {
		this.bloodGroup = bloodGroup;
	}

	public String getEmergencyContact() {
		return emergencyContact;
	}

	public void setEmergencyContact(String emergencyContact) {
		this.emergencyContact = emergencyContact;
	}

	public String getLicense_number() {
		return license_number;
	}

	public void setLicense_number(String license_number) {
		this.license_number = license_number;
	}

	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}

	public Timestamp getDateCreated() {
		return dateCreated;
	}

	public void setDateCreated(Timestamp dateCreated) {
		this.dateCreated = dateCreated;
	}

	@Override
	public String toString() {
		return "DoctorInfo [dob=" + dob + ", address=" + address + ", bloodGroup=" + bloodGroup + ", emergencyContact="
				+ emergencyContact + ", license_number=" + license_number + ", fileName=" + fileName + ", dateCreated="
				+ dateCreated + "]";
	} 
    
}
