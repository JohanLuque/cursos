CREATE DATABASE instituto;

USE instituto;

CREATE TABLE personas
(
	idpersona	INT AUTO_INCREMENT PRIMARY KEY,
	apellidos	VARCHAR(20)		NOT NULL,
	nombres		VARCHAR(20)		NOT NULL,
	dni		CHAR(8)			NOT NULL,
	CONSTRAINT uk_dni UNIQUE (dni)
	
)ENGINE = INNODB;

-- -----------------------------------------------------------------------------
INSERT INTO personas(apellidos, nombres, dni) VALUES
('Suarez Matias', 'Irene Alejandra', '76364010'),
('Neyra Vilela', 'Fabiola','76364011'),
('Pachas Atuncar' ,'Andrea','76364012'),
('Rojas llanos', 'Joseph Anthony', '76364013'),
('Gutierrez Felipa', 'Frank Anderson', '76364014'),
('Tasayco Pachas', 'Kiara Yanina', '76364015'),
('Hernandez Gomez', 'Geraldine', '76364016'),
('Gomez Herrera', 'Carlos','76364017');

CREATE TABLE usuarios
(
	idusuario		INT AUTO_INCREMENT PRIMARY KEY,
	idpersona		INT 		NOT NULL,
	email			VARCHAR(50)	NOT NULL,
	claveacceso		VARCHAR(90)	NOT NULL,
	fecharegistro		DATETIME 	NOT NULL DEFAULT NOW(),
	estado			CHAR(1)		NOT NULL DEFAULT '1',
	CONSTRAINT uk_email UNIQUE (email),
	CONSTRAINT fk_idpersona FOREIGN KEY (idpersona) REFERENCES personas(idpersona)
) ENGINE = INNODB;
-- ---------------------------------------------------------------------------------

INSERT INTO usuarios(idpersona, email, claveacceso) VALUES
(1,'alejandramatias31@gmail.com','12345'),
(5,'tasayco_2001@gmail.com', '12345');

CREATE TABLE especialidades
(
	idespecialidad		INT AUTO_INCREMENT PRIMARY KEY,
	especialidad		VARCHAR(50)		NOT NULL,
	estado 			CHAR(1)			NOT NULL DEFAULT '1',
	CONSTRAINT uk_especialidad UNIQUE (especialidad)
)ENGINE = INNODB;
-- ---------------------------------------------------------------------------------
INSERT INTO especialidades (especialidad) VALUES
('Desarrollo de software'),
('Diseño Grafico'),
('Seguridad Informatica'),
('Arquitectura de Sofware');


CREATE TABLE profesores
(
	idprofesor		INT AUTO_INCREMENT PRIMARY KEY,
	idpersona		INT 		NOT NULL,
	idespecialidad		INT 		NOT NULL,
	CONSTRAINT fk_idpersona_profesores FOREIGN KEY (idpersona) REFERENCES personas(idpersona),
	CONSTRAINT fk_idespecialidad FOREIGN KEY (idespecialidad) REFERENCES especialidades(idespecialidad)
	
)ENGINE = INNODB;
-- --------------------------------------------------------------------------------------------------
INSERT INTO profesores (idpersona,idespecialidad) VALUES
(2,2),
(3,1),
(4,3),
(6,4),
(7,2);

CREATE TABLE sedes
(
	idsede			INT AUTO_INCREMENT PRIMARY KEY,
	nombresede		VARCHAR(40)	NOT NULL,
	fecharegistro		DATETIME	NOT NULL DEFAULT NOW(),
	estado			CHAR(1)		NOT NULL DEFAULT '1',
	CONSTRAINT uk_nombresede UNIQUE (nombresede)
)ENGINE = INNODB;

-- ---------------------------------------------------------------------------------------------------------
INSERT INTO sedes (nombresede) VALUES
('ICA'),
('CHINCHA'),
('PISCO');

