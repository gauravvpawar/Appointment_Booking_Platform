package com.example.demo.Repo;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.example.demo.Model.Appointments;
import com.example.demo.Model.Patient;

public interface AppointmentRepo extends JpaRepository<Appointments, Integer>
{
	public List<Appointments> findByPatient(Patient patient);
}
