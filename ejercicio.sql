-- no completo

CREATE DATABASE UNIVA2;

CREATE TABLE cliente (
	id_codigo_cliente INT PRIMARY KEY NOT NULL,
	RFC NVARCHAR(16) NOT NULL,
	nombre_cliente NVARCHAR(50) NOT NULL,
	direccion_cliente NVARCHAR(100) NOT NULL,
	telefono_cliente NVARCHAR(100) NOT NULL,
	ciudad_cliente_nac NVARCHAR(50) NOT NULL,
	ciudad_cliente_res NVARCHAR(50) NOT NULL
);

CREATE TABLE coche (
	id_coche_matricula NVARCHAR(9) PRIMARY KEY NOT NULL,
	coche_codigo_cliente INT NOT NULL,
	marca_coche NVARCHAR(50) NOT NULL,
	color_color NVARCHAR(50) NOT NULL,
	modelo_coche NVARCHAR(50) NOT NULL,

	FOREIGN KEY (coche_codigo_cliente) REFERENCES cliente (id_codigo_cliente)
);

CREATE TABLE revision(
	id_cod_revision INT PRIMARY KEY NOT NULL,
	revision_coche_matricula NVARCHAR(9) NOT NULL,
	fecha_revision DATE NOT NULL,

	FOREIGN KEY (revision_coche_matricula) REFERENCES coche (id_coche_matricula)
);

CREATE TABLE revision_operacion (
	codigo_revision NVARCHAR(10) NOT NULL,
	codigo_operacion INT NOT NULL,
	
);

--¨hacer operacion primero,
