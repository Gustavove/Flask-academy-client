<%-- 
    Document   : descargar_archivo
    Created on : 18-dic-2021, 19:31:55
    Author     : alumne
--%>

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
        <%
            try {
                String result = "";

                //Conexión con el servicio mediante GET
                String directorio = request.getParameter("asignatura");
                String archivo = request.getParameter("nombre");
                String url = "http://127.0.0.1:5000/alumnos/apuntes/" + directorio + '/' + archivo;
                out.println("<h1>"+ url +"</h1>");
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
                if ("Error".equals(result)) {
                    out.println("<h1> Ha habido algun problema. Intentalo de nuevo </h1>");
                } else{
                    out.println("<h1> Imagen descargada </h1>");
                }
            } catch (Exception e) {
                System.err.println(e.getMessage());
                response.sendRedirect("error.jsp");
            }


        %>
        <br> <a href='home-alumnos.jsp'>Volver al menú</a>
    </body>
</html>