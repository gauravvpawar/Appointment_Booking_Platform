package com.example.demo.Dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo.Model.Appointments;
import com.example.demo.Model.Doctor;
import com.example.demo.Model.Patient;
import com.example.demo.Repo.AppointmentRepo;
import com.example.demo.Service.AppointmentService;

@Service
public class AppointmentDao implements AppointmentService
{
	@Autowired
	AppointmentRepo ar;
	
	    
	    @Override
	    public List<Appointments> findByPatient(Patient patient) {
	        return ar.findByPatient(patient);
	    }
	    
	    @Override
	    public List<Appointments> findByDoctor(Doctor doctor) {
	        return ar.findByDoctor(doctor);
	    }
	    
	    @Override
	    public Appointments findById(int id) {
	        return ar.findById(id).orElse(null);
	    }

	    @Override
	    public void saveAppointment(Appointments appointment) {
	        ar.save(appointment);
	    }
	    
	    @Override
	    public void deleteAppointment(int id) {
	        ar.deleteById(id);
	    }
	    
	    @Override
	    public List<Appointments> findAll() {
	        return ar.findAll();
	    }

}	
