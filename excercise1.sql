CREATE table presidente
(
presidente_dni int PRIMARY KEY,				-- agregar primary key de presidente 
nombre varchar(200),
apellidos varchar(200),
fecha_eleccion datetime,
fecha_nacimiento date
);

CREATE table equipo
(
equipo_codigo varchar(20) PRIMARY KEY,
nombre_equipo varchar(50),
equipo_local varchar(2),
equipo_visitante varchar(2),
nombre_estadio varchar(25),
cupo_max_estadio int,
cupo_min_estadio int,
ciudad_local varchar(50),
ciudad_visitante varchar(50),
equipo_presidente_dni int,	-- nombre de espacio para agregar el primary key de la tabla presidente, seria foreign key
FOREIGN KEY (equipo_presidente_dni) REFERENCES presidente (presidente_dni) 
);	-- FOREIGN KEY ("nombre del espacio creado para foreign key") REFERENCE "nombre de tabla en donde esta el primary-key" ("nombre de primary key")

CREATE table partido
(
partido_codigo varchar(20),
fecha_partido datetime,
partido_equipo_codigo varchar(20),
partido_equipo_local varchar(2),
partido_equipo_visitante varchar(2)
);

CREATE table gol
(
id_codigo_partido varchar(20),
id_codigo_jugador varchar(20),
minutos_jugados time,
descripcion varchar(100),
gol_numero int,

CONSTRAINT pk_gol PRIMARY KEY (id_codigo_partido, id_codigo_jugador)
);

CREATE table jugador
(
jugador_codigo varchar(8),
jugador_nombre varchar(50),
jugador_fecnac date,
jugador_posicion varchar(20)
);


/*	Ejemplo A
