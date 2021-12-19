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
    
    if(sesion.getAttribute("tipo") == "Admin"){
        response.sendRedirect("home-administracion.jsp");
    }
    
    if(sesion.getAttribute("tipo") == "Alumno"){
        response.sendRedirect("home-alumnos.jsp");
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Menu</title>
    </head>
    <body>
        <a href="mis-alumnos.jsp">Ver mis alumnos</a><br>
        <a href="mensaje-a-administracion.jsp">Mensaje para la administración</a><br>
        <a href="apuntes-profes.jsp">Subir apuntes al repositorio</a><br>
        <a href="logout.jsp">Logout</a>
        <!-- Només ho poso com a comment el [G/J]-->
    </body>
</html>