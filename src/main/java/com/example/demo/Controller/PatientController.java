package com.example.demo.Controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.example.demo.Model.Patient;
import com.example.demo.Service.PatientService;


@Controller
@RequestMapping("/patient")
public class PatientController 
{
	@Autowired
	PatientService ps;
	
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

	@RequestMapping("/register")
	public String PatientRegister()
	{
		
		return "Patient/PatientRegister";
	}
	
//	to register user
	@RequestMapping("/savePatient")
	public String savePatient(@ModelAttribute Patient p , RedirectAttributes redirectAttribute)
	{
		System.out.println(p);
		ps.savePatient(p);
		
		redirectAttribute.addFlashAttribute("msg","Patient registered Successfully");
		
		return "redirect:/";
	}
	
}
