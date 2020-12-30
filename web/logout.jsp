<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Leave Management System</title>
</head>
<body>
    <h1>Logout Successfully </h1>
    <%
        response.setHeader("Cache-Control", "no-store");
        response.setHeader("Pragma", "no-cache");
        response.setHeader("Expires", "0");
        session=request.getSession(false);
        session.removeAttribute("username");
        session.setAttribute("username",null);
        session.invalidate();
        response.sendRedirect("index.html");

    %>
    </body>
</html>
