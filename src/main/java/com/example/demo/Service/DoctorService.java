package com.example.demo.Service;

import java.util.List;

import com.example.demo.Model.Doctor;

public interface DoctorService 
{
	public void saveDoctor(Doctor doctor);
	
	public Doctor findDoctor(String email , String password);
	
	public Doctor findByEmail(String email);
	
	public Doctor findById(int did);
	
	public List<Doctor> findAllDoctor();
}
