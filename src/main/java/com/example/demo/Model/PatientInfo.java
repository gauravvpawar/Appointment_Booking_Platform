package com.example.demo.Model;

import java.sql.Timestamp;
import java.time.LocalDateTime;

import javax.persistence.Column;
import javax.persistence.Embeddable;

@Embeddable
public class PatientInfo {
	
	private String address;
    private String bloodGroup;
    private String emergencyContact;
    
    @Column(columnDefinition = "timestamp default current_timestamp")
    private Timestamp dateCreated = Timestamp.valueOf(LocalDateTime.now()); 
    
    
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
	public Timestamp getDateCreated() {
		return dateCreated;
	}
	public void setDateCreated(Timestamp dateCreated) {
		this.dateCreated = dateCreated;
	}
	@Override
	public String toString() {
		return "PatientInfo [address=" + address + ", bloodGroup=" + bloodGroup + ", emergencyContact="
				+ emergencyContact + ", dateCreated=" + dateCreated + "]";
	}
    
	
    
}
