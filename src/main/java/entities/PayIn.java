package entities;

import lombok.Data;
import org.hibernate.query.criteria.internal.expression.function.CurrentDateFunction;

import javax.persistence.*;
import java.sql.Date;

@Entity
@Data
public class PayIn {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int pay_id;
    private int pay_customer_id;
    private int pay_bno;
    private int pay_price;
    private String pay_detail;
    private Date date;


}
