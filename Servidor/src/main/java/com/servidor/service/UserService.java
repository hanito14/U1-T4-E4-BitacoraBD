package com.servidor.service;

import com.servidor.entity.User;
import com.servidor.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class UserService {

    @Autowired
    private UserRepository userRepository;

    public User saveOrUpdate(User usuarios){
        return userRepository.save(usuarios);
    }

    public int login(String correo, String contrasenia){
        return userRepository.login(correo, contrasenia);
    }

    public List<User> getAll(){
        return userRepository.findAll();
    }

    public User getOne(int idUsuario){
        return userRepository.getUserBy(idUsuario);
    }

    public void remove(int idUsuario){
        userRepository.deleteById(idUsuario);
    }

}
