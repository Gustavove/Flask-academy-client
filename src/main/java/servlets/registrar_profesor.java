package servlets;

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
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
 * @author gustavo
 */
@WebServlet(urlPatterns = {"/registrar_profesor"})
public class registrar_profesor extends HttpServlet {

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
            if (sesion.getAttribute("user") == null){
               response.sendRedirect("login.jsp");
            }

            if("Alumno".equals(sesion.getAttribute("tipo"))){
                response.sendRedirect("home-alumnos.jsp");
            }

            if("Profesor".equals(sesion.getAttribute("tipo"))){
                response.sendRedirect("home-profes.jsp");
            }

            
            if (sesion.getAttribute("user") == null) {
                response.sendRedirect("login.jsp");
            }

            if (!request.getParameter("nombre").isEmpty()) {
                
                //Obtener datos formulario
                String nombre = request.getParameter("nombre");
                
                //Conexi??n con el servicio
                String result;
                String url = "http://127.0.0.1:5000/admin/new_profesor";
                HttpPost post = new HttpPost(url);

                // A??adimos parametros a la petici??n HTTP
                List<NameValuePair> urlParameters = new ArrayList<>();
                urlParameters.add(new BasicNameValuePair("nombre", nombre));
                urlParameters.add(new BasicNameValuePair("puntuacion", "0.0"));

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
                    out.println("<title>Profesor registrado correctamente</title>");
                    out.println("</head>");
                    out.println("<body>");
                    out.println("<h1> Profesor registrado correctamente </h1>");
                    out.println(" <a href=\"registrar-profesor.jsp\">Volver a registrar otro profesor</a><br>");
                    out.println(" <a href=\"home-administracion.jsp\">Volver al men?? </a><br>");
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
