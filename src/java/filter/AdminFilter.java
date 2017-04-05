/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package filter;


import java.io.IOException;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Carlos
 */
public class AdminFilter implements Filter {

    private FilterConfig configuration;

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        this.configuration = filterConfig;
         
          
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
        System.out.println("request "+request.getAttribute("user"));
        String ipAddress = request.getRemoteAddr();
        System.out.println("ip "+ipAddress);
        if (((HttpServletRequest) request).getSession().getAttribute("user") == null || !(((HttpServletRequest) request).getSession().getAttribute("rol")).equals("admin") ) {
            ((HttpServletResponse) response).sendRedirect("../denegado.jsp");
         System.out.println("denegado");
        } else {
            chain.doFilter(request, response);
            System.out.println("chain.doFilter");
        }

    }

    @Override
    public void destroy() {
        configuration = null;
    }
}

