package com.servidor.repository;

import com.servidor.entity.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.jpa.repository.query.Procedure;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface UserRepository  extends JpaRepository<User, Integer> {

    @Procedure(procedureName = "sp_login", outputParameterName = "acceso")
    int login(@Param("p_correo") String p_correo, @Param("p_contrasenia") String p_contrasenia);

    @Query(value = "SELECT*FROM usuarios where id_usuario =:id_usuario",nativeQuery = true)
    User getUserBy(int id_usuario);

}
