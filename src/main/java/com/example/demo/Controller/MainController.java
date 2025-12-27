package com.example.demo.Controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.example.demo.Model.Doctor;
import com.example.demo.Service.DoctorService;

@Controller
public class MainController 
{
	@Autowired
	DoctorService ds;
	
	@RequestMapping("/")
	public String home(Model m)
	{
		List<Doctor> doctorList = ds.findAllDoctor();
		m.addAttribute("doctorList", doctorList);
		return "index";
	}
}
