<%-- 
    Document   : mis-alumnos
    Created on : 18 dic. 2021, 3:32:50
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
    
    if(sesion.getAttribute("tipo") == "Admin"){
        response.sendRedirect("home-administracion.jsp");
    }
    
    if(sesion.getAttribute("tipo") == "Alumno"){
        response.sendRedirect("home-alumnos.jsp");
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Listar Alumnos</title>
    </head>
    <body>
	<h1>Listar Alumnos</h1>         
<%
            try {
                String result = "";
                
                //Conexión con el servicio mediante GET
                String url = "http://127.0.0.1:5000//profesores/mis_alumnos?nombre=" + sesion.getAttribute("user");
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
                    JSONArray alumnos = new JSONArray(result);
                    for(int i = 0; i<alumnos.length(); i++){
                        JSONObject object = alumnos.getJSONObject(i);
                        String nombre = object.getString("Nombre");
                        Integer age = object.getInt("Age");
                        String tutor = object.getString("Tutor_legal");
                        
                        out.println("<tr> <td> Alumno </td>  <td>" + nombre + "</td> </tr>");
                        out.println("<tr> <td> Años </td>  <td>" + age + "</td> </tr>");
                        out.println("<tr> <td> Tutor </td>  <td>" + tutor + "</td> </tr>");
                        out.println("<br>");
                    }
                    out.println("</table> <br>");    
                } else {
                    out.println("<p> No tienes alumnos en el sistema</p>");
                }
            } catch (Exception e) {
                System.err.println(e.getMessage());
                response.sendRedirect("error.jsp");
            }
            
           
        %>
        <br> <a href='home-profes.jsp'>Volver al menú</a>
    </body>
</html>
