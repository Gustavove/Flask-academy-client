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
    
    if("Alumno".equals(sesion.getAttribute("tipo"))){
        response.sendRedirect("home-alumnos.jsp");
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
        <a href="registrar-profesor.jsp">Registrar profesor</a><br>
        <a href="registrar-alumno.jsp">Registrar alumno</a><br>
        <a href="listar-profesores.jsp">Listar profesores</a><br>
        <a href="listar-alumnos.jsp">Listar alumnos</a><br><br>
        
        <a href="logout.jsp">Logout</a>
        <!-- Només ho poso com a comment el [G/J]-->
    </body>
</html>