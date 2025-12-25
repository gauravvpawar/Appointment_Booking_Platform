package com.example.demo.Model;

import java.time.LocalDate;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

@Entity
public class Appointments
{
	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private int appt_id;
	private int pid;
	private int did;
	
	private LocalDate appointment_date;
	private String appointment_time;
	
	
	@Column(columnDefinition = "varchar(20) default 'Pending'") // Database default
    private String appointment_status = "Pending";
	
	private String reason;

	public int getAppt_id() {
		return appt_id;
	}

	public void setAppt_id(int appt_id) {
		this.appt_id = appt_id;
	}

	public int getPid() {
		return pid;
	}

	public void setPid(int pid) {
		this.pid = pid;
	}

	public int getDid() {
		return did;
	}

	public void setDid(int did) {
		this.did = did;
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

	@Override
	public String toString() {
		return "Appointments [appt_id=" + appt_id + ", pid=" + pid + ", did=" + did + ", appointment_date="
				+ appointment_date + ", appointment_time=" + appointment_time + ", appointment_status="
				+ appointment_status + ", reason=" + reason + "]";
	}
	
	
	
	
}
