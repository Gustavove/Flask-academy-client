<%-- 
    Document   : apuntes_profes
    Created on : 04-dic-2021, 14:10:49
    Author     : gustavo
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    HttpSession sesion = request.getSession();
    if (sesion.getAttribute("user") == null) {
        response.sendRedirect("login.jsp");
    }

    if ("Admin".equals(sesion.getAttribute("tipo"))) {
        response.sendRedirect("home-administracion.jsp");
    }

    if ("Alumno".equals(sesion.getAttribute("tipo"))) {
        response.sendRedirect("home-alumnos.jsp");
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <form method="post" action="subir_apuntes" enctype="multipart/form-data">
            
            <table style="width: 50%">
                <tr>
                    <td>Selecciona una asignatura:</td>
                    <td><select name="asignatura" id="asignatura">
                            <option value="matematicas">Matematicas</option>
                            <option value="ingles">Ingles</option>
                            <option value="catalan">Catalan</option>
                        </select></td>
                </tr>

                <tr>
                    <td>Introduce el nombre del archivo:</td>
                    <td><input type="text" name="nombre" /></td>
                </tr>
                <tr>
                    <td>Introduce su filename:</td>
                    <td><input type="text" name="filename" /></td>
                </tr>
                <tr>Archivo a subir:</td>
                    <td><input type="file" id="file" name="file" multiple></td>
                </tr>
            </table>
            <input type ="submit" value="Subir archivo">
        </form>
    </body>
</html>
