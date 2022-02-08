package com.grv.controllers;

import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

import com.grv.services.FileService;

@Controller
public class MainController {
	
	@Autowired
	private FileService fileService;
	
	@Value("${file.source.path}")
	String sourceDir;
	
	@GetMapping("/")
	public String viewIndex(Model model) {
		model.addAttribute("myName", "grv");
		model.addAttribute("dirFiles", fileService.showFiles(sourceDir));
		return "index";
	}
	
	@GetMapping("/{folder}")
	public String viewDir(Model model, @PathVariable String folder) {
		
		model.addAttribute("myName","grv");
		model.addAttribute("dirFiles", fileService.showFiles(sourceDir+"\\"+folder));
		return "index";
	}
	@GetMapping("/latestFile")
	public String viewLatestFile(Model model) {
		model.addAttribute("latestFiles", fileService.showLatestFiles(sourceDir));
		return "index";
	}
	
}
