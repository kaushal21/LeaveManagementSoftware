<%@page import="java.sql.Statement"%>
<%@page import="java.sql.*"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Application Submitted</title>
    <style>
         body{
            background-image: url("WebContent/static/images/dp.jpg");
            background-size: cover;
        }
        td {
            padding-left: 10px;
            padding-bottom: 5px;
            font-family: serif;
            font-size: 18px;
        }
        .buttons {
            padding-left: 100px;
        }
        .sry{
            font-size: 20px;
            font-family: cursive;
            color: white;
        }
    </style>
    <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
    <script src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.10.2/jquery-ui.min.js"></script>
    <script>
        $(document).ready(function() {
            function disableBack() {
                window.history.forward();
            }
            window.onload = disableBack();
            window.onpageshow = function(evt) { if (evt.persisted) disableBack() }
        });
    </script>
</head>
<body>
    <br><br><hr style="border-color: #696969;">
    <%
        try {
            session = request.getSession();
            String username = null;
            if ( session != null ) {
               username=session.getAttribute("username").toString();
            }
            if ( username != null ) {
                int t = 0 ;
                int sid = Integer.parseInt(request.getParameter("staff_id")) ;
                String name = request.getParameter("name");
                String designation = request.getParameter("desg");
                Date dt = Date.valueOf(request.getParameter("leave_to"));
                Date df = Date.valueOf(request.getParameter("leave_from"));
                String cat = request.getParameter("category");
                String alt_s = request.getParameter("alt_staff");
                String reason = request.getParameter("application");

                Class.forName("com.mysql.jdbc.Driver");
                Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/leave_management",
                    "root","kaushal08");
                Statement st = con.createStatement();
                String department = null ;
                int m_cnt = 0, c_cnt = 0 ;
                ResultSet temp = st.executeQuery("select * from staff_r where uname='"+username+"'");
                if ( temp != null ) {
                    while ( temp.next() ) {
                        department = temp.getString("dept");
                        m_cnt = temp.getInt("m_cnt");
                        c_cnt = temp.getInt("c_cnt");
                    }
                }
                temp.close() ;

                ResultSet rs = st.executeQuery("select * from app_leave") ;
                if ( rs != null ) {
                    while ( rs.next() ) {
                        if ( sid == rs.getInt("sid") ) {
                            t = 1 ;
                        }
                    }
                }
                if ( cat.equals("Medical") ) {
                    if ( m_cnt == 0 ) {
                        t = 1 ;
                    }
                } else {
                    if ( c_cnt == 0 ) {
                        t = 1 ;
                    }
                }
                if ( t == 0 ) {
                    String sql2 = "insert into app_leave(sid,name,date_f,date_t,cat,reas,alt_s) values("+sid+",'"+name+"','"
                                +df+"','"+dt+"','"+cat+"','"+reason+"','"+alt_s+"')" ;
                    st.executeUpdate(sql2);
    %>
    <br>
    <div align="center" style="color: white; font-size: 22px;">
        Your Leave Request Has Been Submitted
        <br><br>
        <table>
            <tr>
                <td>
                    <a href="application_edit.jsp">
                        <img src="WebContent/static/images/edit_notes.png" style="width: 75px; height: 75px; background: transparent; border: none;">
                    </a>
                </td>
                <td style="padding-left: 100px;">
                    <a href="staff_page.jsp">
                        <img src="WebContent/static/images/home_page.jpg" style="width: 75px; height: 75px; background: transparent; border: none;">
                    </a>
                </td>
                <td style="padding-left: 100px;">
                    <a href="cancel_app.jsp">
                        <img src="WebContent/static/images/cancel.png" style="width: 75px; height: 75px; background: transparent; border: none;">
                    </a>
                </td>
            </tr>
        </table>
    </div>
    <%
                } else {
    %>
    <br>
    <div align="center" class="sry">
        Sorry You Already have Applied For Leave<br>
        Your Leave Is Not Yet Being Addressed<br>
        ( OR ) <br>
        Your Leaves Are Over..<br>
        Please Check<br>
        <br>
        <a href="staff_page.jsp">
            <button style="font-size: 18px;">Back</button>
        </a>
    </div>
    <%
                }
            } else {
                response.sendRedirect("index.html");
            }
        } catch ( Exception e ) {
            System.out.print("Exception Found");
            response.sendRedirect("index.html");
        }
    %>
</body>
</html>
