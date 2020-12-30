<%@page import="java.sql.Statement"%>
<%@page import="java.sql.*"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.util.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Staff Remove</title>
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
                String del1 = "delete from login_s where uname='"+username+"'";
                String del = "delete from staff_r where uname='"+username+"'";
                st.executeUpdate(del1);
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
