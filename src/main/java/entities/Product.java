package entities;

import lombok.Data;

import javax.persistence.*;

@Entity
@Data
public class Product {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int p_id;

    private String p_title;
    private int p_purchase_price;
    private int p_sales_price;
    private int p_code;
    private int p_KDV;
    private String p_unit;
    private int p_amount;

    @Column(length = 500)
    private String p_detail;

}
