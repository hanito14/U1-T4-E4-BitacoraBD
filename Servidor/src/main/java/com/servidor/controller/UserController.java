package com.servidor.controller;

import com.servidor.entity.User;
import com.servidor.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;

@Controller
public class UserController {

    @Autowired
    private UserService userService;

    @PostMapping(value = "/logear")
    public String userLogin(@RequestParam("correo")String correo,@RequestParam("contrasenia")String contrasenia){
        int valor = userService.login(correo, contrasenia);
        if(valor == 1){
            return "crearUsuario";
        }else{
            return "index";
        }
    }

    @GetMapping("/")
    public String redIndex(){
        return "/index";
    }

    @GetMapping("/listar")
    public String redListar(Model model){
        List<User> userList = new ArrayList<User>();
        userList = userService.getAll();
        model.addAttribute("user", userList);
        return "listarUsuario";
    }

    @GetMapping("/editar")
    public String redEditar(){
        return "/editarUsuario";
    }

    @GetMapping("/editado")
    public String Redupdate(@RequestParam("idUsuario") int idUsuario, Model model){
        User user = new User();
        user = userService.getOne(idUsuario);
        model.addAttribute("user", user);
        return "editarUsuario";
    }

    @PostMapping(value = "/update")
    public String updateUser(@RequestParam("idUsuario") int idUsuario,@RequestParam("nombre") String nombre, @RequestParam("apellidoPaterno") String apellidoPaterno,
                             @RequestParam("apellidoMaterno") String apellidoMaterno, @RequestParam("edad") int edad,
                             @RequestParam("direccion") String direccion, @RequestParam("correo") String correo,
                             @RequestParam("contrasenia") String contrasenia, Model model){
        User user = new User(idUsuario, nombre, apellidoPaterno, apellidoMaterno, edad, direccion, correo, contrasenia);
        userService.saveOrUpdate(user);
        List<User> userList = new ArrayList<User>();
        userList = userService.getAll();
        model.addAttribute("user", userList);
        return "listarUsuario";
    }

    @GetMapping(value = "/delete")
    public String deleteUser(@RequestParam("idUsuario") int idUsuario, Model model){
        userService.remove(idUsuario);
        List<User> userList = new ArrayList<User>();
        userList = userService.getAll();
        model.addAttribute("user", userList);
        return "listarUsuario";
    }

    @PostMapping(value = "/guardar")
    public String saveUser(@RequestParam("nombre") String nombre, @RequestParam("apellidoPaterno") String apellidoPaterno,
                           @RequestParam("apellidoMaterno") String apellidoMaterno, @RequestParam("edad") int edad,
                           @RequestParam("direccion") String direccion, @RequestParam("correo") String correo,
                           @RequestParam("contrasenia") String contrasenia){
        User user = new User(nombre, apellidoPaterno, apellidoMaterno, edad, direccion, correo, contrasenia);
        user.setIdUsuario(0);
        userService.saveOrUpdate(user);
        return "crearUsuario";
    }

    @GetMapping("/crear")
    public String redCrear(){
        return "crearUsuario";
    }

}
