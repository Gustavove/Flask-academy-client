<%-- 
    Document   : menu
    Created on : 28-sep-2021, 8:42:17
    Author     : alumne
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%-- Comprueba que el usuario tiene una sessión activa --%>
<%
    HttpSession sesion = request.getSession();  
    if (sesion.getAttribute("user") == null){
       response.sendRedirect("login.jsp");
    }
    
    if("Admin".equals(sesion.getAttribute("tipo"))){
        response.sendRedirect("home-administracion.jsp");
    }
    
    if("Profesor".equals(sesion.getAttribute("tipo"))){
        response.sendRedirect("home-profes.jsp");
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Menu</title>
    </head>
    <body>
        <a href="apuntes-alumnos.jsp">Consultar mis apuntes</a><br>
        <a href="puntuacion-profes-by-alumnos.jsp">Puntuar mis profesores</a><br>
        
        <a href="logout.jsp">Logout</a>
        <!-- Només ho poso com a comment el [G/J]-->
    </body>
</html>