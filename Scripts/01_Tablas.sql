--Usuario
CREATE USER AdminDB IDENTIFIED BY AdminDB;
GRANT DBA TO AdminDB;


-- Tablas de direcciones
CREATE TABLE AdminDB.FIDE_PROVINCIA_TB (
    PROVINCIA_ID NUMBER CONSTRAINT FIDE_PROVINCIA_TB_PROVINCIA_ID_PK PRIMARY KEY,
    NOMBRE VARCHAR2(100) NOT NULL
);

CREATE TABLE AdminDB.FIDE_CANTON_TB (
    CANTON_ID NUMBER CONSTRAINT FIDE_PROVINCIA_TB_CANTON_ID_PK PRIMARY KEY,
    NOMBRE VARCHAR2(100) NOT NULL
);

CREATE TABLE AdminDB.FIDE_DISTRITO_TB (
    DISTRITO_ID NUMBER CONSTRAINT FIDE_DISTRITO_TB_DISTRITO_ID_PK PRIMARY KEY,
    NOMBRE VARCHAR2(100) NOT NULL
);

CREATE TABLE AdminDB.FIDE_DIRECCION_TB (
    DIRECCION_ID NUMBER CONSTRAINT FIDE_DIRECCION_TB_DIRECCION_ID_PK PRIMARY KEY,
    SENAS VARCHAR2(250) NOT NULL,
    PROVINCIA_ID NUMBER NOT NULL,
    DISTRITO_ID NUMBER NOT NULL,
    CANTON_ID NUMBER NOT NULL,
    
    -- Claves for�neas
    CONSTRAINT FIDE_DIRECCION_TB_PROVINCIA_ID_FK
        FOREIGN KEY (PROVINCIA_ID)
        REFERENCES FIDE_PROVINCIA_TB (PROVINCIA_ID),
        
    CONSTRAINT FIDE_DIRECCION_TB_DISTRITO_ID_FK
        FOREIGN KEY (DISTRITO_ID)
        REFERENCES FIDE_DISTRITO_TB (DISTRITO_ID),
        
    CONSTRAINT FIDE_CANTON_TB_CANTON_ID_FK
        FOREIGN KEY (CANTON_ID)
        REFERENCES FIDE_CANTON_TB (CANTON_ID) 
);


-- Otras Tablas
CREATE TABLE AdminDB.FIDE_ESTADO_TB (
    ESTADO_ID NUMBER CONSTRAINT FIDE_ESTADO_TB_ESTADO_ID_PK PRIMARY KEY,
    NOMBRE VARCHAR2(100) NOT NULL
);


-- Tablas del m�dulo de usuarios

CREATE TABLE AdminDB.FIDE_ROL_TB (
    ROL_ID NUMBER CONSTRAINT FIDE_ROL_TB_ROL_ID_PK PRIMARY KEY,
    NOMBRE VARCHAR2(100) NOT NULL
);

CREATE TABLE AdminDB.FIDE_USUARIO_TB (
    USUARIO_ID NUMBER CONSTRAINT FIDE_USUARIOS_TB_USUARIO_ID_PK PRIMARY KEY,
    NOMBRE VARCHAR2(100) NOT NULL,
    APELLIDO VARCHAR2(100) NOT NULL,
    CORREO VARCHAR2(100) CONSTRAINT FIDE_USUARIOS_TB_EMAIL_UNIQUE_IDX UNIQUE,
    CONTRASE�A VARCHAR2(100) CONSTRAINT FIDE_USUARIOS_TB_CONTRASE�A_NOT_NULL_IDX NOT NULL,
    DIRECCION_ID NUMBER NOT NULL,
    ROL_ID NUMBER NOT NULL,
    ESTADO_ID NUMBER NOT NULL,
    
    -- Claves for�neas
    CONSTRAINT FIDE_USUARIOS_TB_ESTADO_ID_FK
        FOREIGN KEY (ESTADO_ID)
        REFERENCES FIDE_ESTADO_TB (ESTADO_ID),
    
    CONSTRAINT FIDE_USUARIOS_TB_ROL_ID_FK
        FOREIGN KEY (ROL_ID)
        REFERENCES FIDE_ROL_TB (ROL_ID),
    
    CONSTRAINT FIDE_USUARIOS_TB_DIRECCION_ID_FK
        FOREIGN KEY (DIRECCION_ID)
        REFERENCES FIDE_DIRECCION_TB (DIRECCION_ID)
);

-- Tablas del m�dulo de productos

CREATE TABLE AdminDB.FIDE_CATEGORIA_TB (
    CATEGORIA_ID NUMBER CONSTRAINT FIDE_CATEGORIA_TB_CATEGORIA_ID_PK PRIMARY KEY,
    NOMBRE VARCHAR2(100) NOT NULL
);

