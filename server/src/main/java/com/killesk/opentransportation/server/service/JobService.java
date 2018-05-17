package com.killesk.opentransportation.server.service;

import com.killesk.opentransportation.server.repo.JobRepository;
import com.killesk.opentransportation.server.repo.model.Job;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Objects;
import java.util.stream.Collectors;
import java.util.stream.StreamSupport;

@Service
public class JobService {

    @Autowired
    private JobRepository repository;

    public Job create(Job job) {
        return repository.save(job);
    }

    public void delete(Integer id) {
        repository.deleteById(id);
    }

    public List<Job> findAll() {
        return StreamSupport.stream(repository.findAll().spliterator(), false)
                .filter(Objects::nonNull).collect(Collectors.toList());
    }

    public Job findById(int id) {
        return repository.findById(id).get();
    }

    public Job update(Job job) {
        return repository.save(job);
    }
}
