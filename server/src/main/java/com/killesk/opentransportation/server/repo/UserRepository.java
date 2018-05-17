package com.killesk.opentransportation.server.repo;

import com.killesk.opentransportation.server.repo.model.User;
import org.springframework.data.repository.CrudRepository;

public interface UserRepository extends CrudRepository<User, Integer> {

}
