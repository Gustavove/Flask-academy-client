<%-- 
    Document   : listar-profesores
    Created on : 17 dic. 2021, 21:18:13
    Author     : gustavo
--%>

<%@page import="org.json.JSONArray"%>
<%@page import="java.util.logging.Logger"%>
<%@page import="java.util.logging.Level"%>
<%@page import="org.apache.http.HttpEntity"%>
<%@page import="org.apache.http.client.methods.HttpGet"%>
<%@page import="org.apache.http.util.EntityUtils"%>
<%@page import="org.apache.http.client.methods.CloseableHttpResponse"%>
<%@page import="org.apache.http.impl.client.HttpClients"%>
<%@page import="org.apache.http.impl.client.CloseableHttpClient"%>
<%@page import="org.apache.http.message.BasicNameValuePair"%>
<%@page import="org.apache.http.NameValuePair"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.lang.reflect.Type"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="java.io.*"%>
<%@page import="org.json.JSONObject"%>
<%@page import="com.google.gson.JsonArray"%>
<%@page import="com.google.gson.JsonElement"%>
<%@page import="com.google.gson.JsonObject"%>
<%@page import="com.google.gson.JsonParser"%>
<%@page import="com.google.gson.reflect.TypeToken"%>
<%@page import="com.google.gson.Gson"%>
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
        <title>Listar Profesores</title>
    </head>
    <body>
	<h1>Listar Imagenes</h1>         
<%
            try {
                String result = "";
                
                //Conexión con el servicio mediante GET
                String url = "http://127.0.0.1:5000/admin/lista_profes";
                CloseableHttpClient httpClient = HttpClients.createDefault();
               
                try{
                    HttpGet req = new HttpGet(url);
                    CloseableHttpResponse res = httpClient.execute(req); 
                    try{
                      //Se obtiene la respuesta 
                      HttpEntity entity = res.getEntity(); 
                      result = EntityUtils.toString(entity);
                        
                    } catch (Exception e){
                        System.err.println(e.getMessage());
                        response.sendRedirect("error.jsp");
                    }
                    finally {
                        res.close();
                    }
                } catch (Exception e){
                    System.err.println(e.getMessage());
                    response.sendRedirect("error.jsp");
                }
                finally {
                    httpClient.close();
                }
             
                
                out.println("<table style=\"width:60%\">");
                if(!"[]".equals(result)){
                    JSONArray profes = new JSONArray(result);
                    for(int i = 0; i<profes.length(); i++){
                        JSONObject object = profes.getJSONObject(i);
                        String nombre = object.getString("Profesor");
                        Integer puntuacion = object.getInt("Puntuacion");
                        
                        out.println("<tr> <td> Profesor </td>  <td>" + nombre + "</td> </tr>");
                        out.println("<tr> <td> Puntuación </td> <td>" + puntuacion.toString()+ "</td> </tr>");
                        out.println("<td> <a href='./mensajes?profesor=" + nombre + "'>Ver mensajes</a> </td>");

                    }
                } else {
                    out.println("<p> No hay profesores en el sistema</p>");
                }
                out.println("</table>");
            } catch (Exception e) {
                System.err.println(e.getMessage());
                response.sendRedirect("error.jsp");
            }
            
           
        %>
        <br> <a href='home-administracion.jsp'>Volver al menú</a>
    </body>
</html>