CREATE TABLE AdminDB.FIDE_PRODUCTO_TB (
    PRODUCTO_ID NUMBER CONSTRAINT FIDE_PRODUCTO_TB_PRODUCTO_ID_PK PRIMARY KEY,
    NOMBRE VARCHAR2(100) NOT NULL,
    DESCRIPCION VARCHAR2(250),
    IMAGEN VARCHAR2(250),
    PRECIO_UNIT NUMBER NOT NULL,
    CATEGORIA_ID NUMBER NOT NULL,
    
    -- Claves f�raneas
     CONSTRAINT FIDE_PRODUCTO_TB_CATEGORIA_ID_FK
        FOREIGN KEY (CATEGORIA_ID)
        REFERENCES FIDE_CATEGORIA_TB (CATEGORIA_ID)
);


CREATE TABLE AdminDB.FIDE_INVENTARIO_TB (
    INVENTARIO_ID NUMBER CONSTRAINT FIDE_INVENTARIO_TB_INVENTARIO_ID_PK PRIMARY KEY,
    STOCK NUMBER NOT NULL,
    FECHA_VENCIMIENTO DATE,
    DIAS_EN_STOCK NUMBER, 
    PRECIO_UNIT DECIMAL(10, 2) NOT NULL,
    ESTADO_ID NUMBER NOT NULL,
    PRODUCTO_ID NUMBER NOT NULL,
    
    -- Claves f�raneas
     CONSTRAINT FIDE_INVENTARIO_TB_ESTADO_ID_FK
        FOREIGN KEY (ESTADO_ID)
        REFERENCES FIDE_ESTADO_TB (ESTADO_ID),
        
     CONSTRAINT FIDE_INVENTARIO_TB_PRODUCTO_ID_FK
        FOREIGN KEY (PRODUCTO_ID)
        REFERENCES FIDE_PRODUCTO_TB (PRODUCTO_ID)
);

-- Tablas del m�dulo de cursos

CREATE TABLE AdminDB.FIDE_TIPO_CURSO_TB (
    TIPO_CURSO_ID NUMBER CONSTRAINT FIDE_TIPO_CURSO_TB_TIPO_CURSO_ID_PK PRIMARY KEY,
    NOMBRE VARCHAR2(100) NOT NULL
);

CREATE TABLE AdminDB.FIDE_CURSO_TB (
    CURSO_ID NUMBER CONSTRAINT FIDE_CURSO_TB_CURSO_ID_PK PRIMARY KEY,
    NOMBRE VARCHAR2(100) NOT NULL,
    DESCRIPCION VARCHAR2(250),
    FECHA DATE NOT NULL,
    HORA VARCHAR2(10),  
    IMAGEN VARCHAR2(250),
    PRECIO DECIMAL(10, 2) NOT NULL,
    CAPACIDAD NUMBER NOT NULL,
    TIPO_CURSO_ID NUMBER,  
    ESTADO_ID NUMBER,
    DIRECCION_ID NUMBER,
    
    -- Claves f�raneas
     CONSTRAINT FIDE_CURSO_TB_TIPO_CURSO_ID_FK
        FOREIGN KEY (TIPO_CURSO_ID)
        REFERENCES FIDE_TIPO_CURSO_TB (TIPO_CURSO_ID),
        
     CONSTRAINT FIDE_CURSO_TB_ESTADO_ID_FK
        FOREIGN KEY (ESTADO_ID)
        REFERENCES FIDE_ESTADO_TB (ESTADO_ID),
        
     CONSTRAINT FIDE_CURSO_TB_DIRECCION_ID_FK
        FOREIGN KEY (DIRECCION_ID)
        REFERENCES FIDE_DIRECCION_TB (DIRECCION_ID)
);

-- Tablas del m�dulo de servicios

CREATE TABLE AdminDB.FIDE_SERVICIO_TB (
    SERVICIO_ID NUMBER CONSTRAINT FIDE_SERVICIO_TB_SERVICIO_ID_PK PRIMARY KEY,
    NOMBRE VARCHAR2(100) NOT NULL,
    DESCRIPCION VARCHAR2(250),
    IMAGEN VARCHAR2(250)
);

