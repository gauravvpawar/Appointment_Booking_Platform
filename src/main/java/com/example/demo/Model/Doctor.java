package com.example.demo.Model;

import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;

@Entity
public class Doctor 
{
	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private int did;
	
	private String name;
	private String email;
	private String password;
	private String cnfPassword;
	private String phone;
	private String specialization;
	private String qualification;
	private int experience;
	private String gender;
	
	@Column(columnDefinition = "varchar(20) default 'Active'") // Database default
    private String status = "Active";
	
	private DoctorInfo doctorInfo = new DoctorInfo();
	
	@OneToMany(mappedBy = "doctor", cascade = CascadeType.ALL)
	private List<Appointments> appointments;

	public int getDid() {
		return did;
	}

	public void setDid(int did) {
		this.did = did;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getCnfPassword() {
		return cnfPassword;
	}

	public void setCnfPassword(String cnfPassword) {
		this.cnfPassword = cnfPassword;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getSpecialization() {
		return specialization;
	}

	public void setSpecialization(String specialization) {
		this.specialization = specialization;
	}

	public String getQualification() {
		return qualification;
	}

	public void setQualification(String qualification) {
		this.qualification = qualification;
	}

	public int getExperience() {
		return experience;
	}

	public void setExperience(int experience) {
		this.experience = experience;
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public DoctorInfo getDoctorInfo() {
		return doctorInfo;
	}

	public void setDoctorInfo(DoctorInfo doctorInfo) {
		this.doctorInfo = doctorInfo;
	}

	public List<Appointments> getAppointments() {
		return appointments;
	}

	public void setAppointments(List<Appointments> appointments) {
		this.appointments = appointments;
	}

	@Override
	public String toString() {
		return "Doctor [did=" + did + ", name=" + name + ", email=" + email + ", password=" + password
				+ ", cnfPassword=" + cnfPassword + ", phone=" + phone + ", specialization=" + specialization
				+ ", qualification=" + qualification + ", experience=" + experience + ", gender=" + gender + ", status="
				+ status + ", doctorInfo=" + doctorInfo + ", appointments=" + appointments + "]";
	}


	
}
