package com.killesk.opentransportation.server.repo;

import com.killesk.opentransportation.server.repo.model.User;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;


public interface UserRepository extends JpaRepository<User, Integer> {
    void delete(User user);

    List<User> findAll();

    User findOne(int id);

    User save(User user);
}
