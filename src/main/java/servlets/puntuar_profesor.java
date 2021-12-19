/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlets;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.apache.http.HttpEntity;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.util.EntityUtils;

/**
 *
 * @author alumne
 */
public class puntuar_profesor extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
            HttpSession sesion = request.getSession();  
            if (sesion.getAttribute("user") == null){
               response.sendRedirect("login.jsp");
            }

            if("Admin".equals(sesion.getAttribute("tipo"))){
                response.sendRedirect("home-administracion.jsp");
            }

            if("Profesor".equals(sesion.getAttribute("tipo"))){
                response.sendRedirect("home-profes.jsp");
            }
        try (PrintWriter out = response.getWriter()) {
            String result = "";
            if (!request.getParameter("puntuacion").isEmpty()){
                //Conexión con el servicio mediante GET
                String url = "http://127.0.0.1:5000/alumnos/puntuar_profesor?profesor=" + request.getParameter("profe") +"&puntuacion=" + request.getParameter("puntuacion");
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

                if ("Success!".equals(result)) {
                    out.println("<!DOCTYPE html>");
                    out.println("<html>");
                    out.println("<head>");
                    out.println("<title>Profesor puntuado correctamente</title>");
                    out.println("</head>");
                    out.println("<body>");
                    out.println("<h1> Profesor puntuado correctamente </h1>");
                    out.println(" <a href=\"puntuacion-profes-by-alumnos.jsp\">Volver a puntuar otro profesor</a><br>");
                    out.println(" <a href=\"home-alumnos.jsp\">Volver al menú </a><br>");
                    out.println("</body>");
                    out.println("</html>");
                } else {
                    response.sendRedirect("error.jsp");
                }
            }
        } catch (Exception e) {
            System.err.println(e.getMessage());
            response.sendRedirect("error.jsp");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
