<%-- 
    Document   : registrar-profesor
    Created on : 17 dic. 2021, 20:21:26
    Author     : gustavo
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
        <title>Registrar Alumno</title>
    </head>
    <body>
        <form action="registrar_profesor" method="post">
            <table style="width: 50%">
                <tr>
                    <td>Nombre</td>
                    <td><input type="text" name="nombre" /></td>
		</tr>
            </table>
            <input type="submit" value="Registrar" />
        </form>
    </body>
</html>