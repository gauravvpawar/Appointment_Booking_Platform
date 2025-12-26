package com.example.demo.Service;

import java.util.List;

import com.example.demo.Model.Appointments;
import com.example.demo.Model.Patient;

public interface AppointmentService 
{
	public List<Appointments> findByPatient(Patient patient);
	
	public void saveAppointment(Appointments appointment);
}