CREATE TABLE AdminDB.FIDE_EVENTO_TB (
    EVENTO_ID NUMBER CONSTRAINT FIDE_EVENTO_TB_EVENTO_ID_PK PRIMARY KEY,
    USUARIO_ID NUMBER NOT NULL,
    SERVICIO_ID NUMBER NOT NULL,
    DIRECCION_ID NUMBER NOT NULL,
    ESTADO_ID NUMBER NOT NULL,
    FECHA DATE,
    
    -- Claves f�raneas
    CONSTRAINT FIDE_EVENTO_TB_USUARIO_ID_FK
        FOREIGN KEY (USUARIO_ID)
        REFERENCES FIDE_USUARIO_TB (USUARIO_ID),
        
    CONSTRAINT FIDE_EVENTO_TB_SERVICIO_ID_FK
        FOREIGN KEY (SERVICIO_ID)
        REFERENCES FIDE_SERVICIO_TB (SERVICIO_ID),
        
    CONSTRAINT FIDE_EVENTO_TB_DIRECCION_ID_FK
        FOREIGN KEY (DIRECCION_ID)
        REFERENCES FIDE_DIRECCION_TB (DIRECCION_ID),
        
    CONSTRAINT FIDE_EVENTO_TB_ESTADO_ID_FK
        FOREIGN KEY (ESTADO_ID)
        REFERENCES FIDE_ESTADO_TB (ESTADO_ID)
);


CREATE TABLE AdminDB.FIDE_CITA_TB (
    CITA_ID NUMBER CONSTRAINT FIDE_CITA_TB_CITA_ID_PK PRIMARY KEY,
    USUARIO_ID NUMBER NOT NULL,
    SERVICIO_ID NUMBER NOT NULL,
    ESTADO_ID NUMBER NOT NULL,
    FECHA DATE,
    HORA VARCHAR2(10),
    
      -- Claves f�raneas
    CONSTRAINT FIDE_CITA_TB_USUARIO_ID_FK
        FOREIGN KEY (USUARIO_ID)
        REFERENCES FIDE_USUARIO_TB (USUARIO_ID),
        
    CONSTRAINT FIDE_CITA_TB_SERVICIO_ID_FK
        FOREIGN KEY (SERVICIO_ID)
        REFERENCES FIDE_SERVICIO_TB (SERVICIO_ID),
        
    CONSTRAINT FIDE_CITA_TB_ESTADO_ID_FK
        FOREIGN KEY (ESTADO_ID)
        REFERENCES FIDE_ESTADO_TB (ESTADO_ID)
);
    

-- Tablas del m�dulo de compras
CREATE TABLE AdminDB.FIDE_METODO_PAGO_TB (
    METODO_PAGO_ID NUMBER CONSTRAINT FIDE_METODO_PAGO_TB_METODO_PAGO_ID_PK PRIMARY KEY,
    NOMBRE VARCHAR2(100) NOT NULL
);

CREATE TABLE AdminDB.FIDE_DESCUENTO_TB (
    DESCUENTO_ID NUMBER CONSTRAINT FIDE_DESCUENTO_TB_DESCUENTO_ID_PK PRIMARY KEY,
    NOMBRE VARCHAR2(100) NOT NULL,
    PORCENTAJE DECIMAL(10, 2) NOT NULL
);

CREATE TABLE AdminDB.FIDE_TIPO_COMPRA_TB (
    TIPO_COMPRA_ID NUMBER CONSTRAINT FIDE_TIPO_COMPRA_TB_TIPO_COMPRA_ID_PK PRIMARY KEY,
    PRODUCTO_ID NUMBER NOT NULL,
    CURSO_ID NUMBER NOT NULL,
    SERVICIO_ID NUMBER NOT NULL,
    
     -- Claves f�raneas
     CONSTRAINT FIDE_TIPO_COMPRA_TB_PRODUCTO_ID_FK
        FOREIGN KEY (PRODUCTO_ID)
        REFERENCES FIDE_PRODUCTO_TB (PRODUCTO_ID),
        
     CONSTRAINT FIDE_TIPO_COMPRA_TB_CURSO_ID_FK
        FOREIGN KEY (CURSO_ID)
        REFERENCES FIDE_CURSO_TB (CURSO_ID),
        
    CONSTRAINT FIDE_TIPO_COMPRA_TB_SERVICIO_ID_FK
        FOREIGN KEY (SERVICIO_ID)
        REFERENCES FIDE_SERVICIO_TB (SERVICIO_ID)
);

CREATE TABLE AdminDB.FIDE_DETALLE_FACTURA_TB (
    DETALLE_FACTURA_ID NUMBER CONSTRAINT FIDE_DETALLE_FACTURA_TB_DETALLE_FACTURA_ID_PK PRIMARY KEY,
    CANTIDAD_LINEAS NUMBER NOT NULL,
    TOTAL_POR_LINEA NUMBER NOT NULL,
    TIPO_COMPRA_ID NUMBER NOT NULL,
    
    -- Claves f�raneas
     CONSTRAINT FIDE_DETALLE_FACTURA_TB_TIPO_COMPRA_ID_FK
        FOREIGN KEY (TIPO_COMPRA_ID)
        REFERENCES FIDE_TIPO_COMPRA_TB (TIPO_COMPRA_ID)
);
    

