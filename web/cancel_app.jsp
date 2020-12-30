<%@page import="java.sql.Statement"%>
<%@page import="java.sql.*"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Cancel Application</title>
</head>
<body>
    <%
        try {
            session = request.getSession();
            String username = null;
            if ( session != null ) {
               username=session.getAttribute("username").toString();
            }
            if ( username != null ) {
                Class.forName("com.mysql.jdbc.Driver");
                Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/leave_management",
                    "root","kaushal08");
                Statement st = con.createStatement();
                int sid = 0 ;
                ResultSet rs = st.executeQuery("select * from staff_r where uname='"+username+"'");
                if ( rs != null ) {
                    while ( rs.next() ) {
                        sid = rs.getInt("sid");
                    }
                }
                String sql1 = "delete from app_leave where sid="+sid;
                st.executeUpdate(sql1);
                response.sendRedirect("staff_page.jsp");
            } else {
                response.sendRedirect("index.html");
            }
        }
        catch ( Exception e ) {
            e.printStackTrace();
            response.sendRedirect("index.html");
        }
    %>
</body>
</html>
