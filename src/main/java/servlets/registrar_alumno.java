/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
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
import javax.servlet.annotation.WebServlet;
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
 * @author gustavo
 */
@WebServlet(name = "registrar_alumno", urlPatterns = {"/registrar_alumno"})
@MultipartConfig
public class registrar_alumno extends HttpServlet {

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

            if (!request.getParameter("nombre").isEmpty() && !request.getParameter("edad").isEmpty() 
                    && !request.getParameter("pago").isEmpty() && !request.getParameter("tutor_legal").isEmpty()
                    && !request.getParameter("id_grupo").isEmpty()) {
                
                //Obtener datos formulario
                String nombre = request.getParameter("nombre");
                String edad = request.getParameter("edad");
                String pago = request.getParameter("pago");
                String tutor_legal = request.getParameter("tutor_legal");
                String id_grupo = request.getParameter("id_grupo");
                
                // Subida del archivo                
                byte[] data = null;
                
                try (InputStream is = request.getPart("foto").getInputStream()) {
                    int i = is.available();
                    data = new byte[i];
                    is.read(data);
                } catch (Exception e){
                    System.err.println(e.getMessage());
                }
                
                
                //Convertir a String 
                String file = Base64.getEncoder().encodeToString(data);
                
                //Conexión con el servicio
                String result;
                String url = "http://127.0.0.1:5000/admin/new_alumno";
                HttpPost post = new HttpPost(url);

                // Añadimos parametros a la petición HTTP
                List<NameValuePair> urlParameters = new ArrayList<>();
                urlParameters.add(new BasicNameValuePair("nombre", nombre));
                urlParameters.add(new BasicNameValuePair("edad", edad));
                urlParameters.add(new BasicNameValuePair("pago_hecho", pago));
                urlParameters.add(new BasicNameValuePair("tutor_legal", tutor_legal));
                urlParameters.add(new BasicNameValuePair("id_grupo", id_grupo));
                urlParameters.add(new BasicNameValuePair("foto", file));

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
                    out.println("<title>Alumno registrado correctamente</title>");
                    out.println("</head>");
                    out.println("<body>");
                    out.println("<h1> Alumno registrado correctamente </h1>");
                    out.println(" <a href=\"registrar_alumno.jsp\">Volver a registrar otro alumno</a><br>");
                    out.println(" <a href=\"home-administracion.jsp\">Volver al menú </a><br>");
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
        try {
            processRequest(request, response);
        } catch (IOException | ServletException ex) {
            Logger.getLogger(registrar_alumno.class.getName()).log(Level.SEVERE, null, ex);
        }
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
        try {
            processRequest(request, response);
        } catch (IOException | ServletException ex) {
            Logger.getLogger(registrar_alumno.class.getName()).log(Level.SEVERE, null, ex);
        }
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
