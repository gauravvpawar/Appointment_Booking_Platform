package com.example.demo.Service;

import java.util.List;

import com.example.demo.Model.Appointments;
import com.example.demo.Model.Doctor;
import com.example.demo.Model.Patient;

public interface AppointmentService 
{
	public List<Appointments> findByPatient(Patient patient);
    
    public List<Appointments> findByDoctor(Doctor doctor);
    
    public Appointments findById(int id);
    
    public void saveAppointment(Appointments appointment);
    
    public void deleteAppointment(int id);
    
    public List<Appointments> findAll();
}
