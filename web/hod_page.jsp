<%@page import="java.time.LocalDate"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.*"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>HOD Home Page</title>
    <link rel="stylesheet" href="WebContent/static/style.css">
</head>
<body class="bg-white">
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
        function printDiv(divName) {
            var printContents = document.getElementById(divName).innerHTML;
            var originalContents = document.body.innerHTML;
            document.body.innerHTML = printContents;
            window.print();
            document.body.innerHTML = originalContents;
        }
    </script>
    <%
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
                String department = null ;
                ResultSet temp = st.executeQuery("select * from login_h where uname='"+username+"'");
                if ( temp != null ) {
                    while ( temp.next() ) {
                        department = temp.getString("dept");
                    }
                }
                temp.close() ;
                ResultSet rs = st.executeQuery("select * from staff_r where dept='"+department+"'");
    %>
    <div style="width: 1400px;">
        <div class="size_header" style="position: absolute;"></div>
        <div style="text-align: end; width: 1175px;">
            <div style="position: absolute; padding-top: 3px;" class="dropdown">
                <img src="WebContent/static/images/log2.png" style="width: 60px; height: 40px;" onclick="myFunction()" class="dropbtn">
                <div id="myDropdown" class="dropdown-content" align="left">
                    <a href="hod_profile.jsp?username=<%=username%>">Profile</a>
                    <a href="logout.jsp">Sign Out</a>
                </div>
            </div>
        </div>
    </div>
    <br><br><hr style="border-color: #696969;">
    <div class="teacher_det">
        <div class="size_teacher_header" align="center">Teacher's Details</div>
        <div class="size_teacher">
            <ul>
    <%
                if ( rs != null )
                {
                    while ( rs.next() )
                    {
    %>
                <a href="teacher.jsp?teacher_uname=<%=rs.getString("uname") %>">
                    <li><%=rs.getString("name") %></li>
                </a>
    <%
                    }
                }
    %>
            </ul>
        </div>
    </div>
    <div class="leave_req" style="padding-left:25px;">
        <div class="leave_text">
        <h2 align="center">Leave Request</h2>
            <table>
    <%
                int t1 = 0 ;
                ResultSet rs1 = st.executeQuery("select al.date_f, al.date_t, al.name, al.reas from app_leave al, staff_r sr where sr.dept='"+department+"' and sr.name=al.name");
                if ( rs1 != null ) {
                    while ( rs1.next() ) {
                        t1++ ;
    %>
                <tr>
                    <td><%=rs1.getDate("date_f") %></td>
                    <td> - </td>
                    <td><%=rs1.getDate("date_t") %></td>
                    <td><%=rs1.getString("name") %></td>
                    <td><%=rs1.getString("reas") %></td>
                    <td>
                        <a href="accepted.jsp?name=<%= rs1.getString("name") %>">
                            <button>Accept</button>
                        </a>
                    </td>
                    <td>
                        <a href="decline.jsp?name=<%= rs1.getString("name") %>">
                            <button>Decline</button>
                        </a>
                    </td>
                </tr>
    <%
                    }
                }
                rs1.close();
                if ( t1 == 0 )
                {
    %>
                <tr>
                    <td rowspan="4">No Leave Request</td>
                </tr>
    <%
                }
    %>
            </table>
        </div>
    </div>
    <br>
    <div class="leave_app" style="padding-left: 25px;" id="leave_app">
        <div class="leave_text" id="leave_text">
        <h2 align="center">Today On Leave (Approved)</h2>
            <table>
    <%
                int t2 = 0 ;
                DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy/MM/dd");
                LocalDate localdate = LocalDate.now();

                ResultSet rs2 = st.executeQuery("select ph.date_f, ph.date_t, ph.name, ph.reas, ph.alt_s from past_h ph, staff_r sr where ph.date_f <= '"+dtf.format(localdate)+"' AND ph.date_t >= '"+dtf.format(localdate)+"' AND ph.status='Accepted' AND sr.dept='"+department+"' AND sr.name=ph.name");
                if ( rs2 != null ) {
                    while ( rs2.next() ) {
                        t2++ ;
    %>
                <tr>
                    <td><%=rs2.getDate("date_f") %></td>
                    <td> - </td>
                    <td><%=rs2.getDate("date_t") %></td>
                    <td><%=rs2.getString("name") %></td>
                    <td><%=rs2.getString("reas") %></td>
                    <td><%=rs2.getString("alt_s") %></td>
                </tr>
    <%
                    }
                }
                rs2.close();
                if ( t2 == 0 ) {
    %>
                <tr>
                    <td rowspan="4" align="center">No One on Leave</td>
                </tr>
    <%
                }
    %>
            </table>
        </div>
    <%
                if ( t2 != 0 ) {
    %>
        <table style="padding-bottom: 10px;">
            <tr>
                <td rowspan="7" colspan="7" style="padding-left: 650px;">
                    <a href="#" onclick="printDiv('leave_text')">
                        <button class="print-button"><span class="print-icon">PRINT</span></button>
                    </a>
                </td>
            </tr>
        </table>
    <%
                }
             } else {
                    response.sendRedirect("signup.html");
            }
        } catch ( Exception e ) {
            e.printStackTrace();
            response.sendRedirect("index.html");
        }
    %>
    </div>
</body>
</html>
