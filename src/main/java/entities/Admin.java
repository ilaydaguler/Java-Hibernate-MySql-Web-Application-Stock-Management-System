package entities;

import lombok.Data;

import javax.persistence.*;
import java.util.Objects;

@Entity
@Data
public class Admin {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;
    @Basic
    private String nameSurname;
    @Basic
    private String email;
    @Basic
    @Column(length = 32)
    private String password;



    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Admin admin = (Admin) o;
        return id == admin.id && Objects.equals(nameSurname, admin.nameSurname) && Objects.equals(email, admin.email) && Objects.equals(password, admin.password);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id, nameSurname, email, password);
    }
}