CREATE TABLE complejidades
(
	idcomplejidad		INT AUTO_INCREMENT PRIMARY KEY,
	complejidad		VARCHAR(20)	NOT NULL,
	CONSTRAINT uk_complejidad UNIQUE (complejidad) 
)ENGINE = INNODB;

INSERT INTO complejidades (complejidad) VALUES
('Baja'),
('Media-Baja'),
('Media'),
('Alta'),
('Muy alta');

CREATE TABLE cursos
(
	idcurso			INT AUTO_INCREMENT PRIMARY KEY,
	idprofesor		INT 			NOT NULL,
	idsede			INT 			NOT NULL,
	titulo			VARCHAR(40)		NOT NULL,
	descripcion		VARCHAR(100)		NULL,
	fechainicio		DATE			NOT NULL,
	idcomplejidad		INT			NOT NULL,
	fecharegistro		DATETIME		NOT NULL DEFAULT NOW(),
	precio			DECIMAL(7,2)		NOT NULL,
	estado			CHAR(1)			NOT NULL DEFAULT '1',
	CONSTRAINT fk_idprofesor FOREIGN KEY (idprofesor) REFERENCES profesores(idprofesor),
	CONSTRAINT fk_idsede FOREIGN KEY (idsede) REFERENCES sedes(idsede),
	CONSTRAINT fk_idcomplejidad FOREIGN KEY (idcomplejidad) REFERENCES complejidades(idcomplejidad),
	CONSTRAINT ck_precio CHECK (precio > 0)		
)ENGINE = INNODB;

-- ---------------------------------------------------------------------------------------------------
INSERT INTO cursos (idprofesor, idsede, titulo, descripcion, fechainicio, idcomplejidad, precio) VALUES
(1,3,'Introdución al DISEÑO GRÁFICO','','2022/12/08',1,150),
(2,1,'Java','introduccion al mundo de java','2023/01/15',2,190),
(5,2,'Adobe Photoshop CC','herramientas esenciales de adobe photoshop cc','2023/01/31',4,250);

-- Procedimientos almacenados
-- Cursos LISTAR
DELIMITER $$
CREATE PROCEDURE spu_cursos_listar()
BEGIN
	SELECT cursos.idcurso, personas.apellidos, personas.nombres, especialidades.especialidad, sedes.nombresede,
				cursos.titulo, cursos.descripcion, cursos.fechainicio, complejidades.complejidad, cursos.precio
	FROM cursos
	INNER JOIN complejidades ON cursos.idcomplejidad = complejidades.idcomplejidad
	INNER JOIN profesores ON cursos.idprofesor = profesores.idprofesor
	INNER JOIN especialidades ON profesores.idespecialidad = especialidades.idespecialidad
	INNER JOIN personas ON profesores.idpersona = personas.idpersona
	INNER JOIN sedes ON cursos.idsede = sedes.idsede
	WHERE cursos.estado = '1';
END$$

CALL spu_cursos_listar();

-- Complejidades: Listar
DELIMITER $$
CREATE PROCEDURE spu_complejidad_listar()
BEGIN
	SELECT idcomplejidad, complejidad
	FROM complejidades;
END $$
-- especialidades: LISTAR
DELIMITER $$
CREATE PROCEDURE spu_especialidades_listar()
BEGIN
	SELECT idespecialidad, especialidad
	FROM especialidades
	WHERE estado = '1';
END$$


-- sedes: LISTAR
DELIMITER $$
CREATE PROCEDURE spu_sedes_listar()
BEGIN 
	SELECT idsede, nombresede
	FROM sedes
	WHERE estado = '1';
END$$

-- profesores: LISTAR
DELIMITER $$
CREATE PROCEDURE spu_profesores_listar()
BEGIN
	SELECT profesores.idprofesor, personas.nombres, personas.apellidos, especialidades.especialidad
	FROM profesores
	INNER JOIN personas ON profesores.idpersona = personas.idpersona
	inner join especialidades on profesores.idespecialidad = especialidades.idespecialidad;
