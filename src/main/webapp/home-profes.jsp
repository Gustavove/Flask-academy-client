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
        <a href="ver-info-alumno.jsp">Consultar información de alumnos</a><br>
        <a href="ver-info-profes.jsp">Ver información de todos los profes</a><br>
        <a href="registrar-alumno.jsp">Registrar alumno</a><br>
        <a href="consulta-profe.jsp">Ver información de un profesor</a><br><br>
        
        <a href="logout.jsp">Logout</a>
        <!-- Només ho poso com a comment el [G/J]-->
    </body>
</html>