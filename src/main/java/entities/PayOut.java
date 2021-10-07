package entities;

import lombok.Data;
import org.hibernate.query.criteria.internal.expression.function.CurrentDateFunction;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import java.sql.Date;
import java.time.LocalDate;
import java.time.LocalDateTime;

@Entity
@Data
public class PayOut {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int po_id;

    private String po_title;
    private int po_type;
    private int po_total;
    private String po_detail;
    private Date date;


}