END$$

-- cursos: INSERTAR
DELIMITER $$
CREATE PROCEDURE spu_cursos_insertar
(
	IN _idprofesor		INT,
	IN _idsede			INT,
	IN _titulo			VARCHAR(40),
	IN _descripcion	VARCHAR(100),
	IN _fechainicio	DATE,
	IN _idcomplejidad	CHAR(1),
	IN _precio			DECIMAL(7,2)
)
BEGIN
	IF _descripcion = '' THEN SET _descripcion = NULL;END IF;
	
	INSERT INTO cursos(idprofesor, idsede, titulo, descripcion, fechainicio, idcomplejidad, precio) VALUES
		(_idprofesor,_idsede,_titulo, _descripcion, _fechainicio, _idcomplejidad, _precio);
END$$

CALL spu_cursos_insertar(4,1,'Modelado de software','','2023/02/01',3,300);

-- cursos: Actualizar
DELIMITER $$
CREATE PROCEDURE spu_cursos_actualizar
(
	IN _idcurso			INT,
	IN _idprofesor		INT,
	IN _idsede			INT,
	IN _titulo			VARCHAR(40),
	IN _descripcion	VARCHAR(100),
	IN _fechainicio	DATE,
	IN _idcomplejidad	CHAR(1),
	IN _precio			DECIMAL(7,2)
)
BEGIN
	IF _descripcion = '' THEN SET _descripcion = NULL;END IF;
	
	UPDATE cursos SET
		idprofesor 	= _idprofesor,
		idsede		= _idsede,
		titulo 		= _titulo,
		descripcion = _descripcion,
		fechainicio = _fechainicio,
		idcomplejidad = _idcomplejidad,
		precio		= _precio
	WHERE idcurso  = _idcurso;
END $$

CALL spu_cursos_actualizar(1,1,3,'Introdución al DISEÑO GRÁFICO','','2022/12/08',1,150);

-- cursos: buscar
DELIMITER $$
CREATE PROCEDURE spu_cursos_buscar
(
	IN _idcurso INT
)
BEGIN
	SELECT cursos.idcurso, personas.apellidos, personas.nombres, especialidades.especialidad, sedes.nombresede,
				cursos.titulo, cursos.descripcion, cursos.fechainicio, complejidades.complejidad, cursos.precio
	FROM cursos
	INNER JOIN complejidades ON cursos.idcomplejidad = complejidades.idcomplejidad
	INNER JOIN profesores ON cursos.idprofesor = profesores.idprofesor
	INNER JOIN especialidades ON profesores.idespecialidad = especialidades.idespecialidad
	INNER JOIN personas ON profesores.idpersona = personas.idpersona
	INNER JOIN sedes ON cursos.idsede = sedes.idsede
	WHERE cursos.estado = '1' AND cursos.idcurso = _idcurso;
END$$

CALL spu_cursos_buscar(1);

-- cursos: Eliminar
DELIMITER $$
CREATE PROCEDURE spu_cursos_eliminar
(
	IN _idcurso INT
)
BEGIN	
	UPDATE cursos SET
		estado = '0'
	WHERE idcurso = _idcurso;
END $$

CALL spu_cursos_eliminar(4);

DELIMITER $$
CREATE PROCEDURE spu_cursos_eliminar_activar
(
	IN _idcurso INT
)
BEGIN	
	UPDATE cursos SET
		estado = '1'
	WHERE idcurso = _idcurso;
END $$

CALL spu_cursos_eliminar_activar(4);

DELIMITER $$
CREATE PROCEDURE spu_cursos_obtenerdatos(IN _idcurso INT)
BEGIN
	SELECT idcurso, idprofesor, idsede, titulo, descripcion, fechainicio, complejidad, precio
	FROM cursos
	WHERE idcurso = _idcurso;
END $$

CALL spu_cursos_obtenerdatos(1);