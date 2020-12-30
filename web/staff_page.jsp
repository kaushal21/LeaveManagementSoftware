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
    <title>Staff Page</title>
    <style>
        body {
            background-image: url('WebContent/static/images/dp.jpg');
            background-size: cover;
        }
        td {
            padding-left: 10px;
            padding-bottom: 5px;
            font-family: monospace;
            font-size: 20px;
        }
        option,select {
            padding-left: 10px;
            padding-right: 10px;
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
        .show {
            display:block;
        }
        .text{
            color: aqua;
        }
        .ph{
            color: springgreen;
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
        .submit_button {
            border-radius: 5%;
            background-color: #3162C4;
            border: none;
            color: #FFFFFF;
            font-size: 28px;
            padding: 20px;
            width: 200px;
            cursor: pointer;
        }
        .submit_button:hover {
            background-color: #2550A6;
            border: none;
        }
        .submit_button:active {
            box-shadow: 0 2px 0 #006599;
            transform: translateY(3px);
        }
    </style>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
    <script>
        $(document).ready(function()
        {
            $("#apply_leave").hide();
            $("#past_history").hide();
            $('input[id="appl_leav"]').click(function()
            {
                $("#apply_leave").show();
                $("#past_history").hide();
            });
            $('input[id="past_his"]').click(function()
            {
                $("#past_history").show();
                $("#apply_leave").hide();
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

        function checkBalance() {
            document.getElementById('check_bal').innerHTML = document.getElementById("cb").value ;
        }
    </script>
</head>
<body>
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
                ResultSet temp = st.executeQuery("select * from staff_r where uname='"+username+"'");
                if ( temp != null ) {
                    while ( temp.next() ) {
                        department = temp.getString("dept");
                    }
                }
                temp.close() ;
    %>
    <div style="width: 1400px;">
        <div style="text-align: end; width: 1175px;">
            <div style="position: absolute; padding-top: 3px;" class="dropdown">
                <img src="WebContent/static/images/log2.png" style="width: 60px; height: 40px;" onclick="myFunction()" class="dropbtn">
                <div id="myDropdown" class="dropdown-content" align="left">
                    <a href="profile.jsp?username=<%=username %>">Profile</a>
                    <a href="logout.jsp">Sign Out</a>
                </div>
            </div>
        </div>
    </div>
    <br><br><hr style="border-color: #696969;">
    <div align="center">
        <table>
            <tr>
                <td><input type="button" class="button" id="appl_leav" name="staff_choice" value="Apply Leave" style="font-size: 20px; vertical-align:middle"><span> </span></td>
                <td><input type="button" class="button" id="past_his" name="staff_choice" value="Past History" style="font-size: 20px;"></td>
            </tr>
        </table>
    </div>
    <br>
    <form action="next_staff.jsp" method="post">
        <div id="apply_leave">
    <%
                int tsid = 0 ;
                int mcnt = 0, ccnt = 0 ;
                String tname = null, tdesg = null ;
                ResultSet rs4 = st.executeQuery("select * from staff_r where uname='"+username+"'");
                if ( rs4 != null ) {
                    while ( rs4.next() ) {
                        tsid = rs4.getInt("sid");
                        tname = rs4.getString("name");
                        tdesg = rs4.getString("desg");
                        mcnt = rs4.getInt("m_cnt");
                        ccnt = rs4.getInt("c_cnt");
                    }
                }
                int tot = 60 - ( mcnt + ccnt ) ;
    %>
            <input type="hidden" value="<%=tot %>" id="cb">
            <div class="text">
                <table>
                    <tr>
                        <td>Staff Id : </td>
                        <td><input style="color: highlight; background: transparent; border: none; font-size: 20px;" type="text" name="staff_id" value="<%=tsid %>" readonly="readonly" required></td>
                    </tr>
                    <tr>
                        <td>Name : </td>
                        <td><input style="color: highlight; background: transparent; border: none; font-size: 20px;" type="text" name="name" value="<%=tname %>" readonly="readonly" required></td>
                        <td>Designation : </td>
                        <td><input style="color: highlight; background: transparent; border: none; font-size: 20px;" type="text" name="desg" value="<%=tdesg %>" readonly="readonly" required></td>
                    </tr>
                    <tr>
                        <td>Category</td>
                        <td>
                            <select id="cat" name="category" required>
                                <option value="Medical">Medical</option>
                                <option value="Casual">Casual</option>
                            </select>
                        </td>
                    </tr>
                </table>
                <br>
    <%
                DateTimeFormatter dtf= DateTimeFormatter.ofPattern("yyyy/MM/dd");
                LocalDate localdate=LocalDate.now();
    %>
                <table>
                    <tr>
                        <td>Duration :</td>
                        <td>From</td>
                        <td><input type="date" name="leave_from" value="<%=localdate %>" id="lf" min="<%=localdate %>" required></td>
                        <td>To</td>
                        <td><input type="date" name="leave_to" value="<%=localdate %>" id="lt" min="<%=localdate %>" required></td>
                    </tr>
                </table>
                <table>
                    <tr>
                        <td>Check Balance : </td>
                        <td style="color: highlight; background: transparent; border: none; font-size: 20px; padding-right: 30px; padding-left: 30px; "><span id="check_bal"></span></td>
                        <td><input type="button" value="Check" onclick="checkBalance('');"></td>
                    </tr>
                </table>
                <br>
                <table>
                    <tr>
                        <td style="padding-right: 250px;">Reason (Application)</td>
                    </tr>
                    <tr>
                        <td><input type="text" name="application" style="width: 400px; height: 100px;" required></td>
                    </tr>
                </table>
                <table>
                    <tr>
                        <td>Alternative Staff :</td>
                        <td>
                            <select id="alt_staff" name="alt_staff" required>
    <%
                ResultSet rs3 = st.executeQuery("select * from staff_r where dept='"+department+"'");
                if ( rs3 != null ) {
                    while ( rs3.next() ) {
                        if ( !username.equals(rs3.getString("uname")) ) {
    %>
                            <option value="<%=rs3.getString("name")%>"><%=rs3.getString("name") %></option>
    <%
                        }
                    }
                }
    %>
                            </select>
                        </td>
                    </tr>
                </table>
            </div>
            <div align="center">
                <input type="submit" class="submit_button" value="Submit" style="font-size: 20px; vertical-align:middle">
            </div>
        </div>
    </form>
    <div id="past_history" class="ph">
        <div>
            <table>
    <%
                int sid = 0, t = 0 ;
                ResultSet rs = st.executeQuery("select * from staff_r where uname='"+username+"'");
                if ( rs != null ) {
                    while ( rs.next() ) {
                        if ( username.equals(rs.getString("uname")) ) {
                            sid = rs.getInt("sid");
                        }
                    }
                }
                else {
                    t = 1 ;
                }
                rs.close();
                ResultSet rs1 = st.executeQuery("select * from app_leave");
                if ( rs1 != null ) {
                    while ( rs1.next() ) {
                        if ( rs1.getInt("sid") == sid ) {
    %>
                <tr>
                    <td><%=rs1.getString("date_f") %></td>
                    <td> - </td>
                    <td><%=rs1.getString("date_t") %></td>
                    <td><%=rs1.getString("reas") %></td>
                    <td><%=rs1.getString("cat") %></td>
                    <td>Pending</td>
                </tr>
    <%
                            t++ ;
                        }
                    }
                }
                rs1.close();
                ResultSet rs2 = st.executeQuery("select * from past_h");
                if ( rs2 != null ) {
                    while ( rs2.next() ) {
                        if ( rs2.getInt("sid") == sid ) {
    %>
                <tr>
                    <td><%=rs2.getString("date_f") %></td>
                    <td> - </td>
                    <td><%=rs2.getString("date_t") %></td>
                    <td><%=rs2.getString("reas") %></td>
                    <td><%=rs2.getString("cat") %></td>
                    <td><%=rs2.getString("status") %></td>
                </tr>
    <%
                            t++ ;
                        }
                    }
                }
                rs2.close();
                if ( t == 0 ) {
    %>
                <tr>
                    <td rowspan="6">No Record</td>
                </tr>
    <%
                }
            } else {
                System.out.println("Session null");
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
</body>
</html>
