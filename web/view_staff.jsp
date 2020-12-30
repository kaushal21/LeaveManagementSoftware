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
    <title>View Staff</title>
    <style>
        body{
            background-image: url("WebContent/static/images/dp.jpg");
            background-size: cover;
        }
        .hod_name {
            font-size: 22px;
            font: bold;
        }
        .staff_name {
            font-size: 18px;
            font-family: monospace;
        }
        .border {
            color: white ;
            font-size: 18px;
            border-style: solid ;
            border-color: darkgrey ;
            border-radius: 1.5%;
            width: max-content ;
        }
        a {
            color: white;
        }
        .button {
            border-color: #2D8089;
            background-color: #2D8089;
            color: #FFFFFF;
            font-size: 31px;
            padding: 20px;
            width: 200px;
            cursor: pointer;
            transition: all .1s linear;
        }
        .button:hover {
            background-color: #205C62 ;
            border-top-color: #696969 ;
            border-color: #205C62;
            border-style: solid ;
        }
        .button:active {
            background-color: #205C62;
            border-color: #205C62;
            box-shadow: 0 2px 0 #006599;
            transform: translateY(3px);
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
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
    <script>
        $(document).ready(function() {
            $("#civil").hide();
            $("#computer").hide();
            $("#electrical").hide();
            $("#entc").hide();
            $("#itd").hide();
            $("#mechanical").hide();
            $('input[id="cvl"]').click(function() {
                $("#civil").show();
                $("#computer").hide();
                $("#electrical").hide();
                $("#entc").hide();
                $("#itd").hide();
                $("#mechanical").hide();
            });
            $('input[id="comp"]').click(function() {
                $("#civil").hide();
                $("#computer").show();
                $("#electrical").hide();
                $("#entc").hide();
                $("#itd").hide();
                $("#mechanical").hide();
            });
            $('input[id="elec"]').click(function() {
                $("#civil").hide();
                $("#computer").hide();
                $("#electrical").show();
                $("#entc").hide();
                $("#itd").hide();
                $("#mechanical").hide();
            });
            $('input[id="etc"]').click(function() {
                $("#civil").hide();
                $("#computer").hide();
                $("#electrical").hide();
                $("#entc").show();
                $("#itd").hide();
                $("#mechanical").hide();
            });
            $('input[id="it"]').click(function() {
                $("#civil").hide();
                $("#computer").hide();
                $("#electrical").hide();
                $("#entc").hide();
                $("#itd").show();
                $("#mechanical").hide();
            });
            $('input[id="mech"]').click(function() {
                $("#civil").hide();
                $("#computer").hide();
                $("#electrical").hide();
                $("#entc").hide();
                $("#itd").hide();
                $("#mechanical").show();
            });
        });
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
        int t, cnt;
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
    %>
    <div>
        <div align="center">
            <table>
                <tr>
                    <th><input type="button" class="button" id="cvl" name="dept_choice" value="Civil" style="font-size: 20px; vertical-align:middle;"><span> </span></th>
                    <th><input type="button" class="button" id="comp" name="dept_choice" value="Computer" style="font-size: 20px; vertical-align:middle;"><span> </span></th>
                    <th><input type="button" class="button" id="elec" name="dept_choice" value="Electrical" style="font-size: 20px; vertical-align:middle;"><span> </span></th>
                    <th><input type="button" class="button" id="etc" name="dept_choice" value="E&TC" style="font-size: 20px; vertical-align:middle;"><span> </span></th>
                    <th><input type="button" class="button" id="it" name="dept_choice" value="I.T." style="font-size: 20px; vertical-align:middle;"><span> </span></th>
                    <th><input type="button" class="button" id="mech" name="dept_choice" value="Mechanical" style="font-size: 20px; vertical-align:middle;"><span> </span></th>
                </tr>
            </table>
        </div>
        <div id="civil" align="center">
            <br><br>
            <div class="border">
                <table style="padding: 25px;">
                    <tr>
                        <td class="hod_name">Head Of Department : </td>
                    </tr>
    <%
                t = 0 ; cnt = 0 ;
                ResultSet rs1 = st.executeQuery("select * from login_h where dept='Civil'");
                if ( rs1 != null ) {
                    while ( rs1.next() ) {
    %>
                    <tr>
                        <td class="hod_name" align="center">
                            <a href="admin_hod_profile.jsp?username=<%=rs1.getString("uname") %>">
                                <%=rs1.getString("name") %>
                            </a>
                        </td>
                    </tr>
    <%
                        t++;
                    }
                }
                if ( t == 0 ) {
    %>
                    <tr>
                        <td>
                            <h2 align="center">
                                Record Not Found...
                            </h2>
                        </td>
                    </tr>
    <%
                }
                rs1.close();
    %>
                    <tr>
                        <td class="staff_name">Staff : </td>
                    </tr>
    <%
                rs1 = st.executeQuery("select * from staff_r where dept='Civil'");
                if ( rs1 != null ) {
                    while ( rs1.next() ) {
    %>
                    <tr>
                        <td style="padding-left: 40px;" class="staff_name">
                            <a href="admin_staff_profile.jsp?username=<%=rs1.getString("uname") %>">
                                <%=rs1.getString("name") %>
                            </a>
                        </td>
                    </tr>
    <%
                        cnt++ ;
                    }
                }
                if ( cnt == 0 ) {
    %>
                    <tr>
                        <td>
                            <h2 align="center">
                                Record Not Found...
                            </h2>
                        </td>
                    </tr>
    <%
                }
                rs1.close();
    %>
                </table>
            </div>
        </div>
        <div id="computer" align="center">
            <br><br>
            <div class="border">
                <table style="padding: 25px;">
                    <tr>
                        <td class="hod_name">Head Of Department : </td>
                    </tr>
    <%
                t = 0 ; cnt = 0 ;
                ResultSet rs2 = st.executeQuery("select * from login_h where dept='Computer'");
                if ( rs2 != null ) {
                    while ( rs2.next() ) {
    %>
                    <tr>
                        <td class="hod_name" align="center">
                            <a href="admin_hod_profile.jsp?username=<%=rs2.getString("uname") %>">
                                <%=rs2.getString("name") %>
                            </a>
                        </td>
                    </tr>
    <%
                        t++;
                    }
                }
                if ( t == 0 ) {
    %>
                <tr>
                    <td>
                        <h2 align="center">
                            Record Not Found...
                        </h2>
                    </td>
                </tr>
    <%
                }
                rs2.close();
    %>
                <tr>
                    <td class="staff_name">Staff : </td>
                </tr>
    <%
                rs2 = st.executeQuery("select * from staff_r where dept='Computer'");
                if ( rs2 != null ) {
                    while ( rs2.next() ) {
    %>
                <tr>
                    <td style="padding-left: 40px;" class="staff_name">
                        <a href="admin_staff_profile.jsp?username=<%=rs2.getString("uname") %>">
                            <%=rs2.getString("name") %>
                        </a>
                    </td>
                </tr>
    <%
                        cnt++ ;
                    }
                }
                if ( cnt == 0 ) {
    %>
                <tr>
                    <td>
                        <h2 align="center">
                            Record Not Found...
                        </h2>
                    </td>
                </tr>
    <%
                }
                rs2.close();
    %>
                </table>
            </div>
        </div>
        <div id="electrical" align="center">
            <br><br>
            <div class="border">
                <table style="padding: 25px;">
                    <tr>
                        <td class="hod_name">Head Of Department : </td>
                    </tr>
    <%
                t = 0 ; cnt = 0 ;
                ResultSet rs3 = st.executeQuery("select * from login_h where dept='Electrical'");
                if ( rs3 != null ) {
                    while ( rs3.next() ) {
    %>
                    <tr>
                        <td class="hod_name" align="center">
                            <a href="admin_hod_profile.jsp?username=<%=rs3.getString("uname") %>">
                                <%=rs3.getString("name") %>
                            </a>
                        </td>
                    </tr>
    <%
                        t++;
                    }
                }
                if ( t == 0 ) {
    %>
                    <tr>
                        <td>
                            <h2 align="center">
                                Record Not Found...
                            </h2>
                        </td>
                    </tr>
    <%
                }
                rs3.close();
    %>
                    <tr>
                        <td class="staff_name">Staff : </td>
                    </tr>
    <%
                rs3 = st.executeQuery("select * from staff_r where dept='Electrical'");
                if ( rs3 != null ) {
                    while ( rs3.next() ) {
    %>
                    <tr>
                        <td style="padding-left: 40px;" class="staff_name">
                            <a href="admin_staff_profile.jsp?username=<%=rs3.getString("uname") %>">
                                <%=rs3.getString("name") %>
                            </a>
                        </td>
                    </tr>
    <%
                        cnt++ ;
                    }
                }
                if ( cnt == 0 ) {
    %>
                    <tr>
                        <td>
                            <h2 align="center">
                                Record Not Found...
                            </h2>
                        </td>
                    </tr>
    <%
                }
                rs3.close();
    %>
                </table>
            </div>
        </div>
        <div id="entc" align="center">
            <br><br>
            <div class="border">
                <table style="padding: 25px;">
                    <tr>
                        <td class="hod_name">Head Of Department : </td>
                    </tr>
    <%
                t = 0 ; cnt = 0 ;
                ResultSet rs4 = st.executeQuery("select * from login_h where dept='E&TC'");
                if ( rs4 != null ) {
                    while ( rs4.next() ) {
    %>
                    <tr>
                        <td class="hod_name" align="center">
                            <a href="admin_hod_profile.jsp?username=<%=rs4.getString("uname") %>">
                                <%=rs4.getString("name") %>
                            </a>
                        </td>
                    </tr>
    <%
                        t++;
                    }
                }
                if ( t == 0 ) {
    %>
                    <tr>
                        <td>
                            <h2 align="center">
                                Record Not Found...
                            </h2>
                        </td>
                    </tr>
    <%
                }
                rs4.close();
    %>
                    <tr>
                        <td class="staff_name">Staff : </td>
                    </tr>
    <%
                rs4 = st.executeQuery("select * from staff_r where dept='E&TC'");
                if ( rs4 != null ) {
                    while ( rs4.next() ) {
    %>
                    <tr>
                        <td style="padding-left: 40px;" class="staff_name">
                            <a href="admin_staff_profile.jsp?username=<%=rs4.getString("uname") %>">
                                <%=rs4.getString("name") %>
                            </a>
                        </td>
                    </tr>
    <%
                        cnt++ ;
                    }
                }
                if ( cnt == 0 ) {
    %>
                    <tr>
                        <td>
                            <h2 align="center">
                                Record Not Found...
                            </h2>
                        </td>
                    </tr>
    <%
                }
                rs4.close();
    %>
                </table>
            </div>
        </div>
        <div id="itd" align="center">
            <br><br>
            <div class="border">
                <table style="padding: 25px;">
                    <tr>
                        <td class="hod_name">Head Of Department : </td>
                    </tr>
    <%
                t = 0 ; cnt = 0 ;
                ResultSet rs5 = st.executeQuery("select * from login_h where dept='It'");
                if ( rs5 != null ) {
                    while ( rs5.next() ) {
    %>
                    <tr>
                        <td class="hod_name" align="center">
                            <a href="admin_hod_profile.jsp?username=<%=rs5.getString("uname") %>">
                                <%=rs5.getString("name") %>
                            </a>
                        </td>
                    </tr>
    <%
                        t++;
                    }
                }
                if ( t == 0 ) {
    %>
                    <tr>
                        <td>
                            <h2 align="center">
                                Record Not Found...
                            </h2>
                        </td>
                    </tr>
    <%
                }
                rs5.close();
    %>
                    <tr>
                        <td class="staff_name">Staff : </td>
                    </tr>
    <%
                rs5 = st.executeQuery("select * from staff_r where dept='It'");
                if ( rs5 != null ) {
                    while ( rs5.next() ) {
    %>
                    <tr>
                        <td style="padding-left: 40px;" class="staff_name">
                            <a href="admin_staff_profile.jsp?username=<%=rs5.getString("uname") %>">
                                <%=rs5.getString("name") %>
                            </a>
                        </td>
                    </tr>
    <%
                        cnt++ ;
                    }
                }
                if ( cnt == 0 ) {
    %>
                    <tr>
                        <td>
                            <h2 align="center">
                                Record Not Found...
                            </h2>
                        </td>
                    </tr>
    <%
                }
                rs5.close();
    %>
                </table>
            </div>
        </div>
        <div id="mechanical" align="center">
            <br><br>
            <div class="border">
                <table style="padding: 25px;">
                    <tr>
                        <td class="hod_name">Head Of Department : </td>
                    </tr>
    <%
                t = 0 ; cnt = 0 ;
                ResultSet rs6 = st.executeQuery("select * from login_h where dept='Mechanical'");
                if ( rs6 != null ) {
                    while ( rs6.next() ) {
    %>
                    <tr>
                        <td class="hod_name" align="center">
                            <a href="admin_hod_profile.jsp?username=<%=rs6.getString("uname") %>">
                                <%=rs6.getString("name") %>
                            </a>
                        </td>
                    </tr>
    <%
                        t++;
                    }
                }
                if ( t == 0 ) {
    %>
                    <tr>
                        <td>
                            <h2 align="center">
                                Record Not Found...
                            </h2>
                        </td>
                    </tr>
    <%
                }
                rs6.close();
    %>
                    <tr>
                        <td class="staff_name">Staff : </td>
                    </tr>
    <%
                rs6 = st.executeQuery("select * from staff_r where dept='Mechanical'");
                if ( rs6 != null ) {
                    while ( rs6.next() ) {
    %>
                    <tr>
                        <td style="padding-left: 40px;" class="staff_name">
                            <a href="admin_staff_profile.jsp?username=<%=rs6.getString("uname") %>">
                                <%=rs6.getString("name") %>
                            </a>
                        </td>
                    </tr>
    <%
                        cnt++ ;
                    }
                }
                if ( cnt == 0 ) {
    %>
                    <tr>
                        <td>
                            <h2 align="center">
                                Record Not Found...
                            </h2>
                        </td>
                    </tr>
    <%
                }
                rs6.close();
    %>
                </table>
            </div>
        </div>
    <%
            } else {
                response.sendRedirect("index.html");
            }
        } catch ( Exception e ){
            e.printStackTrace();
            response.sendRedirect("index.html");
        }
    %>
    </div>
    <br>
    <div align="center" style="padding-top: 10px; position: initial;">
        <a href="admin.jsp"><img src="WebContent/static/images/home_page.jpg" style="width: 100px; height: 75px; background: transparent; border: none;"></a>
    </div>
</body>
</html>
