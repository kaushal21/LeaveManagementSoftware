<%@page import="java.sql.Statement"%>
<%@page import="java.sql.*"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>HOD's Account Created</title>
    <style>
        .size_header {
            font-size: 35px;
        }
    </style>
</head>
<body style="background: #FAFAFA">
    <div style="width: 1400px;">
        <div class="size_header" style="position: absolute;">
            Leave Management
        </div>
    </div>
    <br><br><hr style="border-color: #696969;">
    <%
        try {
            session = request.getSession();
            String sessn = null;
            if ( session != null ) {
               sessn = session.getAttribute("username").toString();
            }
            if ( sessn != null ) {
                int t = 0 ;
                String name = request.getParameter("name");
                String department = request.getParameter("department");
                String username = request.getParameter("username");
                String password = request.getParameter("password");
                String email = request.getParameter("email");
                String phone = request.getParameter("phone");
                String address = request.getParameter("addr");
                String qualification = request.getParameter("qual");

                Class.forName("com.mysql.jdbc.Driver");
                Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/leave_management",
                    "root","kaushal08");
                Statement st = con.createStatement();
                ResultSet rs1 = st.executeQuery("select * from login_h");
                while ( rs1.next() ) {
                    if( username.equals(rs1.getString("uname")) ) {
    %>
    <div style="font-size: 18px; font-family: serif;" align="center">
        Sign Up Unsuccessful<br>
        <a href="add_hod.html">Click Here</a> To Retry
    </div>
    <%
                        t = 1 ;
                    }
                }
                ResultSet rs2 = st.executeQuery("select * from login_h");
                while ( rs2.next() ) {
                    if( department.equals(rs2.getString("dept"))) {
    %>
    <div style="font-size: 18px; font-family: serif;" align="center">
        HOD Already Exist<br>
        <a href="add_hod.html">Click Here</a> To Retry
    </div>
    <%
                        t = 1 ;
                    }
                }
                String sql = "insert into login_h(name,dept,desg,qual,email,addr,phone,uname,pwd) "
                        + "values('"+name+"','"+department+"','Head of Department','"+qualification+"','"
                        +email+"','"+address+"','"+phone+"','"+username+"','"+password+"')";
                if ( t == 0 ) {
                    st.executeUpdate(sql);
                    t = 101 ;
                }
                if ( t >= 100 ) {
    %>
    <div style="font-size: 18px; font-family: serif;" align="center">
        Your Account Has Been Created
        <br>
        Please Login Now!!!!
        <br>
        <a href="index.html"><button style="font-size: 18px;">Log In</button></a>
    </div>
    <%
                }
            } else {
                response.sendRedirect("index.html");
            }
        } catch(Exception e){
    %>
    <div style="font-size: 18px; font-family: serif;" align="center">
        Exception Found
    </div>
    <%
            e.printStackTrace();
            response.sendRedirect("index.html");
        }
    %>
</body>
</html>
