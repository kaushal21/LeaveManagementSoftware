<%@page import="java.sql.Statement"%>
<%@page import="java.sql.*"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Intermediate Page</title>
    <link rel="stylesheet" href="WebContent/static/style.css">
</head>
<body>
    <br><br><hr style="border-color: #696969;">
    <%
        int t = 0 ;
        String username = request.getParameter("uname");
        String password = request.getParameter("pwd");
        try
        {

        Class.forName("com.mysql.jdbc.Driver");
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/leave_management",
                "root", "kaushal08");
        Statement st = con.createStatement();
        ResultSet rs = st.executeQuery("select * from admin");
        while ( rs.next() )
        {
            if( username.equals(rs.getString("uname")))
            {
                if( password.equals(rs.getString("pwd")))
                {
                    session = request.getSession() ;
                    session.setAttribute("username", username);
                    response.sendRedirect("admin.jsp");
                    t = 1 ;
                }
            }
        }
        rs.close();

        ResultSet rs1 = st.executeQuery("select * from login_h");
        while ( rs1.next() )
        {
            if( username.equals(rs1.getString("uname")))
            {
                if( password.equals(rs1.getString("pwd")))
                {
                    session = request.getSession() ;
                    session.setAttribute("username", username);
                    response.sendRedirect("hod_page.jsp");
                    t = 2 ;
                }
            }
        }
        rs1.close();

        ResultSet rs2 = st.executeQuery("select * from login_s");
        while ( rs2.next() )
        {
            if( username.equals(rs2.getString("uname")))
            {
                if( password.equals(rs2.getString("pwd")))
                {
                    session = request.getSession() ;
                    session.setAttribute("username", username);
                    response.sendRedirect("staff_page.jsp");
                    t = 3 ;
                }
            }
        }
        rs2.close();
        }
        catch(Exception e)
        {
            %>
            <div style="font-size: 18px; color:white; font-family: serif;" align="center">
                Exception Found
                <%=t %>
            </div>
    <%
        }
        if ( t == 0 )
        {
            %>
            <div style="font-size: 25px; color: white;  font-family:monospace;" align="center">
                <b>Login Failed</b><br><br>
            </div>
            <div style="font-size: 22px; color: white;  font-family:monospace;" align="center">
                Please Try Again <a href="index.html" style="color:cyan ">Click Here</a>
            </div>

    <%
        }
        %>
</body>
</html>
