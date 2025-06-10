-- CREACIÓN DE TABLAS PARA SISTEMA DE FÚTBOL
-- RODRIGO CASIO GARCIA
-- ============================================
-- 1. PRESIDENTE
-- Tabla de presidentes de equipos
-- ============================================
CREATE TABLE PRESIDENTE (
 dni CHAR(9) PRIMARY KEY, -- DNI del presidente (clave primaria)
 nombre VARCHAR(100) NOT NULL, -- Nombre del presidente
 apellidos VARCHAR(150) NOT NULL, -- Apellidos del presidente
 fecha_eleccion DATE NOT NULL, -- Fecha en que fue elegido
 fecha_nacimiento DATE NOT NULL -- Fecha de nacimiento del presidente
);
-- ============================================
-- 2. EQUIPO
-- Tabla de equipos de fútbol
-- ============================================
CREATE TABLE EQUIPO (
	 codigo_equipo INT PRIMARY KEY, -- Código único del equipo (clave primaria)
	 nombre VARCHAR(100) NOT NULL, -- Nombre del equipo
	 estadio VARCHAR(100) NOT NULL, -- Nombre del estadio
	 aforo INT NOT NULL, -- Capacidad del estadio
	 ciudad VARCHAR(100) NOT NULL, -- Ciudad del equipo
	 dni_presidente CHAR(9) UNIQUE, -- DNI del presidente (clave foránea única)

	CONSTRAINT FK_Equipo_Presidente
		FOREIGN KEY (dni_presidente) -- FK hacia PRESIDENTE
		REFERENCES PRESIDENTE(dni)
		ON DELETE SET NULL -- Si se elimina el presidente, se pone en NULL
		ON UPDATE CASCADE -- Si cambia el DNI, se actualiza en EQUIPO
);
-- ============================================
-- 3. PARTIDO
-- Tabla de partidos entre equipos
-- ============================================
CREATE TABLE PARTIDO (
    codigo_partido INT PRIMARY KEY,                -- Código del partido
    fecha DATE NOT NULL,                           -- Fecha del partido
    codigo_equipo_local INT NOT NULL,              -- Equipo local
    codigo_equipo_visitante INT NOT NULL,          -- Equipo visitante

    CONSTRAINT FK_Partido_EquipoLocal
        FOREIGN KEY (codigo_equipo_local)
        REFERENCES EQUIPO(codigo_equipo)
        ON DELETE CASCADE                          -- Elimina partidos si se borra el equipo local
        ON UPDATE CASCADE,

    CONSTRAINT FK_Partido_EquipoVisitante
        FOREIGN KEY (codigo_equipo_visitante)
        REFERENCES EQUIPO(codigo_equipo)
);

-- ============================================
-- 4. JUGADOR
-- Tabla de jugadores
-- ============================================
CREATE TABLE JUGADOR (
	 codigo_jugador INT PRIMARY KEY, -- Código único del jugador (clave primaria)
	 nombre VARCHAR(100) NOT NULL, -- Nombre del jugador
	 posicion VARCHAR(50) NOT NULL, -- Posición del jugador (ej: defensa, delantero)
	 fecha_nacimiento DATE NOT NULL -- Fecha de nacimiento del jugador
);
-- ============================================
-- 5. GOL
-- Tabla que representa los goles hechos por jugadores en partidos
-- Relación N:M entre PARTIDO y JUGADOR con atributos
-- ============================================
CREATE TABLE GOL (
	 codigo_partido INT NOT NULL, -- Código del partido (parte dela PK, FK)
	 codigo_jugador INT NOT NULL, -- Código del jugador (parte de la PK, FK)
	 minuto INT NOT NULL, -- Minuto en que se marcó el gol (parte de la PK)
	 descripcion VARCHAR(255), -- Descripción del gol (opcional)
	 CONSTRAINT PK_Gol PRIMARY KEY (codigo_partido, codigo_jugador, minuto), -- PK compuesta
	 CONSTRAINT FK_Gol_Partido
		 FOREIGN KEY (codigo_partido)
		 REFERENCES PARTIDO(codigo_partido)
		 ON DELETE CASCADE -- Si se borra el partido, se borran sus goles
		 ON UPDATE CASCADE,
	CONSTRAINT FK_Gol_Jugador
		 FOREIGN KEY (codigo_jugador)
		 REFERENCES JUGADOR(codigo_jugador)
		 ON DELETE CASCADE -- Si se borra el jugador, se borran sus goles
		 ON UPDATE CASCADE
);


-- ======== INSERT
-- INSERT TABALA PRESIDENTE
INSERT INTO PRESIDENTE (dni, nombre, apellidos, fecha_eleccion, fecha_nacimiento)
VALUES ('12345678A', 'Juan', 'Pérez Gómez', '2021-06-01', '1975-05-15');

