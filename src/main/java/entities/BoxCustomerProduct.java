package entities;

import lombok.Data;

import javax.persistence.Entity;
import javax.persistence.Id;

@Entity
@Data
public class BoxCustomerProduct {
    @Id
    private int b_id;
    private String cu_name;
    private String cu_surname;
    private String p_title;
    private int p_sales_price;
    private int b_count;
    private int b_bno;

}
