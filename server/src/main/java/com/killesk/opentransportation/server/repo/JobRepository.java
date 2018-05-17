package com.killesk.opentransportation.server.repo;

import com.killesk.opentransportation.server.repo.model.Job;
import org.springframework.data.repository.CrudRepository;

public interface JobRepository extends CrudRepository<Job, Integer> {

}
