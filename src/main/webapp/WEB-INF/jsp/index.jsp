<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
	<script type="text/javascript">
	
	</script>
</body>
</html>