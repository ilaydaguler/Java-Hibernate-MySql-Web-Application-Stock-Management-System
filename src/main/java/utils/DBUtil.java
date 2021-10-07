package utils;

import entities.*;
import utils.Util;
import org.hibernate.Session;
import org.hibernate.SessionFactory;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;

public class DBUtil {

    SessionFactory sf = HibernateUtil.getSessionFactory();
    public List<Customer> customerList() {
        Session sesi = sf.openSession();
        List<Customer> ls = sesi.createQuery("from Customer").getResultList();
        return ls;
    }
    public List<Product> productList() {
        Session sesi = sf.openSession();
        List<Product> ls = sesi.createQuery("from Product").getResultList();
        return ls;
    }
    //son 5 stok ürün listesi
    public List<Product> products(){
        Session sesi = sf.openSession();
        List<Product> ls =  sesi.createNativeQuery("SELECT * FROM product \n" +
                        "ORDER BY product.p_id DESC\n" +
                        "LIMIT 5 \n")
                .addEntity(Product.class)
                .getResultList();


        return ls;


    }
    public List<BoxCustomerProduct> boxCustomerProductList(){
        Session sesi = sf.openSession();
        List<BoxCustomerProduct> ls =  sesi.createNativeQuery("SELECT * FROM box\n" +
                        "INNER JOIN customer \n" +
                        "ON box.b_customer_id = customer.cu_id\n" +
                        "INNER JOIN product\n" +
                        "ON product.p_id = box.b_product_id\n" +
                        "ORDER BY box.b_bno DESC\n" +
                        "LIMIT 5 ;")
                .addEntity(BoxCustomerProduct.class)
                .getResultList();

        return ls;

    }



    public List<Box> boxes(){
        Session sesi = sf.openSession();
        List<Box> ls = sesi.createQuery("from Box ").getResultList();

        return ls;
    }

    public Long payInTotal(){
        Session sesi = sf.openSession();
        String sql= "select SUM(pay_price) from PayIn";
        Long intotal =(Long) sesi.createQuery(sql).getSingleResult();
        System.out.println(intotal);
        return intotal;
    }
    public Long payOutTotal(){
        Session sesi = sf.openSession();
        String sql= "select SUM(po_total) from PayOut";
        Long outtotal =(Long) sesi.createQuery(sql).getSingleResult();
        System.out.println(outtotal);
        return outtotal;
    }
    public Long todayPayIn(){
        Session sesi= sf.openSession();
        String sql ="select SUM(pay_price) from PayIn where date=CURDATE()";
        Long intotal =(Long) sesi.createQuery(sql).getSingleResult();
        System.out.println(intotal);
        return intotal;
    }
    public Long todayPayOut(){
        Session sesi= sf.openSession();
        String sql ="select SUM(po_total) from PayOut where date=CURDATE()";
        Long outtotal =(Long) sesi.createQuery(sql).getSingleResult();
        System.out.println(outtotal);
        return outtotal;
    }
    public Long totalProduct(){
        Session sesi = sf.openSession();
        String sql= "select count(p_id) from Product ";
        Long total =(Long) sesi.createQuery(sql).getSingleResult();
        System.out.println(total);
        return total;
    }
    public Long totalOrder(){
        Session sesi = sf.openSession();
        String sql= "select count(b_id) from Box ";
        Long total =(Long) sesi.createQuery(sql).getSingleResult();
        System.out.println(total);
        return total;
    }
    public Long totalCustomer(){
        Session sesi = sf.openSession();
        String sql= "select count(cu_id) from Customer ";
        Long total =(Long) sesi.createQuery(sql).getSingleResult();
        System.out.println(total);
        return total;
    }
    public Long totalPamount(){
        Session sesi = sf.openSession();
        String sql= "select sum(p_amount)from Product ";
        Long total =(Long) sesi.createQuery(sql).getSingleResult();
        System.out.println(total);
        return total;
    }
    public Long totalPurchase(){
        Session sesi = sf.openSession();
        String sql= "select sum(p_purchase_price)from Product ";
        Long total =(Long) sesi.createQuery(sql).getSingleResult();
        System.out.println(total);
        return total;
    }
    public Long totalSales(){
        Session sesi = sf.openSession();
        String sql= "select sum(p_sales_price)from Product ";
        Long total =(Long) sesi.createQuery(sql).getSingleResult();
        System.out.println(total);
        return total;

    }
    public int login(String email, String password, String remember, HttpServletRequest req, HttpServletResponse resp) {

        Session sesi = sf.openSession();
        List<Admin> ls = null;
        try {
            String sql = "from Admin where email=?1 and password=?2";
            ls = sesi
                    .createQuery(sql)
                    .setParameter(1, email)
                    .setParameter(2,Util.MD5(password))
                    .getResultList();
            System.out.println("status : " + ls.size());
            // COOKIE
            if(ls.size() !=0){
                int id = ls.get(0).getId();
                String nameSurname = ls.get(0).getNameSurname();

                req.getSession().setAttribute("id", id);
                req.getSession().setAttribute("nameSurname", nameSurname);

                if ( remember != null && remember.equals("on")) {
                    nameSurname = nameSurname.replaceAll(" ", "_");
                    String val = id+"_"+nameSurname;
                    Cookie cookie = new Cookie("admin", val);
                    cookie.setMaxAge( 60*60 );
                    resp.addCookie(cookie);
                }
            }
        } catch (Exception e) {
            System.err.println("Login Error : " + e);
        } finally {
            sesi.close();
        }

        return ls.size();
    }
    public Admin isLogin(HttpServletRequest request, HttpServletResponse response){
        if (request.getCookies() != null){ //eğer cookimiz varsa işlemleri yapar
            Cookie[] cookies = request.getCookies();
            for (Cookie cookie: cookies ){
                if (cookie.getName().equals("admin")){ //beni hatırla cookisi yapılmış mı
                    String values = cookie.getValue(); //yapının içindeki değeri getir

                    try{
                        String[] arr= values.split("_");
                        request.getSession().setAttribute("id",Integer.parseInt(arr[0]));
                        request.getSession().setAttribute("name",arr[1]+" " + arr[2]);

                    }catch (NumberFormatException e){ //cookie değiştirilmeye çalışılırsa cookie patlatılır
                        Cookie cookie1 = new Cookie("admin","");
                        cookie1.setMaxAge(0);
                        response.addCookie(cookie1);

                    }

                    break;

                }
            }
        }

        Object sessionObg = request.getSession().getAttribute("id");
        Admin adm = new Admin();
        if(sessionObg ==null){

            try{
                response.sendRedirect(Util.base_url);

            }catch (Exception ex){
                System.err.println("isLogin error: " + ex);

            }

        }else{
            //dashboard içinde girilen adminin ismi getirilir
            int aid = (int) request.getSession().getAttribute("id");
            String name = (String) request.getSession().getAttribute("name");
            adm.setId(aid);
            adm.setNameSurname(name);



        }
        return  adm;
    }

}
