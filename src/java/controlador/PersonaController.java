/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controlador;

import conexion.DbConnection;
import dao.PersonaDao;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import modelo.Persona;
import utilidad.Cifrar;

/**
 *
 * @author Carlos
 */
public class PersonaController extends HttpServlet {

    PersonaDao personaDao = new PersonaDao();
    DbConnection conn = new DbConnection();

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
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet PersonaController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet PersonaController at " + request.getContextPath() + "</h1>");
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
        RequestDispatcher rd = null;

        String user = request.getParameter("user");
        String codigo = request.getParameter("codigo");
        String nombre = request.getParameter("nombres");
        String apellido = request.getParameter("apellidos");
        String sueldo = request.getParameter("sueldo");

        String action = request.getParameter("action");
        if (action.equals("entrar")) {

            entradaSistema(request, response, user, rd);

        } else if (action.equals("eliminar")) {

            eliminarPersona(request, response, rd);
        } else if (action.equals("actualizar")) {

            actualizarPersona(request, response, rd,
                    codigo, nombre, apellido,
                    Double.valueOf(sueldo));
        } else if (action.equals("lista")) {
            listaPersona(request, response, rd);
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
        //processRequest(request, response);

    }

    public void entradaSistema(HttpServletRequest request, HttpServletResponse response,
            String user, RequestDispatcher rd) throws ServletException, IOException {
        personaDao.setConn(conn);
        List<Persona> lista = personaDao.personaList();

        request.setAttribute("user", user);
        request.setAttribute("size", user.length());
        request.setAttribute("lista", lista);
        request.setAttribute("tam", lista.size());
        rd = request.getRequestDispatcher("../admin/index.jsp");
        rd.forward(request, response);
    }

    public void eliminarPersona(HttpServletRequest request, HttpServletResponse response,
            RequestDispatcher rd) throws ServletException, IOException {
        String url="";
        try {
            List<Persona> lista;
            String cod = request.getParameter("cod").replace(" ", "+").trim();
            System.out.println("size "+cod.length());
            personaDao.setConn(conn);
            personaDao.eliminarPersona(descifrar(cod));
            lista = personaDao.personaList();
            if(cod.charAt(cod.length()-1)!='='){
                response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Estas inyectando</h1>");
            out.println("</body>");
            out.println("</html>");
            url="./inyectando.jsp";
        }
            }
            else{
            request.setAttribute("lista", lista);
            //     request.setAttribute("user", user);
             url="../admin/persona?action=lista";
            }

        } catch (Exception ex) {
            Logger.getLogger(PersonaController.class.getName()).log(Level.SEVERE, null, ex);
        }
        response.sendRedirect(url);
    }

    public String descifrar(String codCifrado) throws Exception {
        String key = "AAAE31A79FFFBFFF"; //llave
        String iv = "0000456789AAADEF"; // vector de inicialización
        return Cifrar.decrypt(key, iv, codCifrado);
    }

    public void actualizarPersona(HttpServletRequest request, HttpServletResponse response,
            RequestDispatcher rd, String codigo, String nombre,
            String apellido, double sueldo) throws ServletException, IOException {
        List<Persona> lista;
        personaDao.setConn(conn);
        personaDao.actualizarPersona(codigo, nombre,
                apellido, sueldo);
        lista = personaDao.personaList();
        response.sendRedirect("../admin/persona?action=lista");
    }

    public void listaPersona(HttpServletRequest request, HttpServletResponse response,
            RequestDispatcher rd) throws ServletException, IOException {
        HttpSession session = request.getSession();
        /*
        if (session.getAttribute("user")==null) {
            request.setAttribute("mensaje", "No tiene Privilegios para entrar");
            rd = request.getRequestDispatcher("/index.jsp");
            rd.forward(request, response);
        } else {
           */  
            List<Persona> lista;
            personaDao.setConn(conn);
            lista = personaDao.personaList();
            request.setAttribute("lista", lista);
            request.setAttribute("tam", lista.size());
            rd = request.getRequestDispatcher("../admin/index.jsp");
            rd.forward(request, response);
        //}
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
