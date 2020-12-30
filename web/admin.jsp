<%@page import="java.time.LocalDate"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.mysql.jdbc.CommunicationsException" %>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.*"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Admin Page</title>
    <link rel="stylesheet" href="WebContent/static/style.css">
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
<body class="bg-white">
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
    <%
        try{
            session = request.getSession();
            String sessn = null;
            if( session != null ) {
               sessn=session.getAttribute("username").toString();
            }
            if( sessn != null ) {
                Class.forName("com.mysql.jdbc.Driver");
                Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/leave_management",
                        "root","kaushal08");
                Statement st = con.createStatement();
                ResultSet rs = st.executeQuery("select * from login_h");
    %>
    <div class="hod_det">
        <div class="size_hod_header" align="center">
            HOD's Available
        </div>
        <div class="size_hod">
            <ul>
    <%
                if ( rs != null ) {
                    while ( rs.next() ) {
    %>
                <a href="admin_hod_profile.jsp?username=<%=rs.getString("uname") %>" >
                    <li><%=rs.getString("name") %></li>
                </a>
    <%
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
            </ul>
        </div>
    </div>
    <div>
        <table>
            <tr>
                <td>
                    <a href="add_hod.html">
                        <button class="button">Add HOD</button>
                    </a>
                </td>
                <td>
                    <a href="view_staff.jsp">
                        <button class="button">View Staff</button>
                    </a>
                </td>
                <td>
                    <a href="edit_leave_app.jsp">
                        <button class="button">Edit Leave Application</button>
                    </a>
                </td>
                <td>
                    <a href="remove_staff.jsp">
                        <button class="button">Remove Staff</button>
                    </a>
                </td>
            </tr>
        </table>
    </div>
</body>
</html>
