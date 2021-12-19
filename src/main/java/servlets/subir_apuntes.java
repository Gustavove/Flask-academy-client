/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlets;

import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Base64;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;
import org.apache.http.NameValuePair;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.util.EntityUtils;

/**
 *
 * @author alumne
 */
@MultipartConfig
public class subir_apuntes extends HttpServlet {

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
            HttpSession sesion = request.getSession();
            if (sesion.getAttribute("user") == null) {
                response.sendRedirect("login.jsp");
            }

            if ("Alumno".equals(sesion.getAttribute("tipo"))) {
                response.sendRedirect("home-alumnos.jsp");
            }

            if ("Admin".equals(sesion.getAttribute("tipo"))) {
                response.sendRedirect("home-administracion.jsp");
            }

            if (!request.getParameter("asignatura").isEmpty() && !request.getParameter("nombre").isEmpty()
                    && !request.getParameter("filename").isEmpty()) {

                //Obtener datos formulario
                String asig = request.getParameter("asignatura");
                String nombre = request.getParameter("nombre");
                String filename = request.getParameter("filename");

                // Subida del archivo                
                byte[] data = null;

                try (InputStream is = request.getPart("file").getInputStream()) {
                    int i = is.available();
                    data = new byte[i];
                    is.read(data);
                } catch (Exception e) {
                    System.err.println(e.getMessage());
                }

                //Convertir a String 
                String file = Base64.getEncoder().encodeToString(data);

                //Conexión con el servicio
                String result;
                String url = "http://127.0.0.1:5000/profesores/subir_archivo";
                HttpPost post = new HttpPost(url);

                // Añadimos parametros a la petición HTTP
                List<NameValuePair> urlParameters = new ArrayList<>();
                urlParameters.add(new BasicNameValuePair("asignatura", asig));
                urlParameters.add(new BasicNameValuePair("nombre", nombre));
                urlParameters.add(new BasicNameValuePair("filename", filename));
                urlParameters.add(new BasicNameValuePair("fichero", file));

                post.setEntity(new UrlEncodedFormEntity(urlParameters));

                try (CloseableHttpClient httpClient = HttpClients.createDefault();
                        CloseableHttpResponse resp = httpClient.execute(post)) {
                    result = EntityUtils.toString(resp.getEntity());

                    resp.close();
                    httpClient.close();
                } catch (Exception e) {
                    Logger.getLogger(registrar_alumno.class.getName()).log(Level.SEVERE, null, e);
                    result = "error";
                }

                if ("Success!".equals(result)) {
                    out.println("<!DOCTYPE html>");
                    out.println("<html>");
                    out.println("<head>");
                    out.println("<title>Fichero registrado correctamente</title>");
                    out.println("</head>");
                    out.println("<body>");
                    out.println("<h1> Fichero registrado correctamente </h1>");
                    out.println(" <a href=\"apuntes-profes.jsp\">Volver a registrar otro fichero</a><br>");
                    out.println(" <a href=\"home-profes.jsp\">Volver al menú </a><br>");
                    out.println("</body>");
                    out.println("</html>");
                } else {
                    response.sendRedirect("error.jsp");
                }

            } else {
                response.sendRedirect("error.jsp");
            }
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
