package com.example.demo.Service;

import com.example.demo.Model.Patient;

public interface PatientService 
{
	public void savePatient(Patient p);
	
	public Patient findByEmail(String email);
	
	public Patient loginPatient(String email , String password);
}