CREATE TABLE AdminDB.FIDE_FACTURA_TB (
    FACTURA_ID NUMBER CONSTRAINT FIDE_FACTURA_TB_FACTURA_ID_PK PRIMARY KEY,
    USUARIO_ID NUMBER NOT NULL,
    FECHA DATE NOT NULL,
    DETALLE_FACTURA_ID NUMBER NOT NULL, 
    CANTIDAD_LINEAS NUMBER NOT NULL,     
    DESCUENTO_ID NUMBER,                  
    IVA DECIMAL(10, 2) NOT NULL,           
    SUBTOTAL DECIMAL(10, 2) NOT NULL,     
    MONTO_TOTAL DECIMAL(10, 2) NOT NULL,   
    METODO_PAGO_ID NUMBER NOT NULL,
    
    -- Claves f�raneas
     CONSTRAINT FIDE_FACTURA_TB_DETALLE_FACTURA_ID_FK
        FOREIGN KEY (DETALLE_FACTURA_ID)
        REFERENCES FIDE_DETALLE_FACTURA_TB (DETALLE_FACTURA_ID),
        
     CONSTRAINT FIDE_FACTURA_TB_USUARIO_ID_FK
        FOREIGN KEY (USUARIO_ID)
        REFERENCES FIDE_USUARIO_TB (USUARIO_ID),
        
     CONSTRAINT FIDE_FACTURA_TB_METODO_PAGO_ID_FK
        FOREIGN KEY (METODO_PAGO_ID)
        REFERENCES FIDE_METODO_PAGO_TB (METODO_PAGO_ID),
        
     CONSTRAINT FIDE_FACTURA_TB_DESCUENTO_ID_FK
        FOREIGN KEY (DESCUENTO_ID)
        REFERENCES FIDE_DESCUENTO_TB (DESCUENTO_ID)   
);

---------------------------------------------------------------------------------------------------------------------------------------------------
--Inserts para comrpobar las vistas 
--Tablas de direccion 
--FIDE_PROVINCIA_TB
INSERT INTO AdminDB.FIDE_PROVINCIA_TB (PROVINCIA_ID, NOMBRE) 
VALUES (1, 'San Jos�');
INSERT INTO AdminDB.FIDE_PROVINCIA_TB (PROVINCIA_ID, NOMBRE) 
VALUES (2, 'Alajuela');

--FIDE_CANTON_TB
INSERT INTO AdminDB.FIDE_CANTON_TB (CANTON_ID, NOMBRE) 
VALUES (1, 'Central');
INSERT INTO AdminDB.FIDE_CANTON_TB (CANTON_ID, NOMBRE) 
VALUES (2, 'Alajuela');

--FIDE_DISTRITO_TB
INSERT INTO AdminDB.FIDE_DISTRITO_TB (DISTRITO_ID, NOMBRE) 
VALUES (1, 'La Uruca');
INSERT INTO AdminDB.FIDE_DISTRITO_TB (DISTRITO_ID, NOMBRE) 
VALUES (2, 'Alajuela Centro');

--FIDE_DIRECCION_TB
INSERT INTO AdminDB.FIDE_DIRECCION_TB (DIRECCION_ID, SE�AS, PROVINCIA_ID, DISTRITO_ID, CANTON_ID)
VALUES (1, 'Avenida Central, 100 metros este del parque', 1, 1, 1);
INSERT INTO AdminDB.FIDE_DIRECCION_TB (DIRECCION_ID, SE�AS, PROVINCIA_ID, DISTRITO_ID, CANTON_ID)
VALUES (2, 'Calle 5, Edificio X, al lado de la iglesia', 2, 2, 2);

--Tablas de estado
INSERT INTO AdminDB.FIDE_ESTADO_TB (ESTADO_ID, NOMBRE) 
VALUES (1, 'Activo');
INSERT INTO AdminDB.FIDE_ESTADO_TB (ESTADO_ID, NOMBRE) 
VALUES (2, 'Inactivo');

--Tablas de usuarios 
--FIDE_ROL_TB
INSERT INTO AdminDB.FIDE_ROL_TB (ROL_ID, NOMBRE) 
VALUES (1, 'Administrador');
INSERT INTO AdminDB.FIDE_ROL_TB (ROL_ID, NOMBRE) 
VALUES (2, 'Usuario');

--FIDE_USUARIO_TB
INSERT INTO AdminDB.FIDE_USUARIO_TB (USUARIO_ID, NOMBRE, APELLIDO, CORREO, CONTRASE�A, DIRECCION_ID, ROL_ID, ESTADO_ID) 
VALUES (1, 'Juan', 'P�rez', 'juan.perez@email.com', 'contrase�a123', 1, 1, 1);

