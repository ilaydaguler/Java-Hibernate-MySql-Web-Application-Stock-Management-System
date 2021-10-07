package servlets;

import org.hibernate.Hibernate;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import utils.DBUtil;
import utils.HibernateUtil;
import utils.Util;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;


@WebServlet(name = "loginServlet", value = {"/login-servlet" , "/logout-servlet"})
public class LoginServlet extends HttpServlet {

    SessionFactory sf = HibernateUtil.getSessionFactory();

    //LOG IN
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Session sesi = sf.openSession();
        String email = req.getParameter("email");
        String password = req.getParameter("password");
        String remember = req.getParameter("remember");
        System.out.println("email = " + email + " password = " + password + " remember = " + remember);

        DBUtil util = new DBUtil();
        int status = util.login(email, password, remember, req, resp);
        System.out.println("status = " + status);
        if ( status != 0) {
            resp.sendRedirect( Util.base_url + "dashboard.jsp" );
        } else {
            req.setAttribute("loginError", "Mail veya Şifre Hatalı!");
            RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/index.jsp");
            dispatcher.forward(req, resp);
        }
        sesi.close();
    }
    //LOG OUT
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getSession().removeAttribute("uid");
        req.getSession().removeAttribute("name");
        req.getSession().invalidate();
        Cookie cookie = new Cookie("admin", "");
        cookie.setMaxAge(0);
        resp.addCookie(cookie);
        resp.sendRedirect(Util.base_url + "index.jsp");
    }
}