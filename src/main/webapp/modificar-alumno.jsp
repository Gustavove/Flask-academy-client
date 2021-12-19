<%-- 
    Document   : modificar-alumno
    Created on : 18 dic. 2021, 2:18:58
    Author     : gustavo
--%>

<%@page import="org.json.JSONObject"%>
<%@page import="org.json.JSONArray"%>
<%@page import="java.lang.reflect.Type"%>
<%@page import="com.google.gson.reflect.TypeToken"%>
<%@page import="org.apache.http.HttpEntity"%>
<%@page import="org.apache.http.util.EntityUtils"%>
<%@page import="org.apache.http.client.methods.CloseableHttpResponse"%>
<%@page import="org.apache.http.client.methods.HttpGet"%>
<%@page import="org.apache.http.impl.client.HttpClients"%>
<%@page import="org.apache.http.impl.client.CloseableHttpClient"%>
<%@page import="com.google.gson.Gson"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.io.*"%>
<%@page import="javax.servlet.*"%>
<%@page import="java.sql.*"%>
<%@page import="java.util.*"%>
<%@page import="java.util.Date"%>
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
        <title>Modificar Imagen</title>
    </head>
    <body>
<%
            try {
                String result = "";
                //Conexión con el servicio mediante GET
                String url = "http://127.0.0.1:5000/admin/info_alumno?nombre=" + request.getParameter("nombre");
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

                if(!"[]".equals(result)){
                        JSONArray alumnos = new JSONArray(result);
                        JSONObject obj = alumnos.getJSONObject(0);
                        out.println("<h1>Modificar alumno: </h1>");                  
                        out.println("<form method=\"post\" action=\"modificar_alumno\">");
                        out.println("<div>Nombre</div>");
                        out.println("<input type=\"text\" name=\"nombre\" required='required' value="+obj.getString("Nombre")+">");
                        out.println("<div>Años</div>");
                        Integer age = obj.getInt("Age");
                        out.println("<input type=\"text\" name=\"age\" required='required' value="+ age.toString() +">");
                        out.println("<div>Pago hecho</div>");
                        Integer pago = obj.getInt("Pago_hecho");
                        out.println("<input type=\"text\" name=\"pago\" required='required' value="+ pago.toString() +">");
                        out.println("<div>Tutor legal</div>");
                        out.println("<input type=\"text\" name=\"tutor_legal\" required='required' value="+obj.getString("Tutor_legal")+">");
                        out.println("<div>Id grupo</div>");
                        Integer id_grupo = obj.getInt("Id_grupo");
                        out.println("<input type=\"text\" name=\"grupo\" required='required' value="+ id_grupo.toString() +">");

                        out.println("<br> <br> <input type =\"submit\" value=\"Modificar\">");

                } else {
                    out.println("<p> No hay alumno en el sistema</p>");
                }


            } catch (Exception e) {
            System.err.println(e.getMessage());
            response.sendRedirect("error.jsp");
        }
%>
    </body>
</html>