INSERT INTO AdminDB.FIDE_USUARIO_TB (USUARIO_ID, NOMBRE, APELLIDO, CORREO, CONTRASE�A, DIRECCION_ID, ROL_ID, ESTADO_ID) 
VALUES (2, 'Mar�a', 'Gonz�lez', 'maria.gonzalez@email.com', 'contrase�a456', 2, 2, 1);

--Tablas de producto
--FIDE_CATEGORIA_TB
INSERT INTO AdminDB.FIDE_CATEGORIA_TB (CATEGORIA_ID, NOMBRE) 
VALUES (1, 'Botanica');
INSERT INTO AdminDB.FIDE_CATEGORIA_TB (CATEGORIA_ID, NOMBRE) 
VALUES (2, 'Decoraciones');

--FIDE_PRODUCTO_TB
INSERT INTO AdminDB.FIDE_PRODUCTO_TB (PRODUCTO_ID, NOMBRE, DESCRIPCION, IMAGEN, PRECIO_UNIT, CATEGORIA_ID) 
VALUES (1, 'Laureles', 'Laureles de color morados peque�os', 'laurel.jpg', 4.500, 1);

INSERT INTO AdminDB.FIDE_PRODUCTO_TB (PRODUCTO_ID, NOMBRE, DESCRIPCION, IMAGEN, PRECIO_UNIT, CATEGORIA_ID) 
VALUES (2, 'Cactus', 'Cactus con maceta decorativa', 'cactus.jpg', 6.200, 2);

--FIDE_INVENTARIO_TB
INSERT INTO AdminDB.FIDE_INVENTARIO_TB (INVENTARIO_ID, STOCK, FECHA_VENCIMIENTO, DIAS_EN_STOCK, PRECIO_UNIT, ESTADO_ID, PRODUCTO_ID) 
VALUES (1, 50, TO_DATE('2025-12-31', 'YYYY-MM-DD'), 30, 4.500, 1, 1);

INSERT INTO AdminDB.FIDE_INVENTARIO_TB (INVENTARIO_ID, STOCK, FECHA_VENCIMIENTO, DIAS_EN_STOCK, PRECIO_UNIT, ESTADO_ID, PRODUCTO_ID) 
VALUES (2, 200, TO_DATE('2026-01-31', 'YYYY-MM-DD'), 10, 6.200, 1, 2);

--Tablas de curso
--FIDE_TIPO_CURSO_TB
INSERT INTO AdminDB.FIDE_TIPO_CURSO_TB (TIPO_CURSO_ID, NOMBRE) 
VALUES (1, 'Botanica Avanzada');
INSERT INTO AdminDB.FIDE_TIPO_CURSO_TB (TIPO_CURSO_ID, NOMBRE) 
VALUES (2, 'Decoracion Navide�a');

--FIDE_CURSO_TB
INSERT INTO AdminDB.FIDE_CURSO_TB (CURSO_ID, NOMBRE, DESCRIPCION, FECHA, HORA, IMAGEN, PRECIO, CAPACIDAD, TIPO_CURSO_ID, ESTADO_ID, DIRECCION_ID) 
VALUES (1, 'Botanica Avanzada', 'Como decorar un espacio a base de la botanica III', TO_DATE('2025-01-15', 'YYYY-MM-DD'), '10:00', 'botanicaavanzada.jpg', 150.00, 30, 1, 1, 1);

INSERT INTO AdminDB.FIDE_CURSO_TB (CURSO_ID, NOMBRE, DESCRIPCION, FECHA, HORA, IMAGEN, PRECIO, CAPACIDAD, TIPO_CURSO_ID, ESTADO_ID, DIRECCION_ID) 
VALUES (2, 'Decoracion Navide�a', 'Implementar las plantas en nuestra navidad', TO_DATE('2025-02-10', 'YYYY-MM-DD'), '14:00', 'decoracionnavide�a.jpg', 120.00, 25, 2, 1, 2);


--Tablas de servicio
--FIDE_SERVICIO_TB
INSERT INTO AdminDB.FIDE_SERVICIO_TB (SERVICIO_ID, NOMBRE, DESCRIPCION, IMAGEN) 
VALUES (1, 'Presencial', 'Clases presenciales de botanica avanzada', 'curso_presencial.jpg');
INSERT INTO AdminDB.FIDE_SERVICIO_TB (SERVICIO_ID, NOMBRE, DESCRIPCION, IMAGEN) 
VALUES (2, 'Online', 'Cursos navide�os', 'cursos_online.jpg');

