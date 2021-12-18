/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package servlets;

import java.io.IOException;
import java.io.PrintWriter;
import static java.lang.System.out;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.http.HttpEntity;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.util.EntityUtils;
import org.json.JSONObject;

/**
 *
 * @author gustavo
 */
@WebServlet(name = "foto_tutor", urlPatterns = {"/foto_tutor"})
public class foto_tutor extends HttpServlet {

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
        try (PrintWriter out = response.getWriter()) {
            String result;
            String file = "";
            //Conexión con el servicio mediante GET
            String url = "http://127.0.0.1:5000/admin/descargar_imagen_tutor?nombre=" + request.getParameter("nombre");
            try (CloseableHttpClient httpClient = HttpClients.createDefault()) {
                HttpGet req = new HttpGet(url);
                try (CloseableHttpResponse res = httpClient.execute(req)) {
                    //Se obtiene la respuesta 
                    HttpEntity entity = res.getEntity();
                    result = EntityUtils.toString(entity);
                    if (result.equals("Error")) {
                        response.sendRedirect("error.jsp");
                    }
                } catch (Exception e) {
                    System.err.println(e.getMessage());
                    response.sendRedirect("error.jsp");
                }
            } catch (Exception e) {
                System.err.println(e.getMessage());
                response.sendRedirect("error.jsp");
            }
            
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Imagen tutor</title>");
            out.println("</head>");
            out.println("<body>");

            out.println("<h1>Foto del tutor: </h1>");
            out.println("<img id=\"base64ImageForDisplay\" alt=\"No se puede ver la imagen\" src=\"data:image/png;base64," + file +" style=\"display: block;\">");
            out.println("<br>");
            out.println("<a href='./home-administracion.jsp'> Volver al menu principal</a>");
            out.println("</body>");
            out.println("</html>");
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
