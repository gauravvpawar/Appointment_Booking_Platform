package com.example.demo.Dao;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo.Model.Patient;
import com.example.demo.Repo.PatientRepo;
import com.example.demo.Service.PatientService;

@Service
public class PatientDao implements PatientService
{
	
	@Autowired
	PatientRepo pr;
	
	public void savePatient(Patient p) 
	{
		 pr.save(p);
	}
	
	public Patient findById(int id)
	{
		return pr.findById(id).orElse(null);
	}

	@Override
	public Patient loginPatient(String email, String password) {
		
		return pr.findByEmailAndPassword(email, password);
	}
	
	public Patient findByEmail(String email)
	{
		return pr.findByEmail(email);
	}
}
