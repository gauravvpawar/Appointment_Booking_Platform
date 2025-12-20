package com.example.demo.Controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/patient")
public class PatientController 
{
	
	
	@RequestMapping("/")
	public String home()
	{
		return "index";
	}
	
	
	@RequestMapping("/login")
	public String PatientLogin()
	{
		return "Patient/PatientLogin";
	}

//	to register user
	@RequestMapping("/register")
	public String PatientRegister()
	{
		return "Patient/PatientRegister";
	}
	
	@RequestMapping("/savePatient")
	public String savePatient()
	{
		
		return null;
	}
	
}