--FIDE_EVENTO_TB
INSERT INTO AdminDB.FIDE_EVENTO_TB (EVENTO_ID, USUARIO_ID, SERVICIO_ID, DIRECCION_ID, ESTADO_ID, FECHA) 
VALUES (1, 1, 2, 1, 1, TO_DATE('2025-01-20', 'YYYY-MM-DD'));
INSERT INTO AdminDB.FIDE_EVENTO_TB (EVENTO_ID, USUARIO_ID, SERVICIO_ID, DIRECCION_ID, ESTADO_ID, FECHA) 
VALUES (2, 2, 1, 2, 2, TO_DATE('2025-02-15', 'YYYY-MM-DD'));

--FIDE_CITA_TB
INSERT INTO AdminDB.FIDE_CITA_TB (CITA_ID, USUARIO_ID, SERVICIO_ID, ESTADO_ID, FECHA, HORA) 
VALUES (1, 1, 2, 1, TO_DATE('2025-01-18', 'YYYY-MM-DD'), '14:00');
INSERT INTO AdminDB.FIDE_CITA_TB (CITA_ID, USUARIO_ID, SERVICIO_ID, ESTADO_ID, FECHA, HORA) 
VALUES (2, 2, 1, 2, TO_DATE('2025-02-12', 'YYYY-MM-DD'), '09:00');

-- Tablas del m�dulo de compras
--FIDE_METODO_PAGO_TB
INSERT INTO AdminDB.FIDE_METODO_PAGO_TB (METODO_PAGO_ID, NOMBRE) 
VALUES (1, 'Tarjeta de Cr�dito');
INSERT INTO AdminDB.FIDE_METODO_PAGO_TB (METODO_PAGO_ID, NOMBRE) 
VALUES (2, 'Efectivo ');

--FIDE_DESCUENTO_TB
INSERT INTO AdminDB.FIDE_DESCUENTO_TB (DESCUENTO_ID, NOMBRE, PORCENTAJE) 
VALUES (1, 'Descuento por Temporada', 10.00);
INSERT INTO AdminDB.FIDE_DESCUENTO_TB (DESCUENTO_ID, NOMBRE, PORCENTAJE) 
VALUES (2, 'Descuento Estudiantil', 15.00);

--FIDE_TIPO_COMPRA_TB
INSERT INTO AdminDB.FIDE_TIPO_COMPRA_TB (TIPO_COMPRA_ID, PRODUCTO_ID, CURSO_ID, SERVICIO_ID) 
VALUES (1, 1, 1, 2);
INSERT INTO AdminDB.FIDE_TIPO_COMPRA_TB (TIPO_COMPRA_ID, PRODUCTO_ID, CURSO_ID, SERVICIO_ID) 
VALUES (2, 2, 1, 2);

--FIDE_DETALLE_FACTURA_TB
INSERT INTO AdminDB.FIDE_DETALLE_FACTURA_TB (DETALLE_FACTURA_ID, CANTIDAD_LINEAS, TOTAL_POR_LINEA, TIPO_COMPRA_ID) 
VALUES (1, 2, 100.00, 1);
INSERT INTO AdminDB.FIDE_DETALLE_FACTURA_TB (DETALLE_FACTURA_ID, CANTIDAD_LINEAS, TOTAL_POR_LINEA, TIPO_COMPRA_ID) 
VALUES (2, 3, 150.00, 2);

--FIDE_FACTURA_TB
INSERT INTO AdminDB.FIDE_FACTURA_TB (FACTURA_ID, USUARIO_ID, FECHA, DETALLE_FACTURA_ID, CANTIDAD_LINEAS, DESCUENTO_ID, IVA, SUBTOTAL, MONTO_TOTAL, METODO_PAGO_ID) 
VALUES (1, 1, TO_DATE('2025-01-20', 'YYYY-MM-DD'), 1, 2, 1, 12.00, 90.00, 102.00, 1);
INSERT INTO AdminDB.FIDE_FACTURA_TB (FACTURA_ID, USUARIO_ID, FECHA, DETALLE_FACTURA_ID, CANTIDAD_LINEAS, DESCUENTO_ID, IVA, SUBTOTAL, MONTO_TOTAL, METODO_PAGO_ID) 
VALUES (2, 2, TO_DATE('2025-02-15', 'YYYY-MM-DD'), 2, 3, 2, 18.00, 135.00, 153.00, 2);

