<%-- 
    Document   : mensajeadministracion
    Created on : 04-dic-2021, 14:13:37
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
    
    if("Admin".equals(sesion.getAttribute("tipo"))){
        response.sendRedirect("home-profes.jsp");
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <form action="mensaje_admin" method="post">
            <table style="width: 50%">
                <tr>
                    <td>Escribe un comentario:</td>
                </tr>
                <tr>
                    <td><textarea name="comentario" rows="10" cols="50" placeholder="Inserta tu mensaje aqui..."></textarea></td>
		</tr>
            </table>
            <input type="submit" value="Enviar mensaje" />
        </form>
        
    </body>
</html>
