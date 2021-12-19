<%-- 
    Document   : puntuacion_profesbyalumnos
    Created on : 04-dic-2021, 14:11:27
    Author     : gustavo
--%>

<%@page import="org.json.JSONObject"%>
<%@page import="org.json.JSONArray"%>
<%@page import="org.apache.http.util.EntityUtils"%>
<%@page import="org.apache.http.HttpEntity"%>
<%@page import="org.apache.http.client.methods.CloseableHttpResponse"%>
<%@page import="org.apache.http.client.methods.HttpGet"%>
<%@page import="org.apache.http.impl.client.HttpClients"%>
<%@page import="org.apache.http.impl.client.CloseableHttpClient"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    HttpSession sesion = request.getSession();
    if (sesion.getAttribute("user") == null) {
        response.sendRedirect("login.jsp");
    }

    if ("Admin".equals(sesion.getAttribute("tipo"))) {
        response.sendRedirect("home-administracion.jsp");
    }

    if ("Profesor".equals(sesion.getAttribute("tipo"))) {
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
        <h1>Puntuar a mis profesores</h1>         
        <%
            try {
                String result = "";

                //Conexión con el servicio mediante GET
                String url = "http://127.0.0.1:5000/alumnos/mis_profes?nombre_alumno=" + sesion.getAttribute("user");
                CloseableHttpClient httpClient = HttpClients.createDefault();

                try {
                    HttpGet req = new HttpGet(url);
                    CloseableHttpResponse res = httpClient.execute(req);
                    try {
                        //Se obtiene la respuesta 
                        HttpEntity entity = res.getEntity();
                        result = EntityUtils.toString(entity);

                    } catch (Exception e) {
                        System.err.println(e.getMessage());
                        response.sendRedirect("error.jsp");
                    } finally {
                        res.close();
                    }
                } catch (Exception e) {
                    System.err.println(e.getMessage());
                    response.sendRedirect("error.jsp");
                } finally {
                    httpClient.close();
                }
                out.println("<table style=\"width:60%\">");
                if (!"[]".equals(result)) {
                    JSONArray profes = new JSONArray(result);
                    for (int i = 0; i < profes.length(); i++) {
                        JSONObject object = profes.getJSONObject(i);
                        String profe = object.getString("Profesor");
                        out.println("<form action='puntuar_profesor' method='get'>");
                        out.println("<table style='with: 50%'>");
                        out.println("<tr>");
                        out.println("<td>" + profe + "</td>");
                        out.println("<td><input type='text' name='puntuacion' placeholder='Puntua tu profesor entre 0-10'/></td>");
                        out.println("</tr>");
                        out.println("</table>");
                        out.println("<br>");
                        out.println("<input type='hidden' name='profe' value='" + profe + "' />");
                        out.println("<input type='submit' value='Puntuar' />");
                        out.println("</form><br>"); 
                    }

                }
            } catch (Exception e) {
                System.err.println(e.getMessage());
                response.sendRedirect("error.jsp");
            }


        %>
        <br> <a href='home-alumnos.jsp'>Volver al menú</a>
    </body>
</html>
