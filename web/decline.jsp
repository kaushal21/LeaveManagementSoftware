<%@page import="java.sql.Statement"%>
<%@page import="java.sql.*"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Application Declined</title>
</head>
<body>
    <%
        try {
            session = request.getSession();
            String sessn = null;
            if ( session != null ) {
               sessn = session.getAttribute("username").toString();
            }
            if ( sessn != null ) {
                String name = request.getParameter("name");
                int sid = 0 ;
                String cat = null, rea = null, alt_s = null ;
                Date dt = null, df = null ;
                Class.forName("com.mysql.jdbc.Driver");
                Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/leave_management",
                    "root","kaushal08");
                Statement st = con.createStatement();
                ResultSet rs =  st.executeQuery("select * from app_leave where name='"+name+"'");
                if ( rs != null ) {
                    while ( rs.next() ) {
                        sid = rs.getInt("sid");
                        dt = rs.getDate("date_t");
                        df = rs.getDate("date_f");
                        cat = rs.getString("cat");
                        rea = rs.getString("reas");
                        alt_s = rs.getString("alt_s");
                    }
                }
                String sql1 = "delete from app_leave where name='"+name+"'" ;
                String sql2 = "insert into past_h(sid,name,date_f,date_t,cat,reas,alt_s,status) values("+sid+",'"+name+"','"
                        +df+"','"+dt+"','"+cat+"','"+rea+"','"+alt_s+"','Declined')" ;
                st.executeUpdate(sql1);
                st.executeUpdate(sql2);
                response.sendRedirect("hod_page.jsp");
            } else{
                response.sendRedirect("index.html");
            }
        } catch ( Exception e ) {
            out.print("Exception Found");
            response.sendRedirect("index.html");
        }
    %>
</body>
</html>
