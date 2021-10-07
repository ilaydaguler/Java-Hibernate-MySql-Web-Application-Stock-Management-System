package servlets;

import com.google.gson.Gson;
import entities.BoxCustomerProduct;
import entities.PayIn;
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
import java.util.concurrent.atomic.AtomicInteger;

@WebServlet(name = "payCompleteServlet", value = "/paycomplete-post")
public class PayCompleteServlet extends HttpServlet {
    SessionFactory sf = HibernateUtil.getSessionFactory();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int cid = Integer.parseInt(req.getParameter("user_id"));

        AtomicInteger total = new AtomicInteger();
        AtomicInteger receiptNo = new AtomicInteger();

        Gson gson = new Gson();
        Session sesi = sf.openSession();
        Transaction tr = sesi.beginTransaction();
        List<BoxCustomerProduct> ls = sesi.createNativeQuery("SELECT * FROM box as box\n" +
                        "INNER JOIN customer as cu\n" +
                        "on box.b_customer_id = cu.cu_id\n" +
                        "INNER JOIN product as pro\n" +
                        "on pro.p_id = box.b_product_id\n" +
                        "WHERE box.b_customer_id = ?1 and box.b_status=?2")
                .setParameter(1,cid)
                .setParameter(2,0)
                .addEntity(BoxCustomerProduct.class)
                .getResultList();
        ls.forEach(item->{

            total.addAndGet(item.getB_count() * item.getP_sales_price());
            receiptNo.addAndGet(item.getB_bno());

            String hqlUpdate = "update Box c set c.b_status = :newStatus where c.b_bno = :boxReceipt";

            sesi.createQuery( hqlUpdate )
                    .setParameter( "newStatus", 1 )
                    .setParameter( "boxReceipt", item.getB_bno() )
                    .executeUpdate();



        });
        int totalResult = total.intValue();
        int receiptNoResult = receiptNo.intValue();

        PayIn payIn = new PayIn();
        payIn.setPay_customer_id(cid);
        payIn.setPay_price(totalResult);
        payIn.setPay_bno(receiptNoResult);
        sesi.save(payIn);

        tr.commit();
        sesi.close();





        String stJson = gson.toJson(total);
        resp.setContentType("application/json");
        resp.getWriter().write( stJson );
    }



}
