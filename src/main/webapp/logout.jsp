<%-- 
    Document   : logout
    Created on : 13-oct-2021, 16:29:46
    Author     : alumne
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%-- Comprueba que el usuario tiene una sessión activa --%>
<%
    HttpSession sesion = request.getSession();  
    if (sesion.getAttribute("user") == null ){
       response.sendRedirect("login.jsp");
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Logout</title>
    </head>
    <body>
        <%  String user = (String)request.getSession().getAttribute("user");
            if (user != null ){
                sesion.invalidate();
                out.println("Usuario <b>" + user + "</b> logged out<br> <br>");
                out.println("<a href=" + "login.jsp" +"> Volver al login </a><br>");
            }
        %>
    </body>
</html>