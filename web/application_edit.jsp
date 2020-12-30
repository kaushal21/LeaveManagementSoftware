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
    <title>Application Requested</title>
    <style>
         body{
            background-image: url("WebContent/static/images/dp.jpg");
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
        .text {
            color: aqua;
        }
        .submit_button {
            border-radius: 5%;
            background-color: #3162C4;
            border: none;
            color: #FFFFFF;
            font-size: 28px;
            padding: 10px;
            width: 150px;
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
</head>
<body>
    <%
        try {
            int sid = 0;
            String name = null, desg = null, cat = null, reason = null, alt_s = null ;
            Date dt = null, df = null ;
            String username =null, department = null ;
            session = request.getSession();
            if ( session != null ) {
                username = (String) session.getAttribute("username") ;
            }
            if ( username != null ) {
                Class.forName("com.mysql.jdbc.Driver");
                Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/leave_management",
                    "root","kaushal08");
                Statement st = con.createStatement();
                ResultSet rs1 = st.executeQuery("select * from staff_r where uname='"+username+"'");
                if ( rs1 != null ) {
                    while ( rs1.next() ) {
                        sid = rs1.getInt("sid");
                        desg = rs1.getString("desg");
                        department = rs1.getString("dept");
                    }
                }
                rs1.close() ;
                ResultSet rs = st.executeQuery("select * from app_leave where sid="+sid);
                if ( rs != null ) {
                    while ( rs.next() ) {
                        name = rs.getString("name");
                        df = rs.getDate("date_f");
                        dt = rs.getDate("date_t");
                        cat = rs.getString("cat");
                        reason = rs.getString("reas");
                        alt_s = rs.getString("alt_s");
                    }
                }
                rs.close() ;
                String sql2 = "delete from app_leave where sid="+sid ;
                st.executeUpdate(sql2);
    %>
    <br><br><hr style="border-color: #696969;">
    <div align="center" style="color:white; font-size: 35px;">
        Edit
        <img src="WebContent/static/images/edit_notes.png" style="width: 50px; height: 30px;">
    </div>
    <form method="post" action="next_staff.jsp">
        <div id="apply_leave">
            <div class="text">
                <table>
                    <tr>
                        <td>Staff Id : </td>
                        <td><input style="color: highlight; background: transparent; border: none; font-size: 20px;" type="text" name="staff_id" value="<%=sid %>" readonly="readonly" required></td>
                    </tr>
                    <tr>
                        <td>Name : </td>
                        <td><input style="color: highlight; background: transparent; border: none; font-size: 20px;" type="text" name="name" value="<%=name %>" readonly="readonly" required></td>
                        <td>Designation : </td>
                        <td><input style="color: highlight; background: transparent; border: none; font-size: 20px;" type="text" name="desg" value="<%=desg %>" readonly="readonly" required></td>
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
                        <td><input type="date" name="leave_from" value="<%=df %>" min="<%=localdate %>" required></td>
                        <td>To</td>
                        <td><input type="date" name="leave_to" value="<%=dt %>" min="<%=localdate %>" required></td>
                    </tr>
                </table>
                <br>
                <table>
                    <tr>
                        <td style="padding-right: 250px;">Reason (Application)</td>
                    </tr>
                    <tr>
                        <td><input type="text" name="application" style="width: 400px; height: 100px;" value="<%=reason %>" required></td>
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
        </div>
        <div align="center" style="padding-top: 20px; font-size: 18px;">
            <input type="submit" class="submit_button" value="Submit" style="font-size: 20px; vertical-align:middle">
        </div>
    </form>
    <%
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
