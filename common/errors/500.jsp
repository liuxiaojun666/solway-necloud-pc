<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isErrorPage="true"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
response.setStatus(HttpServletResponse.SC_OK);
String path=request.getContextPath();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GB18030">
<title>Insert title here</title>
</head>
<body>
<h1>又丢人了!</h1>
<h4>状态：${pageContext.errorData.statusCode}</h4>
<h4>页面：${pageContext.errorData.requestURI}</h4>
<h4>信息：${pageContext.exception}</h4>
<pre style="background-color: #ffffcc;line-height: 110%;">
堆栈信息：<br/>
<c:forEach var="trace" items="${pageContext.exception.stackTrace}">
${trace}
</c:forEach>
</pre>
</body>
</html>

