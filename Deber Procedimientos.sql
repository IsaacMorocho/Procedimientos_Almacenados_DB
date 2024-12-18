CREATE TABLE cliente (
    ClienteID INTEGER PRIMARY KEY AUTOINCREMENT,  -- Campo para el ID único del cliente
    Nombre VARCHAR(100),                      -- Campo para el nombre del cliente
    Estatura DECIMAL(5,2),                    -- Campo para la estatura del cliente con dos decimales
    FechaNacimiento DATE,                     -- Campo para la fecha de nacimiento del cliente
    Sueldo DECIMAL(10,2)                      -- Campo para el sueldo del cliente con dos decimales
);
INSERT INTO cliente (Nombre, Estatura, FechaNacimiento, Sueldo)
VALUES 
    ('Juan Pérez', 1.75, '1990-05-10', 2500.50),
    ('María Gómez', 1.60, '1985-11-25', 3000.75),
    ('Luis Rodríguez', 1.80, '1992-08-15', 2800.00),
    ('Ana Fernández', 1.68, '1988-03-30', 3200.20),
    ('Carlos Martínez', 1.90, '1995-12-05', 2600.00);
SELECT * FROM cliente;
SELECT Nombre, Sueldo FROM cliente WHERE Sueldo>3000;	
-- SQLite nl admite procedimientos almacenados por ellos solo se mostrara el script
DELIMITER $$
-- Creamos el procedimiento
CREATE PROCEDURE InsertarCliente (
    IN p_Nombre VARCHAR(100),
    IN p_Estatura DECIMAL(5,2),
    IN p_FechaNacimiento DATE,
    IN p_Sueldo DECIMAL(10,2)
)
BEGIN
    INSERT INTO cliente (Nombre, Estatura, FechaNacimiento, Sueldo)
    VALUES (p_Nombre, p_Estatura, p_FechaNacimiento, p_Sueldo);
END$$
DELIMITER ;
-- Llamar al procedimiento
CALL InsertarCliente('Pedro López', 1.72, '1990-07-15', 2700.00);

-- Actualizar la edad de un cliente por su id
DELIMITER $$
CREATE PROCEDURE ActualizarEdad(
    IN p_ClienteID INT,
    IN p_NEdad TINYINT
)
BEGIN
    UPDATE cliente
    SET Edad = p_NEdad
    WHERE ClienteID = p_ClienteID;
END$$
DELIMITER ;

CALL ActualizarEdad(1, 35);

-- Eliminar el cliente por su ID
DELIMITER $$
CREATE PROCEDURE EliminarCliente (
    IN p_ClienteID INT
)
BEGIN
    DELETE FROM cliente
    WHERE ClienteID = p_ClienteID;
END$$
DELIMITER ;

-- Condicional IF
DELIMITER $$

CREATE PROCEDURE VerificarEdadCliente (
    IN p_ClienteID INT
)
BEGIN
    DECLARE edad_cliente INT;
    SELECT Edad INTO edad_cliente
    FROM cliente
    WHERE ClienteID=p_ClienteID;
    IF edad_cliente>=22 THEN
        SELECT CONCAT('Cliente ID ', p_ClienteID, ' tiene una edad mayor o igual a 22: ', edad_cliente) AS Resultado;
    ELSE
        SELECT CONCAT('Cliente ID ', p_ClienteID, ' tiene una edad menor a 22: ', edad_cliente) AS Resultado;
    END IF;
END$$
DELIMITER ;

CREATE TABLE ordenes (
    OrdenID INTEGER PRIMARY KEY AUTOINCREMENT,  
    Peticion VARCHAR(255) NOT NULL,          
    ClienteID INTEGER,             
    FOREIGN KEY (ClienteID) REFERENCES cliente(ClienteID) 
);
INSERT INTO ordenes (Peticion, ClienteID)
VALUES 
    ('Compra de producto', 1),
    ('Consulta', 2),
    ('Devolución ', 3),
    ('Garantía', 4),
    ('Pedido', 5);
	
-- Insertar Orden
DELIMITER $$
CREATE PROCEDURE InsertarOrden (
    IN p_Peticion VARCHAR(255),
    IN p_ClienteID INT    
)
BEGIN
    INSERT INTO ordenes (Peticion, ClienteID)
    VALUES (p_Peticion, p_ClienteID);
END$$
DELIMITER ;
CALL InsertarOrden('Entrega de mercsncia', 1);

-- Actualizar Orden
DELIMITER $$
CREATE PROCEDURE ActualizarOrden(
    IN p_OrdenID INT,
    IN p_NuevaPeticion VARCHAR(255),
    IN p_NuevoClienteID INT
)
BEGIN
    UPDATE ordenes
    SET Peticion = p_NuevaPeticion,
        ClienteID = p_NuevoClienteID
    WHERE OrdenID = p_OrdenID;
END$$
DELIMITER ;
CALL ActualizarOrden(1, 'Devoluxcion de dinero', 2);

-- Eliminar orden por su id
DELIMITER $$
CREATE PROCEDURE EliminarOrden(
    IN p_OrdenID INT
)
BEGIN
    DELETE FROM ordenes
    WHERE OrdenID = p_OrdenID;
END$$
DELIMITER ;
CALL EliminarOrden(4);




