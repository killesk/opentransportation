package com.killesk.opentransportation.server.repo.model;

import lombok.*;

import javax.persistence.*;
import java.util.Date;

@Getter
@Setter
@NoArgsConstructor
@ToString
@EqualsAndHashCode

@Entity
@Table(name = "job")
public class Job {

    @Id
    @Column
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer job_id;
    @Column
    private String name;
    @Column
    private Date last_updated;
    @Column
    private Date created;
    @Column
    private Integer user_id;

}
