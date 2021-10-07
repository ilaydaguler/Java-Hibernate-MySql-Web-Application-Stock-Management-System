package entities;

import lombok.Data;

import javax.persistence.*;

@Entity
@Data
public class Box {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int b_id;
    private int b_customer_id;
    private int b_product_id;
    private int b_count;
    private int b_bno;
    private int b_status;
    @OneToOne(cascade = CascadeType.DETACH)
    private Product product;

}
