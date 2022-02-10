<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" integrity="sha512-Fo3rlrZj/k7ujTnHg4CGR2D7kSs0v4LLanw2qksYuRlEzO+tcaEPQogQ0KaoGN26/zrn20ImR1DfuLWnOo7aBA==" crossorigin="anonymous" referrerpolicy="no-referrer" />
</head>
<body>
	<h1>Hello, ${myName }</h1>
	
	<table border=1>
		<thead>
			<tr><th>#</th><th>Files</th></tr>
		</thead>
		<tbody>
			<c:forEach items="${dirFiles}" var="filesAndDirs">
				<c:forEach items="${filesAndDirs.value}" var="file">
					<tr>
						<td><i class="fas ${filesAndDirs.key=='dir'?'fa-folder-open':'fa-file' }" style="color:red !important;"></i></td>
						<c:choose>
							<c:when test="${filesAndDirs.key=='dir' }">
								<td><a href="<c:url value = "/${file }"/>">${file}</a></td>
							</c:when>
							<c:otherwise>
								<td>${file }</td>
							</c:otherwise>
						</c:choose>
					</tr>
				</c:forEach>
			</c:forEach>
		</tbody>
	</table>
	
	<p>${latestFiles}</p>
	
	<p>${folderStructure}</p>
	<h2>Form 1</h2>
	<form action="">
		<label>Source Folder:</label>
		<select id="sourceFolders" name="sourceFolder">
			<option value=""></option>
			<c:forEach items="${folderStructure}" var="sourceFolder">
				<option value="${sourceFolder.key }">${sourceFolder.key}</option>
			</c:forEach>
		</select>
		<br/>
		<label>Sub Folder:</label>
		<select id="" name="subFolder">
		</select>
	</form>
	
	<h2>Form 2</h2>
	<form action="">
		<label>Source Folder:</label>
		<select id="srcFolders" name="srcFolders">
			<option value=""></option>
			<c:forEach items="${sourceFolders}" var="srcFolder">
				<option value="${srcFolder}">${srcFolder}</option>
			</c:forEach>
		</select>
		<br/>
		<label>Sub Folder:</label>
		<select id="subFolders" name="subFolders"></select>
		<br/>
		<label>Files</label>
		<select id="files" name="files"></select>
	</form>
	
	<script type="text/javascript">
		var srcFolders = document.getElementById("srcFolders");
		var subFolders = document.getElementById("subFolders");
		var files = document.getElementById("files");
		srcFolders.addEventListener("change", function(){
			removeOptions(subFolders);
			const xhttp = new XMLHttpRequest();
			xhttp.open("GET", "/getFolders/"+srcFolders.value, false);
			xhttp.send();
			if(xhttp.status==200){
				var response = xhttp.responseText;
				response = changeResponseToArray(response);
				var option = document.createElement("option");
				option.value = "";
				option.innerHTML = "";
				subFolders.appendChild(option);
				for(var i=0; i<response.length;i++){
					var option = document.createElement("option");
					option.value = response[i];
					option.innerHTML = response[i];
					subFolders.appendChild(option);
				}
			}else{
				//handle error
			}
			
		});
		subFolders.addEventListener("change", function(){
			console.log("subFolders event triggered...");
			removeOptions(files);
			const xhttp = new XMLHttpRequest();
			xhttp.open("GET", "/getsubFolders/"+srcFolders.value+"/"+subFolders.value, false);
			xhttp.send();
			if(xhttp.status==200){
				var response = xhttp.responseText;
				response = changeResponseToArray(response);
				var option = document.createElement("option");
				option.value = "";
				option.innerHTML = "";
				files.appendChild(option);
				for(var i=0; i<response.length;i++){
					var option = document.createElement("option");
					option.value = response[i]
					option.innerHTML = response[i];
					files.appendChild(option);
				}
			}else{
				//handle error
			}
		});
		function changeResponseToArray(response){
			response = response.replaceAll("[","");
			response = response.replaceAll("]","");
			response = response.replaceAll("\"","");
			response = response.split(",");
			return response;
		}
	//***********************************************************************************
		var sourceFolders = document.getElementById("sourceFolders");
		var selectedSourceFolder = sourceFolders.value;
		console.log(selectedSourceFolder);
		sourceFolders.addEventListener("change", function(){
			var subFolders = document.getElementById("subFolders");
			console.log("subFolders: ", subFolders);

			removeOptions(subFolders);
			<%
				Map<String, Map<String, List<String>>> subF = (Map)request.getAttribute("folderStructure");
				for(String subFolder: subF.get("2021_NDC29").keySet()) {
			%>
				var option = document.createElement("option");
				option.value = "<%=subFolder %>";
				option.innerHTML = "<%=subFolder %>";
				subFolders.appendChild(option);
			<% 
				}
			%> 
		});
		
		function removeOptions(selectElement) {
			var i, L = selectElement.options.length - 1;
			for(i = L; i >= 0; i--) {
				selectElement.remove(i);
			}
		}
	</script>
</body>
</html>