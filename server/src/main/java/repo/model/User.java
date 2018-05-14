package repo.model;

import lombok.*;

import javax.persistence.*;
import java.util.Date;

@Getter @Setter
@NoArgsConstructor
@ToString @EqualsAndHashCode

@Entity
@Table(name = "user")
public class User {

    @Id
    @Column
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer user_id;
    @Column
    private String email;
    @Column
    private Date created;
    @Column
    private Date last_updated;
    @Column
    private Integer type;
}
