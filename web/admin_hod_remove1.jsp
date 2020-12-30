<%@page import="java.sql.Statement"%>
<%@page import="java.sql.*"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>remove staff</title>
</head>
<body>
    <%
        try {
            session = request.getSession();
            String sessn = null;
            if ( session != null ) {
               sessn = session.getAttribute("username").toString();
            }
            if ( sessn != null ) {
                Class.forName("com.mysql.jdbc.Driver");
                Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/leave_management",
                        "root","kaushal08");
                Statement st = con.createStatement();
                String username = request.getParameter("username");
                String del = "delete from login_h where uname='"+username+"'";
                st.executeUpdate(del);
                response.sendRedirect("staff_deleted.html");
            } else {
                response.sendRedirect("index.html");
            }
        } catch ( Exception e ) {
            e.printStackTrace();
            response.sendRedirect("index.html");
        }
    %>
</body>
</html>
