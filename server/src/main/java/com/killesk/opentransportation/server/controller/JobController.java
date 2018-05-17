package com.killesk.opentransportation.server.controller;

import com.killesk.opentransportation.server.repo.model.Job;
import com.killesk.opentransportation.server.service.JobService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping({"/api/job"})
public class JobController {

    @Autowired
    private JobService jobService;

    @PostMapping
    public Job create(@RequestBody Job job){
        return jobService.create(job);
    }

    @GetMapping(path = {"/{id}"})
    public Job findOne(@PathVariable("id") int id){
        return jobService.findById(id);
    }

    @PutMapping
    public Job update(@RequestBody Job job){
        return jobService.update(job);
    }

    @DeleteMapping(path ={"/{id}"})
    public void delete(@PathVariable("id") int id) {
        jobService.delete(id);
    }

    @GetMapping
    public List<Job> findAll(){
        return jobService.findAll();
    }
}
