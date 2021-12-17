<%-- 
    Document   : login
    Created on : 28-sep-2021, 8:41:44
    Author     : alumne
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%-- Comprueba que el usuario no tiene una sessión activa --%>
<%
    HttpSession sesion = request.getSession();  
    if (sesion.getAttribute("user") != null ){
       response.sendRedirect("menu.jsp");
    }  
%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login Page</title>
    </head>
    <body>
        <h1>Login</h1>
        <form action="login" method="post">
            <table style="with: 50%">
                <tr>
                    <td>Username</td>
                    <td><input type="text" name="username" /></td>
		</tr>
		<tr>
                    <td>Password</td>
                    <td><input type="password" name="password" /></td>
		</tr>
            </table>
            <input type="submit" value="Login" /></form>
    </body>
</html>