INSERT INTO PRESIDENTE (dni, nombre , apellidos, fecha_eleccion, fecha_nacimiento)
VALUES ('23456789B', 'Ana', 'López Ruiz', '2020-01-15', '1968-09-23');

-- INSERT EQUIPOS (con FK a PRESIDENTE)}
INSERT INTO EQUIPO (codigo_equipo, nombre, estadio, aforo, ciudad, dni_presidente)
VALUES (1, 'Tigres FC', 'Estadio Norte', '25000', 'Monterrey', '12345678A');

INSERT INTO EQUIPO (codigo_equipo, nombre, estadio, aforo, ciudad, dni_presidente)
VALUES (2, 'Leones Sur', 'Estadio Sur', '18000', 'Guadalajara', '23456789B');

-- INSERT JUGADORES
INSERT INTO JUGADOR (codigo_jugador, nombre, posicion, fecha_nacimiento)
VALUES (10, 'Carlos Ruiz', 'Delantero', '1998-04-12');






-- ================================ UPDATE
-- UPDATES PARA TABLE EQUIPO
UPDATE EQUIPO
SET nombre = 'Tigres del Norte'
WHERE codigo_equipo = 1;
-- UPDATE ESTADIO
UPDATE EQUIPO
SET estadio = 'Estadio Central'
WHERE codigo_equipo = 2;
-- UPDATE CIUDAD DE UN EQUIPO
UPDATE EQUIPO
SET ciudad = 'Léon'
WHERE nombre = 'Leones Sur';
-- UPDATE APELLIDOS DEL PRESIDENTE
UPDATE PRESIDENTE
SET apellidos = 'Perez Mendoza'
WHERE dni = '12345678A';
-- UPDATE POSICION DE UN JUGADOR
UPDATE JUGADOR
SET posicion = 'Mediocampista'
WHERE codigo_jugador = 10;
-- =============================================== DELETE
-- delete table jugador (se eliminarán sus goles por CASCADE)
DELETE FROM JUGADOR
WHERE codigo_jugador = 10;
-- Eliminar un presidente (el dni_presidente en EQUIPO quedará en NULL por SET NULL)
DELETE FROM PRESIDENTE
WHERE dni = '23456789B';
-- Eliminar un equipo (también se eliminarán los partidos donde era local o visitante)
DELETE FROM EQUIPO
WHERE codigo_equipo = 1;
-- Eliminar un partido (también se eliminan goles asociados)
DELETE FROM PARTIDO
WHERE codigo_partido = 100;
-- Eliminar todos los goles de un partido directamente
DELETE FROM GOL
WHERE codigo_partido = 100;
-- ========================================================== INSERT
-----¿Cómo funcionan los delete CASCADE?
-- Insert table partido--------
INSERT INTO PARTIDO (codigo_partido, fecha, codigo_equipo_local,
codigo_equipo_visitante)
VALUES (100, '2024-03-15', 1, 2);
-- Insertar jugador
INSERT INTO JUGADOR (codigo_jugador, nombre, posicion, fecha_nacimiento)
VALUES (20, 'Luis Gómez', 'Defensa', '1995-11-22');
-- Insertar goles
INSERT INTO GOL (codigo_partido, codigo_jugador, minuto, descripcion)
VALUES (100, 20, 55, 'Gol de cabeza');
----delete
DELETE FROM PARTIDO WHERE codigo_partido = 100;
DELETE FROM JUGADOR WHERE codigo_jugador = 20;
-- ===================================== SELECT
-- SENTENCIAS SELECT
-- Ver todos los quipos con sus presidentes.
SELECT E.codigo_equipo, E.nombre AS equipo, P.nombre AS presidente, P.dni
FROM EQUIPO E, PRESIDENTE P
WHERE E.dni_presidente = P.dni;
----Listar todos los jugadores con su posición y edad aproximada
SELECT codigo_jugador, nombre, posicion,
 DATEDIFF(YEAR, fecha_nacimiento, GETDATE()) AS edad
FROM JUGADOR;
------Ver partidos con nombres de los equipos local y visitante
SELECT P.codigo_partido, P.fecha, EL.nombre AS equipo_local, EV.nombre AS
equipo_visitante
FROM PARTIDO P, EQUIPO EL, EQUIPO EV
WHERE P.codigo_equipo_local = EL.codigo_equipo
 AND P.codigo_equipo_visitante = EV.codigo_equipo;
-----Ver los goles con minuto y descripción
SELECT G.codigo_partido, G.codigo_jugador, G.minuto, G.descripcion
FROM GOL G;
-----Mostrar jugadores que hayan anotado goles
SELECT DISTINCT J.codigo_jugador, J.nombre
FROM JUGADOR J, GOL G
WHERE J.codigo_jugador = G.codigo_jugador;