---------------------------------------------------------------------------------------------------------------------------------------------------
---Vistas
--Informacion del usuario
CREATE OR REPLACE VIEW FIDE_INFO_USUARIOS_V AS
SELECT U.NOMBRE AS FIRST_NAME, U.APELLIDO AS LAST_NAME, U.CORREO AS EMAIL, P.NOMBRE AS PROVINCIA, E.NOMBRE AS ESTADO
FROM AdminDB.FIDE_USUARIO_TB U, AdminDB.FIDE_DIRECCION_TB D, AdminDB.FIDE_PROVINCIA_TB P, AdminDB.FIDE_ESTADO_TB E
WHERE  U.DIRECCION_ID = D.DIRECCION_ID
    AND D.PROVINCIA_ID = P.PROVINCIA_ID
    AND U.ESTADO_ID = E.ESTADO_ID;
/
SELECT * FROM FIDE_INFO_USUARIOS_V;

--Informacion de los cursos 
CREATE OR REPLACE VIEW FIDE_INFO_CURSOS_V AS
SELECT C.CURSO_ID,C.NOMBRE AS CURSO_NOMBRE,C.DESCRIPCION AS CURSO_DESCRIPCION,C.FECHA AS FECHA_CURSO,C.HORA AS HORA_CURSO,
C.PRECIO AS PRECIO_CURSO,C.CAPACIDAD AS CAPACIDAD_CURSO,T.TIPO_CURSO_ID,T.NOMBRE AS TIPO_CURSO_NOMBRE
FROM AdminDB.FIDE_CURSO_TB C,AdminDB.FIDE_TIPO_CURSO_TB T
WHERE 
    C.TIPO_CURSO_ID = T.TIPO_CURSO_ID;
/
SELECT * FROM FIDE_INFO_CURSOS_V ;

--Informacion de la direccion de los usuarios
CREATE OR REPLACE VIEW FIDE_INFO_USUARIOS_DIRECCION_V AS
SELECT U.USUARIO_ID, U.NOMBRE AS NOMBRE_USUARIO, P.NOMBRE AS PROVINCIA_NOMBRE, C.NOMBRE AS CANTON_NOMBRE,
DIST.NOMBRE AS DISTRITO_NOMBRE, D.SE�AS AS DIRECCION_SE�AS
FROM AdminDB.FIDE_USUARIO_TB U, AdminDB.FIDE_DIRECCION_TB D, AdminDB.FIDE_PROVINCIA_TB P, AdminDB.FIDE_CANTON_TB C,
AdminDB.FIDE_DISTRITO_TB DIST
WHERE U.DIRECCION_ID = D.DIRECCION_ID
    AND D.PROVINCIA_ID = P.PROVINCIA_ID
    AND D.CANTON_ID = C.CANTON_ID
    AND D.DISTRITO_ID = DIST.DISTRITO_ID;
/
SELECT * FROM FIDE_INFO_USUARIOS_DIRECCION_V ;

--Informacion de los productos 
CREATE OR REPLACE VIEW FIDE_INFO_PRODUCTOS_INVENTARIO_V AS
SELECT C.CATEGORIA_ID,C.NOMBRE AS CATEGORIA_NOMBRE,P.PRODUCTO_ID,P.NOMBRE AS PRODUCTO_NOMBRE, P.DESCRIPCION AS PRODUCTO_DESCRIPCION,
P.PRECIO_UNIT AS PRODUCTO_PRECIO,I.INVENTARIO_ID,I.STOCK AS INVENTARIO_STOCK,I.FECHA_VENCIMIENTO AS INVENTARIO_FECHA_VENCIMIENTO,
I.DIAS_EN_STOCK AS INVENTARIO_DIAS_EN_STOCK
FROM AdminDB.FIDE_CATEGORIA_TB C,  AdminDB.FIDE_PRODUCTO_TB P, AdminDB.FIDE_INVENTARIO_TB I
WHERE P.CATEGORIA_ID = C.CATEGORIA_ID
    AND I.PRODUCTO_ID = P.PRODUCTO_ID;
/
SELECT * FROM FIDE_INFO_PRODUCTOS_INVENTARIO_V;

--Informacion de los servicios
CREATE OR REPLACE VIEW FIDE_INFO_EVENTOS_CITAS_V AS
SELECT  E.EVENTO_ID, E.USUARIO_ID AS EVENTO_USUARIO_ID, E.FECHA AS EVENTO_FECHA, C.CITA_ID, C.USUARIO_ID AS CITA_USUARIO_ID, 
C.FECHA AS CITA_FECHA, C.HORA AS CITA_HORA
FROM AdminDB.FIDE_EVENTO_TB E, AdminDB.FIDE_CITA_TB C, AdminDB.FIDE_SERVICIO_TB S
WHERE E.SERVICIO_ID = S.SERVICIO_ID
    AND C.SERVICIO_ID = S.SERVICIO_ID;
/
SELECT * FROM FIDE_INFO_EVENTOS_CITAS_V;

