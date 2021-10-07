package servlets;

import com.google.gson.Gson;
import entities.Box;
import entities.BoxCustomerProduct;
import entities.Customer;
import entities.Product;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import utils.HibernateUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "boxServlet", value = {"/box-post","/box-get","/box-delete"})
public class BoxServlet extends HttpServlet {
    SessionFactory sf = HibernateUtil.getSessionFactory();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int bid = 0;
        Session sesi = sf.openSession();
        Transaction tr = sesi.beginTransaction();
        try {
            String obj = req.getParameter("obj");
            Gson gson = new Gson();
            Box box = gson.fromJson(obj,Box.class);
            sesi.saveOrUpdate(box);
            tr.commit();
            sesi.close();
            bid = 1;
        }catch ( Exception ex) {
            System.err.println("Save OR Update Error : " + ex);
        }finally {
            sesi.close();
        }

        resp.setContentType("application/json");
        resp.getWriter().write( "" +bid );

    }


    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int cid = Integer.parseInt(req.getParameter("cid"));
        Gson gson = new Gson();
        Session sesi = sf.openSession();
        List<BoxCustomerProduct> ls = sesi.createNativeQuery("SELECT * FROM box\n" +
                        "INNER JOIN customer as cu\n" +
                        "on box.b_customer_id=cu.cu_id\n" +
                        "INNER JOIN product as pro\n" +
                        "on pro.p_id=box.b_product_id\n" +
                        "WHERE box.b_customer_id= ?1")
                .setParameter(1,cid)
                .addEntity(BoxCustomerProduct.class)
                .getResultList();
        sesi.close();

        String stJson =gson.toJson(ls);
        resp.setContentType("application/json");
        resp.getWriter().write( stJson );

    }

    @Override
    protected void doDelete(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        int return_id = 0;
        Session sesi = sf.openSession();
        Transaction tr = sesi.beginTransaction();
        try {
            int b_id = Integer.parseInt( req.getParameter("b_id") );
            Box box = sesi.load(Box.class, b_id);
            sesi.delete(box);
            tr.commit();
            return_id = box.getB_id();
        }catch (Exception ex) {
            System.err.println("Delete Error : " + ex);
        }finally {
            sesi.close();
        }

        resp.setContentType("application/json");
        resp.getWriter().write( ""+return_id );
    }

}
