package com.example.demo.Repo;

import org.springframework.data.jpa.repository.JpaRepository;

import com.example.demo.Model.Patient;

public interface PatientRepo extends JpaRepository<Patient, Integer>
{	
	// create the custom method for to fetch patient email and password
	public Patient findByEmailAndPassword(String email ,String password);
	
	//for email only
	public Patient findByEmail(String email);
}	
