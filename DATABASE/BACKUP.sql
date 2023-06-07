/*
SQLyog Ultimate v12.5.1 (64 bit)
MySQL - 10.4.24-MariaDB : Database - instituto
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`instituto` /*!40100 DEFAULT CHARACTER SET utf8mb4 */;

USE `instituto`;

/*Table structure for table `cursos` */

DROP TABLE IF EXISTS `cursos`;

CREATE TABLE `cursos` (
  `idcurso` int(11) NOT NULL AUTO_INCREMENT,
  `idprofesor` int(11) NOT NULL,
  `idsede` int(11) NOT NULL,
  `titulo` varchar(40) NOT NULL,
  `descripcion` varchar(100) DEFAULT NULL,
  `fechainicio` date NOT NULL,
  `complejidad` tinyint(4) NOT NULL,
  `fecharegistro` datetime NOT NULL DEFAULT current_timestamp(),
  `precio` decimal(7,2) NOT NULL,
  `estado` char(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`idcurso`),
  KEY `fk_idprofesor` (`idprofesor`),
  KEY `fk_idsede` (`idsede`),
  CONSTRAINT `fk_idprofesor` FOREIGN KEY (`idprofesor`) REFERENCES `profesores` (`idprofesor`),
  CONSTRAINT `fk_idsede` FOREIGN KEY (`idsede`) REFERENCES `sedes` (`idsede`),
  CONSTRAINT `ck_precio` CHECK (`precio` > 0)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4;

/*Data for the table `cursos` */

insert  into `cursos`(`idcurso`,`idprofesor`,`idsede`,`titulo`,`descripcion`,`fechainicio`,`complejidad`,`fecharegistro`,`precio`,`estado`) values 
(1,1,3,'Introdución al DISEÑO GRÁFICO',NULL,'2022-12-08',1,'2022-12-07 14:34:19',150.00,'1'),
(2,2,1,'Java','introduccion al mundo de java','2023-01-15',2,'2022-12-07 14:34:19',190.00,'1'),
(3,5,2,'Adobe Photoshop CC','herramientas esenciales de adobe photoshop cc','2023-01-31',4,'2022-12-07 14:34:19',250.00,'1'),
(4,4,1,'Modelado de software',NULL,'2023-02-01',3,'2022-12-07 14:55:48',300.00,'1');

/*Table structure for table `especialidades` */

DROP TABLE IF EXISTS `especialidades`;

CREATE TABLE `especialidades` (
  `idespecialidad` int(11) NOT NULL AUTO_INCREMENT,
  `especialidad` varchar(50) NOT NULL,
  `estado` char(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`idespecialidad`),
  UNIQUE KEY `uk_especialidad` (`especialidad`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4;

/*Data for the table `especialidades` */

insert  into `especialidades`(`idespecialidad`,`especialidad`,`estado`) values 
(1,'Desarrollo de software','1'),
(2,'Diseño Grafico','1'),
(3,'Seguridad Informatica','1'),
(4,'Arquitectura de Sofware','1');

/*Table structure for table `personas` */

DROP TABLE IF EXISTS `personas`;

CREATE TABLE `personas` (
  `idpersona` int(11) NOT NULL AUTO_INCREMENT,
  `apellidos` varchar(20) NOT NULL,
  `nombres` varchar(20) NOT NULL,
  `dni` char(8) NOT NULL,
  PRIMARY KEY (`idpersona`),
  UNIQUE KEY `uk_dni` (`dni`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4;

/*Data for the table `personas` */

insert  into `personas`(`idpersona`,`apellidos`,`nombres`,`dni`) values 
(1,'Suarez Matias','Irene Alejandra','76364010'),
(2,'Neyra Vilela','Fabiola','76364011'),
(3,'Pachas Atuncar','Andrea','76364012'),
(4,'Rojas llanos','Joseph Anthony','76364013'),
(5,'Gutierrez Felipa','Frank Anderson','76364014'),
(6,'Tasayco Pachas','Kiara Yanina','76364015'),
(7,'Hernandez Gomez','Geraldine','76364016'),
(8,'Gomez Herrera','Carlos','76364017');

/*Table structure for table `profesores` */

DROP TABLE IF EXISTS `profesores`;

CREATE TABLE `profesores` (
  `idprofesor` int(11) NOT NULL AUTO_INCREMENT,
  `idpersona` int(11) NOT NULL,
  `idespecialidad` int(11) NOT NULL,
  PRIMARY KEY (`idprofesor`),
  KEY `fk_idpersona_profesores` (`idpersona`),
  KEY `fk_idespecialidad` (`idespecialidad`),
  CONSTRAINT `fk_idespecialidad` FOREIGN KEY (`idespecialidad`) REFERENCES `especialidades` (`idespecialidad`),
  CONSTRAINT `fk_idpersona_profesores` FOREIGN KEY (`idpersona`) REFERENCES `personas` (`idpersona`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4;

/*Data for the table `profesores` */

insert  into `profesores`(`idprofesor`,`idpersona`,`idespecialidad`) values 
(1,2,2),
(2,3,1),
(3,4,3),
(4,6,4),
(5,7,2);

/*Table structure for table `sedes` */

DROP TABLE IF EXISTS `sedes`;

CREATE TABLE `sedes` (
  `idsede` int(11) NOT NULL AUTO_INCREMENT,
  `nombresede` varchar(40) NOT NULL,
  `fecharegistro` datetime NOT NULL DEFAULT current_timestamp(),
  `estado` char(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`idsede`),
  UNIQUE KEY `uk_nombresede` (`nombresede`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4;

/*Data for the table `sedes` */

insert  into `sedes`(`idsede`,`nombresede`,`fecharegistro`,`estado`) values 
(1,'ICA','2022-12-07 12:25:44','1'),
(2,'CHINCHA','2022-12-07 12:25:44','1'),
(3,'PISCO','2022-12-07 12:25:44','1');

/*Table structure for table `usuarios` */

DROP TABLE IF EXISTS `usuarios`;

CREATE TABLE `usuarios` (
  `idusuario` int(11) NOT NULL AUTO_INCREMENT,
  `idpersona` int(11) NOT NULL,
  `email` varchar(50) NOT NULL,
  `claveacceso` varchar(90) NOT NULL,
  `fecharegistro` datetime NOT NULL DEFAULT current_timestamp(),
  `estado` char(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`idusuario`),
  UNIQUE KEY `uk_email` (`email`),
  KEY `fk_idpersona` (`idpersona`),
  CONSTRAINT `fk_idpersona` FOREIGN KEY (`idpersona`) REFERENCES `personas` (`idpersona`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4;

/*Data for the table `usuarios` */

insert  into `usuarios`(`idusuario`,`idpersona`,`email`,`claveacceso`,`fecharegistro`,`estado`) values 
(1,1,'alejandramatias31@gmail.com','12345','2022-12-07 12:21:25','1'),
(2,5,'tasayco_2001@gmail.com','12345','2022-12-07 12:21:25','1');

/* Procedure structure for procedure `spu_cursos_actualizar` */

/*!50003 DROP PROCEDURE IF EXISTS  `spu_cursos_actualizar` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_cursos_actualizar`(
	in _idcurso			int,
	IN _idprofesor		INT,
	IN _idsede			INT,
	IN _titulo			VARCHAR(40),
	IN _descripcion	VARCHAR(100),
	IN _fechainicio	DATE,
	IN _complejidad	CHAR(1),
	IN _precio			DECIMAL(7,2)
)
begin
	if _descripcion = '' then set _descripcion = null;end if;
	
	update cursos set
		idprofesor 	= _idprofesor,
		idsede		= _idsede,
		titulo 		= _titulo,
		descripcion = _descripcion,
		fechainicio = _fechainicio,
		complejidad = _complejidad,
		precio		= _precio
	where idcurso  = _idcurso;
end */$$
DELIMITER ;

/* Procedure structure for procedure `spu_cursos_buscar` */

/*!50003 DROP PROCEDURE IF EXISTS  `spu_cursos_buscar` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_cursos_buscar`(
	in _idcurso int
)
begin
	SELECT cursos.idcurso, personas.apellidos, personas.nombres, especialidades.especialidad, sedes.nombresede,
				cursos.titulo, cursos.descripcion, cursos.fechainicio, cursos.complejidad, cursos.precio
	FROM cursos
	INNER JOIN profesores ON cursos.idprofesor = profesores.idprofesor
	INNER JOIN especialidades ON profesores.idespecialidad = especialidades.idespecialidad
	INNER JOIN personas ON profesores.idpersona = personas.idpersona
	INNER JOIN sedes ON cursos.idsede = sedes.idsede
	WHERE cursos.estado = '1' and cursos.idcurso = _idcurso;
end */$$
DELIMITER ;

/* Procedure structure for procedure `spu_cursos_eliminar` */

/*!50003 DROP PROCEDURE IF EXISTS  `spu_cursos_eliminar` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_cursos_eliminar`(
	in _idcurso int
)
begin	
	update cursos set
		estado = '0'
	where idcurso = _idcurso;
end */$$
DELIMITER ;

/* Procedure structure for procedure `spu_cursos_eliminar_activar` */

/*!50003 DROP PROCEDURE IF EXISTS  `spu_cursos_eliminar_activar` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_cursos_eliminar_activar`(
	IN _idcurso INT
)
BEGIN	
	UPDATE cursos SET
		estado = '1'
	WHERE idcurso = _idcurso;
END */$$
DELIMITER ;

/* Procedure structure for procedure `spu_cursos_insertar` */

/*!50003 DROP PROCEDURE IF EXISTS  `spu_cursos_insertar` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_cursos_insertar`(
	in _idprofesor		int,
	in _idsede			int,
	in _titulo			varchar(40),
	in _descripcion	varchar(100),
	in _fechainicio	date,
	in _complejidad	char(1),
	in _precio			decimal(7,2)
)
begin
	if _descripcion = '' then set _descripcion = null;end if;
	
	insert into cursos(idprofesor, idsede, titulo, descripcion, fechainicio, complejidad, precio) values
		(_idprofesor,_idsede,_titulo, _descripcion, _fechainicio, _complejidad, _precio);
end */$$
DELIMITER ;

/* Procedure structure for procedure `spu_cursos_listar` */

/*!50003 DROP PROCEDURE IF EXISTS  `spu_cursos_listar` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_cursos_listar`()
BEGIN
	SELECT cursos.idcurso, personas.apellidos, personas.nombres, especialidades.especialidad, sedes.nombresede,
				cursos.titulo, cursos.descripcion, cursos.fechainicio, cursos.complejidad, cursos.precio
	FROM cursos
	INNER JOIN profesores ON cursos.idprofesor = profesores.idprofesor
	INNER JOIN especialidades ON profesores.idespecialidad = especialidades.idespecialidad
	INNER JOIN personas ON profesores.idpersona = personas.idpersona
	INNER JOIN sedes ON cursos.idsede = sedes.idsede
	WHERE cursos.estado = '1';
END */$$
DELIMITER ;

/* Procedure structure for procedure `spu_cursos_obtenerdatos` */

/*!50003 DROP PROCEDURE IF EXISTS  `spu_cursos_obtenerdatos` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_cursos_obtenerdatos`(in _idcurso int)
begin
	select idcurso, idprofesor, idsede, titulo, descripcion, fechainicio, complejidad, precio
	from cursos
	where idcurso = _idcurso;
end */$$
DELIMITER ;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
