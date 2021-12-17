/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package servlets;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author gustavo
 */
@WebServlet(name = "login", urlPatterns = {"/login"})
public class login extends HttpServlet {

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
             
            if (sesion.getAttribute("user") != null ){
                response.sendRedirect("menu.jsp");
            } else{
            
                String name_user = request.getParameter("username");
                String password = request.getParameter("password");

                /*Conexión con el servicio */ 
                
                try{
                    HttpGet req = new HttpGet(url);
                    CloseableHttpResponse res = httpClient.execute(req); 
                    try{
                      //Se obtiene la respuesta 
                      HttpEntity entity = res.getEntity(); 
                      result = EntityUtils.toString(entity);
                      if(result.equals("[\"error\"]")) response.sendRedirect("error.jsp");
                      else{
                          //Si no hay error se obtiene el array de Imagenes, si es nulo imagenes = null
                          Type listType = new TypeToken<ArrayList<Image>>(){}.getType();
                          imagenes = new Gson().fromJson(result, listType);
                      }  
                        
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

                JSONObject obj;
                boolean IsSuccessful;
                try (CloseableHttpClient httpClient = HttpClients.createDefault();
                        CloseableHttpResponse resp = httpClient.execute(post)) {
                    result = EntityUtils.toString(resp.getEntity());
                    obj = new JSONObject(result);
                    IsSuccessful = obj.getBoolean("IsSuccessful");
                    resp.close();
                    httpClient.close();
                } catch (Exception e) {
                    Logger.getLogger(registrarImagen.class.getName()).log(Level.SEVERE, null, e);
                    IsSuccessful = false;
                }
                
                
                
                
                
                
                
                if (usuarioDB.consultaUsuarioyPassword()) {
                    sesion.setAttribute("user", name_user);
                    response.sendRedirect("menu.jsp");
                }
                else{
                    response.sendRedirect("error.jsp");
                }

                base_dades.fiConexio();
            
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
