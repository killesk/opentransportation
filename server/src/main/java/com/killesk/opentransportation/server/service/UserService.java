package com.killesk.opentransportation.server.service;

import com.killesk.opentransportation.server.repo.UserRepository;
import com.killesk.opentransportation.server.repo.model.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Objects;
import java.util.stream.Collectors;
import java.util.stream.StreamSupport;

@Service
public class UserService {

    @Autowired
    private UserRepository repository;

    public User create(User user) {
        return repository.save(user);
    }

    public void delete(Integer id) {
        repository.deleteById(id);
    }

    public List<User> findAll() {
        return StreamSupport.stream(repository.findAll().spliterator(), false)
                .filter(Objects::nonNull).collect(Collectors.toList());
    }

    public User findById(int id) {
        return repository.findById(id).get();
    }

    public User update(User user) {
        return repository.save(user);
    }
}
