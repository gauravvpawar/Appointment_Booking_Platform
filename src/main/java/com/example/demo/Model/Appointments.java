package com.example.demo.Model;

import java.sql.Timestamp;
import java.time.LocalDate;
import java.time.LocalDateTime;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;

import org.springframework.format.annotation.DateTimeFormat;

@Entity
public class Appointments
{ 	
	@Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private int appt_id;
    
    @ManyToOne
    @JoinColumn(name = "patient_id")
    private Patient patient;

    @ManyToOne
    @JoinColumn(name = "doctor_id")
    private Doctor doctor;
    
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private LocalDate appointment_date;
    private String appointment_time;
    
    @Column(columnDefinition = "varchar(20) default 'Pending'")
    private String appointment_status = "Pending";
    
    private String reason;
    
    private double consultationFee = 500.0; // Default fee

	 // Getter and Setter
	 public double getConsultationFee() {
	     return consultationFee;
	 }
	
	 public void setConsultationFee(double consultationFee) {
	     this.consultationFee = consultationFee;
	 }
    
    
    @Column(columnDefinition = "timestamp default current_timestamp")
    private Timestamp createdAt = Timestamp.valueOf(LocalDateTime.now()); 


	public int getAppt_id() {
		return appt_id;
	}


	public void setAppt_id(int appt_id) {
		this.appt_id = appt_id;
	}


	public Patient getPatient() {
		return patient;
	}


	public void setPatient(Patient patient) {
		this.patient = patient;
	}


	public Doctor getDoctor() {
		return doctor;
	}


	public void setDoctor(Doctor doctor) {
		this.doctor = doctor;
	}


	public LocalDate getAppointment_date() {
		return appointment_date;
	}


	public void setAppointment_date(LocalDate appointment_date) {
		this.appointment_date = appointment_date;
	}


	public String getAppointment_time() {
		return appointment_time;
	}


	public void setAppointment_time(String appointment_time) {
		this.appointment_time = appointment_time;
	}


	public String getAppointment_status() {
		return appointment_status;
	}


	public void setAppointment_status(String appointment_status) {
		this.appointment_status = appointment_status;
	}


	public String getReason() {
		return reason;
	}


	public void setReason(String reason) {
		this.reason = reason;
	}


	public Timestamp getCreatedAt() {
		return createdAt;
	}


	public void setCreatedAt(Timestamp createdAt) {
		this.createdAt = createdAt;
	}

	@Override
	public String toString() {
		return "Appointments [appt_id=" + appt_id + ", patient=" + patient + ", doctor=" + doctor
				+ ", appointment_date=" + appointment_date + ", appointment_time=" + appointment_time
				+ ", appointment_status=" + appointment_status + ", reason=" + reason + ", consultationFee="
				+ consultationFee + ", createdAt=" + createdAt + "]";
	}

	

}
