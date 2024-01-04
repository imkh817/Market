package com.example.demo.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.example.demo.model.Category;
import com.example.demo.service.CategoryService;

@Controller
public class HomeController {
	
	@Autowired
	CategoryService CategoryService;
	
	@RequestMapping("home")
	public String home(){
		return "home";
	}
	
	@RequestMapping("navbar")
	public String nav_category(Model model) {
		List<Category> cg_list = CategoryService.get_category();
		model.addAttribute("cg_list", cg_list);
		return "include/navbar";
	}
}
