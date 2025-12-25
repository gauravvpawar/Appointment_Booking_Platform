package com.example.demo.Repo;

import org.springframework.data.jpa.repository.JpaRepository;

import com.example.demo.Model.Doctor;

public interface DoctorRepo extends JpaRepository<Doctor, Integer>
{
	public Doctor findByEmail(String email);
	
	public Doctor findByEmailAndPassword(String email , String password);
}
