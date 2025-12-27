package com.example.demo.Model;

import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Embedded;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;


@Entity
public class Patient 
{
	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private int id;
	private String name;
	private String email;
	private String password;
	private String cnfPassword;
	private String phone;
	private String gender;
	private int age;
	
	@Column(columnDefinition = "varchar(20) default 'Active'") // Database default
    private String status = "Active";
	
	@Embedded
	private PatientInfo patientinfo = new PatientInfo();
	 
	@OneToMany(mappedBy = "patient", cascade = CascadeType.ALL)
	    private List<Appointments> appointments;

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
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

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public int getAge() {
		return age;
	}

	public void setAge(int age) {
		this.age = age;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public PatientInfo getPatientinfo() {
		return patientinfo;
	}

	public void setPatientinfo(PatientInfo patientinfo) {
		this.patientinfo = patientinfo;
	}

	public List<Appointments> getAppointments() {
		return appointments;
	}

	public void setAppointments(List<Appointments> appointments) {
		this.appointments = appointments;
	}

	@Override
	public String toString() {
		return "Patient [id=" + id + ", name=" + name + ", email=" + email + ", password=" + password + ", cnfPassword="
				+ cnfPassword + ", phone=" + phone + ", gender=" + gender + ", age=" + age + ", status=" + status
				+ ", patientinfo=" + patientinfo + ", appointments=" + appointments + "]";
	}
	
}
