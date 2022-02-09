package com.grv.controllers;

import java.util.List;
import java.util.Map;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.ResponseBody;

import com.grv.services.FileService;

@Controller
public class MainController {
	
	@Value("${file.source.path}")
	String sourceDir;
	
	@GetMapping("/")
	public String viewIndex(Model model) {
		model.addAttribute("myName", "grv");
		model.addAttribute("dirFiles", FileService.showFiles(sourceDir));
		return "index";
	}
	
	@GetMapping("/{folder}")
	public String viewDir(Model model, @PathVariable String folder) {
		
		model.addAttribute("myName","grv");
		model.addAttribute("dirFiles", FileService.showFiles(sourceDir+"\\"+folder));
		return "index";
	}
	@GetMapping("/latestFile")
	public String viewLatestFile(Model model) {
		model.addAttribute("latestFiles", FileService.showLatestFiles(sourceDir));
		return "index";
	}
	
	@GetMapping("/folderStructure")
	public String viewFolderStructure(Model model) {
		Map<String, Map<String, List<String>>> folderStructure = FileService.getFolderStructure(sourceDir);
		model.addAttribute("folderStructure", folderStructure);
		
		model.addAttribute("sourceFolders", FileService.getFolders(sourceDir, "", ""));
		
		return "index";
	}
	
	@GetMapping("/getsubFolders/{folder}/{subFolder}")
	@ResponseBody
	public List<String> getsubFolders(@PathVariable String folder, @PathVariable String subFolder){
		return FileService.getFolders(sourceDir, folder, subFolder);
	}
	
	@GetMapping("/getFolders/{folder}")
	@ResponseBody
	public List<String> getFolders(@PathVariable String folder){
		return FileService.getFolders(sourceDir, folder, "");
	}
	
	
}
