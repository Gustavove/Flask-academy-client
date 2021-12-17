<%-- 
    Document   : registrarAlumno
    Created on : 28-sep-2021, 8:42:39
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
        <title>Registrar Alumno</title>
    </head>
    <body>
        <form action="registrar_alumno" method="post">
            <table style="width: 50%">
                <tr>
                    <td>Nombre</td>
                    <td><input type="text" name="nombre" /></td>
		</tr>
		<tr>
                    <td>Edad</td>
                    <td><input type="text" name="edad" /></td>
		</tr>
		<tr>
                    <td>Pago</td>
                    <td><input type="text" name="pago" /></td>
		</tr>
		<tr>
                    <td>Tutor legal</td>
                    <td><input type="text" name="tutor_legal" /></td>
		</tr>
		<tr>
                    <td>Id grupo</td>
                    <td><input type="text" name="id_grupo" /></td>
		</tr>
            </table>
            <input type="submit" value="Registrar" />
        </form>
    </body>
</html>