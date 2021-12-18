<%-- 
    Document   : apuntes_alumnos
    Created on : 04-dic-2021, 14:10:34
    Author     : gustavo
--%>

<%@page import="org.apache.http.util.EntityUtils"%>
<%@page import="org.json.JSONObject"%>
<%@page import="org.json.JSONArray"%>
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
        <h1>Repositorio de apuntes</h1>         
        <%
            try {
                String result = "";

                //Conexión con el servicio mediante GET
                String url = "http://127.0.0.1:5000/alumnos/mis_asignaturas?nombre_alumno=" + "Paula";
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
                if (!"[]".equals(result)) {
                    JSONArray asigs = new JSONArray(result);
                    for (int i = 0; i < asigs.length(); i++) {
                        String result2 = "";
                        JSONObject object = asigs.getJSONObject(i);
                        String asignatura = object.getString("Asignatura");
                        String url2 = "http://127.0.0.1:5000/alumnos/ficheros_de_asignatura?asignatura=" + asignatura;
                        CloseableHttpClient httpClient2 = HttpClients.createDefault();

                        try {
                            HttpGet req = new HttpGet(url2);
                            CloseableHttpResponse res = httpClient2.execute(req);
                            try {
                                //Se obtiene la respuesta 
                                HttpEntity entity = res.getEntity();
                                result2 = EntityUtils.toString(entity);

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
                        if (!"[]".equals(result2)) {
                            JSONArray archivos = new JSONArray(result2);
                            for (int j = 0; j < archivos.length(); j++) {
                                JSONObject object2 = archivos.getJSONObject(j);
                                String nombre = object2.getString("Nombre_fichero");
                                out.println("<tr> <td> Alumno </td>  <td>" + nombre + "</td>   <td><a href='./modificar-alumno.jsp?nombre=" + nombre + "'>Modificar información</a> </td></tr>");
                            }
                        } else {
                            out.println("<p> No hay profesores en el sistema</p>");
                        }
                    }

                    out.println("</table>");
                }
                }catch (Exception e) {
                System.err.println(e.getMessage());
                response.sendRedirect("error.jsp");
            }


        %>
        <br> <a href='home-alumnos.jsp'>Volver al menú</a>
    </body>
</html>
