package com.grv.services;

import java.io.File;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Pattern;

import org.springframework.stereotype.Service;

@Service
public class FileService {
	
	public Map<String, List<String>> showFiles(String sourceDir) {
		Map<String, List<String>> showDirFilesAndFolders = showDirFilesAndFolder(sourceDir);
		return showDirFilesAndFolders;
	}
	
	public List<String> showLatestFiles(String sourceDir){
		List<String> latestFile = new ArrayList<>();
		showLatestFile(sourceDir, latestFile);
		return latestFile;
	}

	private void showLatestFile(String sourceDir, List<String> latestFile) {
		File file = new File(sourceDir);
		List<String> directory = new ArrayList<>();
		
		//find required file paths - first dir
		String regex1 = "\\d*_[A-Z]*\\d*";
		//find required file paths - 2nd dir
		String regex2 = "\\w{3}\\d*_\\w{2}\\d{2}_\\w\\d_\\w{2}_\\d*(.)?\\d";
		for(File f: file.listFiles()) {
			if(f.isDirectory()) {
				if(Pattern.matches(regex1, f.getName()) || Pattern.matches(regex2, f.getName())) {
					directory.add(f.getAbsolutePath());
				}
			}
		}
		int count = 0;
		Collections.reverse(directory);
		System.out.println(directory.get(0));
		for(File f: new File(directory.get(0)).listFiles()) {
			if(f.isDirectory()) {
				count++;
			}else if(count==0) {
				latestFile.add(f.getName());
				//can add copy file here
			}
		}
		if(count!=0) {
			showLatestFile(directory.get(0), latestFile);
		}
	}

	private Map<String, List<String>> showDirFilesAndFolder(String source) {
		List<String> files = new ArrayList<String>();
		List<String> dirs = new ArrayList<String>();
		getFiles(source, files, dirs);
		Map<String, List<String>> filesAndDirs = new HashMap<>();
		filesAndDirs.put("file", files);
		filesAndDirs.put("dir", dirs);
		return filesAndDirs;
	}

	private void getFiles(String source, List<String> files, List<String> dirs) {
		File[] listFiles = new File(source).listFiles();
		if(listFiles.length>0)
		for(File file: listFiles) {
			if(file.isFile()) {
				files.add(file.getName());
			}else if(file.isDirectory()) {
				dirs.add(file.getName());
				//getFiles(source+"\\"+file.getName(),files);
			}
		}
	}
	
	private void getFiles(String source, List<String> files) {
		File[] listFiles = new File(source).listFiles();
		for(File file: listFiles) {
			if(file.isFile()) {
				files.add(file.getAbsolutePath());
			}else if(file.isDirectory()) {
				getFiles(source+"\\"+file.getName(),files);
			}
		}
	}
	
	
}
