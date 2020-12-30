<%@page import="java.sql.Statement"%>
<%@page import="java.sql.*"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Remove Staff</title>
    <style>
        body{
            background-image: url("WebContent/static/images/dp.jpg");
            background-size: cover;
        }
        td {
            font-size: 18px;
            font-family: serif;
            padding-bottom: 10px;
            padding-right: 10px;
        }
        .border {
            color: white ;
            font-size: 19px;
            border-style: solid ;
            border-color: darkgrey ;
            border-radius: 1.5%;
            width: 400px ;
        }
        .dropbtn {
            color: white;
            border: none;
            cursor: pointer;
        }
        .dropbtn:hover, .dropbtn:focus {
            background: transparent;
        }
        .dropdown {
            position: absolute;
            display: inline-block;
        }
        .dropdown-content {
            display: none;
            position: absolute;
            background-color: #f9f9f9;
            min-width: 160px;
            overflow: auto;
            box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
            z-index: 1;
        }
        .dropdown-content a {
            color: black;
            padding: 12px 16px;
            text-decoration: none;
            display: block;
        }
        .dropdown a:hover {background-color: #f1f1f1}
    </style>
    <script>
        /* When the user clicks on the button,
        toggle between hiding and showing the dropdown content */
        function myFunction() {
            document.getElementById("myDropdown").classList.toggle("show");
        }

        // Close the dropdown if the user clicks outside of it
        window.onclick = function(event) {
            if (!event.target.matches('.dropbtn')) {
                var dropdowns = document.getElementsByClassName("dropdown-content");
                var i;
                for (i = 0; i < dropdowns.length; i++) {
                    var openDropdown = dropdowns[i];
                    if (openDropdown.classList.contains('show')) {
                        openDropdown.classList.remove('show');
                    }
                }
            }
        }
    </script>
</head>
<body style="color: white;">
    <%
        String uname = request.getParameter("username");
        try {
            session = request.getSession();
            String username = null;
            if ( session != null ) {
               username = session.getAttribute("username").toString();
            }
            if ( username != null ) {
                Class.forName("com.mysql.jdbc.Driver");
                Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/leave_management",
                        "root","kaushal08");
                Statement st = con.createStatement();
                ResultSet rs = st.executeQuery("select * from staff_r");
    %>
    <div style="width: 1400px;">
        <div style="text-align: end; width: 1175px;">
            <div style="position: absolute; padding-top: 3px;" class="dropdown">
                <img src="WebContent/static/images/log2.png" style="width: 60px; height: 40px;" onclick="myFunction()" class="dropbtn">
                <div id="myDropdown" class="dropdown-content" align="left">
                    <a href="logout.jsp">Sign Out</a>
                </div>
            </div>
        </div>
    </div>
    <br><br><hr style="border-color: #696969;">
    <div align="center">
        <div class="border">
            <h2 align="center">
                HOD's Details
            </h2>
            <table>
    <%
                if ( rs != null ) {
                    while ( rs.next() ) {
                        if ( rs.getString("uname").equals(uname) ) {
    %>
                <tr>
                    <td>Name</td>
                    <td><%=rs.getString("name") %></td>
                </tr>
                <tr>
                    <td>Department</td>
                    <td><%=rs.getString("dept") %></td>
                </tr>
                <tr>
                    <td>Designation</td>
                    <td><%=rs.getString("desg") %></td>
                </tr>
                <tr>
                    <td>Qualification</td>
                    <td><%=rs.getString("qual") %></td>
                </tr>
                <tr>
                    <td>E-mail</td>
                    <td><%=rs.getString("email") %></td>
                </tr>
                <tr>
                    <td>Phone</td>
                    <td><%=rs.getString("phone") %></td>
                </tr>
                <tr>
                    <td>Address</td>
                    <td><%=rs.getString("addr") %></td>
                </tr>
    <%
                        }
                    }
                }
            } else {
                response.sendRedirect("index.html");
            }
        } catch ( Exception e ) {
            e.printStackTrace();
            response.sendRedirect("index.html");
        }
    %>
            </table>
        </div>
    </div>
    <div align="center" style="color: white; font-size: 22px;">
        <br><br>
        <table>
            <tr>
                <td style="padding-left: 100px;">
                    <a href="admin.jsp">
                        <img src="WebContent/static/images/home_page.jpg" style="width: 75px; height: 75px; background: transparent; border: none;">
                    </a>
                </td>
                <td style="padding-left: 100px;">
                    <a href="admin_staff_remove1.jsp?username=<%=uname %>">
                        <img src="WebContent/static/images/cancel.png" style="width: 75px; height: 75px; background: transparent; border: none;">
                    </a>
                </td>
            </tr>
        </table>
    </div>
</body>
</html>