--Informacion de las compras
CREATE OR REPLACE VIEW FIDE_INFO_COMPRAS_V AS
SELECT MP.NOMBRE AS METODO_PAGO_NOMBRE, D.NOMBRE AS DESCUENTO_NOMBRE, D.PORCENTAJE AS DESCUENTO_PORCENTAJE,  
F.FACTURA_ID,  F.USUARIO_ID AS FACTURA_USUARIO_ID, F.FECHA AS FACTURA_FECHA, F.IVA AS FACTURA_IVA, F.SUBTOTAL AS FACTURA_SUBTOTAL, 
F.MONTO_TOTAL AS FACTURA_MONTO_TOTAL
FROM AdminDB.FIDE_FACTURA_TB F, AdminDB.FIDE_METODO_PAGO_TB MP, AdminDB.FIDE_DESCUENTO_TB D, AdminDB.FIDE_TIPO_COMPRA_TB TC
WHERE F.METODO_PAGO_ID = MP.METODO_PAGO_ID
    AND F.DESCUENTO_ID = D.DESCUENTO_ID
    AND EXISTS (SELECT 1 FROM AdminDB.FIDE_DETALLE_FACTURA_TB DF WHERE DF.TIPO_COMPRA_ID = TC.TIPO_COMPRA_ID);
/
SELECT * FROM FIDE_INFO_COMPRAS_V;

--Estado del usuario
CREATE OR REPLACE VIEW FIDE_USUARIOS_ESTADOS_V AS
SELECT E.ESTADO_ID, E.NOMBRE AS ESTADO_NOMBRE, U.USUARIO_ID, U.NOMBRE AS USUARIO_NOMBRE, U.APELLIDO AS USUARIO_APELLIDO, 
U.CORREO AS USUARIO_EMAIL
FROM AdminDB.FIDE_ESTADO_TB E, AdminDB.FIDE_USUARIO_TB U
WHERE U.ESTADO_ID = E.ESTADO_ID;
/
SELECT * FROM FIDE_USUARIOS_ESTADOS_V;

--Informacion de los usuarios, citas y metodos de pago 
CREATE OR REPLACE VIEW FIDE_INFO_USUARIOS_CITAS_METODO_PAGO_V AS
SELECT U.USUARIO_ID, U.NOMBRE AS USUARIO_NOMBRE, U.APELLIDO AS USUARIO_APELLIDO, U.CORREO AS USUARIO_EMAIL,
C.CITA_ID, C.FECHA AS CITA_FECHA, C.HORA AS CITA_HORA, MP.METODO_PAGO_ID, MP.NOMBRE AS METODO_PAGO_NOMBRE
FROM AdminDB.FIDE_USUARIO_TB U, AdminDB.FIDE_CITA_TB C, AdminDB.FIDE_METODO_PAGO_TB MP
WHERE U.USUARIO_ID = C.USUARIO_ID 
    AND MP.METODO_PAGO_ID = MP.METODO_PAGO_ID;
/
SELECT * FROM FIDE_INFO_USUARIOS_CITAS_METODO_PAGO_V;

--Informacion de los usuarios, cursos y el tipo de curso
CREATE OR REPLACE VIEW FIDE_INFO_USUARIOS_CURSOS_V AS
SELECT U.USUARIO_ID, U.NOMBRE AS USUARIO_NOMBRE, U.APELLIDO AS USUARIO_APELLIDO, C.CURSO_ID, C.NOMBRE AS CURSO_NOMBRE, 
TC.TIPO_CURSO_ID, TC.NOMBRE AS TIPO_CURSO_NOMBRE
FROM AdminDB.FIDE_USUARIO_TB U, AdminDB.FIDE_CURSO_TB C, AdminDB.FIDE_TIPO_CURSO_TB TC
WHERE U.USUARIO_ID = U.USUARIO_ID
    AND C.TIPO_CURSO_ID = TC.TIPO_CURSO_ID;
/
SELECT * FROM FIDE_INFO_USUARIOS_CURSOS_V;

--Informacion de los usuarios, cursos y el tipo de curso
CREATE OR REPLACE VIEW FIDE_INFO_TIPO_COMPRA_PRODUCTO_V AS
SELECT TC.TIPO_COMPRA_ID, P.PRODUCTO_ID, P.CATEGORIA_ID AS CATEGORIA,P.NOMBRE AS PRODUCTO_NOMBRE, P.PRECIO_UNIT AS PRODUCTO_PRECIO
FROM AdminDB.FIDE_TIPO_COMPRA_TB TC, AdminDB.FIDE_PRODUCTO_TB P
WHERE TC.PRODUCTO_ID = P.PRODUCTO_ID;
/
SELECT * FROM FIDE_INFO_TIPO_COMPRA_PRODUCTO_V;





















