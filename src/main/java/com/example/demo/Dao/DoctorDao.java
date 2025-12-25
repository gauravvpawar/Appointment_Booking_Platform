package com.example.demo.Dao;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo.Model.Doctor;
import com.example.demo.Repo.DoctorRepo;
import com.example.demo.Service.DoctorService;

@Service
public class DoctorDao implements DoctorService
{

	@Autowired
	DoctorRepo dr;
	
	@Override
	public void saveDoctor(Doctor doctor) {
		dr.save(doctor);
	}
	
	public Doctor findByEmail(String email)
	{
		return dr.findByEmail(email);
	}
	
	public Doctor findDoctor(String email , String password)
	{
		return dr.findByEmailAndPassword(email, password);
	}

	public Doctor findById(int id)
	{
		return dr.findById(id).orElse(null);
	}
}
