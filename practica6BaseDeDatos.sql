-- PRACTICA #6 PARTE #2
-- Realizar lo siguiente en tu entorno local (SQL Server)

-- 1. CREAR UNA BASE DE DATOS (Ésta se debe llamar como tú)
CREATE DATABASE RodrigoCasio;
GO

-- 2. ACTIVAR EL MODELO DE RECUPERACÍON FULL.
ALTER DATABASE RodrigoCasio SET RECOVERY FULL;
GO -- cambia el modelo de recuperación para permitir que todas las transacciones sean registradas en el log, es fundamental
-- para la recuperación a un punto en el tiempo.


-- 3. VERIFICAR QUE EL MODELO DE RECUPERACIÓN FULL
SELECT name, recovery_model_desc
FROM sys.databases
WHERE name = 'RodrigoCasio';
GO -- verificar que el cambio se haya aplicado correctamente.


-- 4. REALIZAR UN BACKUP COMPLETO DE LA BASE DE DATOS 'RodrigoCasio'
BACKUP DATABASE RodrigoCasio -- especifica la base de datos a respaldar
TO DISK = 'C:\BackupSQL\RodrigoCasio_FullBackup.bak' -- define la ubicación y el nombre del archivo de backup.
WITH INIT; -- asegura que si ya existe un archico de backúp, con el mismo nombre, este sea sobreescrito.
GO


-- MOMENTO DE UTILIZAR LA BASE DE DATOS DE 'RodrigoCasio'
USE RodrigoCasio;
GO

-- 5. CREAR TABLA DE EJEMPLO
CREATE TABLE DatosPersonales(
    ID INT PRIMARY KEY INDENTITY(1,1),
    Nombre VARCHAR(100),
    Apellido VARCHAR(100),
    Ciudad VARCHAR(100)
);
GO


-- 5.1 INSERTAR DATOS DENTRO DE LA TABLA 'DatosPersonales'
INSERT INTO DatosPersonales(Nombre, Apellido, Ciudad)
VALUES ('Rodrigo', 'Casio', 'Guadalajara'),
       ('Rocio Del Carmen', 'Garcia', 'Durango'),
       ('Andrea', 'Casio', 'Guadalajara'):
GO

--  5.2 ACTUALIZAR DATOS
UPDATE DatosPersonales
SET Ciudad = 'Ciudad de Mexico'
WHERE Nombre = 'Andrea':
GO

-- 5.3 INSERTAR UN NUEVO DATO
INSERT INTO DatosPersonales (Nombre, Apellido,, Ciudad)
VALUES ('Sandra', 'Saucedo', 'Guadalajara');
GO

-- 5.4 CONSULTAR EL ESTADO DE LOS DATOS ACTUALES
SELECT * FROM DatosPersonales;
GO

-- 6. REALIZAR UN BACKUP DEL LOG DE TRANSACCIONES
BACKUP LOG RodrigoCasio
TO DISK = 'C:\BackupSQL\RodrigoCasio_LogBackup1.trn'
WITH INIT;
GO

-- 7. ELIMINAR LA BASE DE DATOS ACCIDENTALMENTE ( simulacion de fallo )
USE master;     -- necesario para eliminar la base de datos 'master' para poder eliminar RodrigoCasio
GO
DROP DATABASE RodrigoCasio;     -- eliminara la base de datos por completo 
GO 

-- 8. RESTAURAR LA BASE DE DATOS 

-- 8.1 restaurar el backup completo con NORECOVERY
-- esto deja la base de datos en esta de 'restaurado', lista para aplicar logs.
RESTORE DATABASE RodrigoCasio
FROM DISK = 'C:\BackupSQL\RodrigoCasio_FullBackup.bak'
WITH NORECOVERY, REPLACE;
GO

-- 8.2
-- Luego, resturar el backup del log de transacciones con RECOVERY
-- ESTO aplica las transacciones del log y pone la base de datos en linea, accessible.
RESTORE LOG RodrigoCasio
FROM DISK = 'C:\BackupSQL\RodrigoCasio_LogBackup1.trn'
WITH RECOVERY;
GO

-- Finalmente 8.3 Verificar que la base de datos este en linea y los datos recuperados
USE RodrigoCasio;
GO

SELECT * FROM DatosPersonales;      -- Output de los datos de DatosPersonales.
GO