<%-- 
    Document   : error
    Created on : 17 dic. 2021, 14:39:14
    Author     : gustavo
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Error</title>
    </head>
    <body>
        <%  HttpSession sesion = request.getSession();
            if (sesion.getAttribute("user") == null) {
                out.println("<h1> Usuario o contraseña no validos</h1> <br> <br>");
                out.println("<a href=" + "login.jsp" + "> Volver al login </a><br>");
            } else {
                out.println("<h1> Error </h1> <br> <br>");
                if ("Alumno".equals(sesion.getAttribute("tipo"))) {
                    out.println("<a href=" + "home-alumnos.jsp" + "> Volver al menu </a><br>");
                }

                if ("Profesor".equals(sesion.getAttribute("tipo"))) {
                    out.println("<a href=" + "home-profes.jsp" + "> Volver al menu </a><br>");
                }
                
                if ("Admin".equals(sesion.getAttribute("tipo"))) {
                    out.println("<a href=" + "home-administracion.jsp" + "> Volver al menu </a><br>");
                }
            }

        %>
    </body>
</html>
