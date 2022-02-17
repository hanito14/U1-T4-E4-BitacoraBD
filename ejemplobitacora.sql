CREATE DATABASE  IF NOT EXISTS `ejemplobitacora` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `ejemplobitacora`;
-- MySQL dump 10.13  Distrib 8.0.22, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: ejemplobitacora
-- ------------------------------------------------------
-- Server version	8.0.22

--
-- Table structure for table `bitacoralogin`
--

DROP TABLE IF EXISTS `bitacoralogin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bitacoralogin` (
  `idControl` int NOT NULL AUTO_INCREMENT,
  `fechaAcceso` datetime NOT NULL,
  `correoUsuario` varchar(45) NOT NULL,
  PRIMARY KEY (`idControl`)
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `bitacorausuario`
--

DROP TABLE IF EXISTS `bitacorausuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bitacorausuario` (
  `idBitacoraUsuario` int NOT NULL AUTO_INCREMENT,
  `operacion` varchar(10) DEFAULT NULL,
  `usuario` varchar(40) DEFAULT NULL,
  `host` varchar(30) NOT NULL,
  `fecha` datetime DEFAULT NULL,
  `tabla` varchar(40) NOT NULL,
  `datos` varchar(400) DEFAULT NULL,
  PRIMARY KEY (`idBitacoraUsuario`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `usuarios`
--

DROP TABLE IF EXISTS `usuarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuarios` (
  `id_usuario` int NOT NULL AUTO_INCREMENT,
  `apellido_materno` varchar(45) DEFAULT NULL,
  `apellido_paterno` varchar(45) DEFAULT NULL,
  `contrasenia` varchar(45) DEFAULT NULL,
  `correo` varchar(45) DEFAULT NULL,
  `direccion` varchar(45) DEFAULT NULL,
  `edad` int DEFAULT NULL,
  `nombre` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id_usuario`)
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;



DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_login`(IN p_correo VARCHAR(45), IN p_contrasenia VARCHAR(45), OUT acceso int)
BEGIN
	SELECT count(*) INTO acceso FROM usuarios u WHERE u.correo = p_correo AND u.contrasenia = p_contrasenia;
	IF acceso = 1 THEN
		INSERT INTO `bitacoraLogin` (`fechaAcceso`, `correoUsuario`) VALUES (now(), p_correo);
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-02-17  9:24:11


DROP TRIGGER IF EXISTS `bitacoraUsuarioDel`;
DELIMITER //
  CREATE TRIGGER `bitacoraUsuarioDel` AFTER DELETE ON `usuarios`
  FOR EACH ROW INSERT INTO bitacoraUsuario(host, usuario, operacion, fecha, tabla) VALUES (SUBSTRING(USER(), (INSTR(USER(),'@')+1)), SUBSTRING(USER(),1,(instr(user(),'@')-1)), 'ELIMINAR', NOW(), 'USUARIOS')
//



DELIMITER //
  CREATE TRIGGER `bitacoraUsuarioIns` AFTER INSERT ON `usuarios`
  FOR EACH ROW BEGIN
    INSERT INTO bitacoraUsuario(host, usuario, operacion, fecha, tabla, datos)
    VALUES (SUBSTRING(USER(), (INSTR(USER(),'@')+1)), SUBSTRING(USER(),1,(instr(user(),'@')-1)), "INSERTAR", NOW(), 'USUARIOS',
  CONCAT('{Nombre: ',new.nombre,", apellido materno: ",new.apellido_materno, ", apellido paterno: ", new.apellido_paterno, ", contrasenia: ", new.contrasenia, ", correo: ", new.correo, ", direccion:", new.direccion, ", edad:", new.edad,"}")
    );
    END
//



DELIMITER //
  CREATE TRIGGER `bitacoraUsuarioUpd` AFTER UPDATE ON `usuarios`
  FOR EACH ROW BEGIN
    INSERT INTO bitacoraUsuario(host, usuario, operacion, fecha, tabla, datos)
    VALUES (SUBSTRING(USER(), (INSTR(USER(),'@')+1)), SUBSTRING(USER(),1,(instr(user(),'@')-1)), "MODIFICAR", NOW(), 'USUARIOS',
  CONCAT('{Nombre: ',old.nombre,", apellido materno: ", old.apellido_materno, ", apellido paterno: ", old.apellido_paterno, ", contrasenia: ", old.contrasenia, ", correo: ", old.correo, ", direccion:", old.direccion, ", edad:", old.edad,"}",'{Nombre: ',new.nombre,", apellido materno: ",new.apellido_materno, ", apellido paterno: ", new.apellido_paterno, ", contrasenia: ", new.contrasenia, ", correo: ", new.correo, ", direccion:", new.direccion, ", edad:", new.edad,"}")
    );
    END
//
