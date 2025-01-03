-- Tablas del módulo de productos

CREATE TABLE AdminDB.FIDE_CATEGORIA_TB (
    CATEGORIA_ID NUMBER CONSTRAINT FIDE_CATEGORIA_TB_CATEGORIA_ID_PK PRIMARY KEY,
    NOMBRE VARCHAR2(100) NOT NULL
);
DROP TABLE AdminDB.FIDE_INVENTARIO_TB;
CREATE TABLE AdminDB.FIDE_PRODUCTO_TB (
    PRODUCTO_ID NUMBER CONSTRAINT FIDE_PRODUCTO_TB_PRODUCTO_ID_PK PRIMARY KEY,
    NOMBRE VARCHAR2(100) NOT NULL,
    DESCRIPCION VARCHAR2(250),
    IMAGEN VARCHAR2(250),
    PRECIO_UNIT DECIMAL(10, 2) NOT NULL,
    CATEGORIA_ID NUMBER NOT NULL,
    
    -- Claves fóraneas
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
    
    -- Claves fóraneas
     CONSTRAINT FIDE_INVENTARIO_TB_ESTADO_ID_FK
        FOREIGN KEY (ESTADO_ID)
        REFERENCES FIDE_ESTADO_TB (ESTADO_ID),
        
     CONSTRAINT FIDE_INVENTARIO_TB_PRODUCTO_ID_FK
        FOREIGN KEY (PRODUCTO_ID)
        REFERENCES FIDE_PRODUCTO_TB (PRODUCTO_ID)
);
-- Tablas del módulo de compras
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
    
     -- Claves fóraneas
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
    
    -- Claves fóraneas
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
    
    -- Claves fóraneas
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

--------SECUENCIAS DEL ID DE LAS TABLAS 
-- Secuencias
CREATE SEQUENCE FIDE_CATEGORIA_SEQ START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE FIDE_PRODUCTO_SEQ START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE FIDE_INVENTARIO_SEQ START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE FIDE_METODO_PAGO_SEQ START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE FIDE_DESCUENTO_SEQ START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE FIDE_TIPO_COMPRA_SEQ START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE FIDE_DETALLE_FACTURA_SEQ START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE FIDE_FACTURA_SEQ START WITH 1 INCREMENT BY 1;

-----TRIGGERS DE PRODUCTOS 

-- Trigger para FIDE_CATEGORIA_TB
CREATE OR REPLACE TRIGGER FIDE_CATEGORIA_BI
BEFORE INSERT ON FIDE_CATEGORIA_TB
FOR EACH ROW
BEGIN
    :NEW.CATEGORIA_ID := FIDE_CATEGORIA_SEQ.NEXTVAL;
END;
/

-- Trigger para FIDE_PRODUCTO_TB
CREATE OR REPLACE TRIGGER FIDE_PRODUCTO_BI
BEFORE INSERT ON FIDE_PRODUCTO_TB
FOR EACH ROW
BEGIN
    :NEW.PRODUCTO_ID := FIDE_PRODUCTO_SEQ.NEXTVAL;
END;
/

-- Trigger para FIDE_INVENTARIO_TB
CREATE OR REPLACE TRIGGER FIDE_INVENTARIO_BI
BEFORE INSERT ON FIDE_INVENTARIO_TB
FOR EACH ROW
BEGIN
    :NEW.INVENTARIO_ID := FIDE_INVENTARIO_SEQ.NEXTVAL;
END;
/

-- Trigger para FIDE_METODO_PAGO_TB
CREATE OR REPLACE TRIGGER FIDE_METODO_PAGO_BI
BEFORE INSERT ON FIDE_METODO_PAGO_TB
FOR EACH ROW
BEGIN
    :NEW.METODO_PAGO_ID := FIDE_METODO_PAGO_SEQ.NEXTVAL;
END;
/

-- Trigger para FIDE_DESCUENTO_TB
CREATE OR REPLACE TRIGGER FIDE_DESCUENTO_BI
BEFORE INSERT ON FIDE_DESCUENTO_TB
FOR EACH ROW
BEGIN
    :NEW.DESCUENTO_ID := FIDE_DESCUENTO_SEQ.NEXTVAL;
END;
/

-- Trigger para FIDE_TIPO_COMPRA_TB
CREATE OR REPLACE TRIGGER FIDE_TIPO_COMPRA_BI
BEFORE INSERT ON FIDE_TIPO_COMPRA_TB
FOR EACH ROW
BEGIN
    :NEW.TIPO_COMPRA_ID := FIDE_TIPO_COMPRA_SEQ.NEXTVAL;
END;
/

-- Trigger para FIDE_DETALLE_FACTURA_TB
CREATE OR REPLACE TRIGGER FIDE_DETALLE_FACTURA_BI
BEFORE INSERT ON FIDE_DETALLE_FACTURA_TB
FOR EACH ROW
BEGIN
    :NEW.DETALLE_FACTURA_ID := FIDE_DETALLE_FACTURA_SEQ.NEXTVAL;
END;
/

-- Trigger para FIDE_FACTURA_TB
CREATE OR REPLACE TRIGGER FIDE_FACTURA_BI
BEFORE INSERT ON FIDE_FACTURA_TB
FOR EACH ROW
BEGIN
    :NEW.FACTURA_ID := FIDE_FACTURA_SEQ.NEXTVAL;
END;
/

----PAQUETES DE PRODUCTOS 

CREATE OR REPLACE PACKAGE AdminDB.PaqueteProductos AS
    -- Procedimientos para FIDE_CATEGORIA_TB
    PROCEDURE InsertarCategoria(p_nombre IN VARCHAR2);
    PROCEDURE LeerCategorias;
    PROCEDURE ActualizarCategoria(p_categoria_id IN NUMBER, p_nombre IN VARCHAR2);
    PROCEDURE EliminarCategoria(p_categoria_id IN NUMBER);
    
    -- Procedimientos para FIDE_PRODUCTO_TB
    PROCEDURE InsertarProducto(
        p_nombre IN VARCHAR2, 
        p_descripcion IN VARCHAR2, 
        p_imagen IN VARCHAR2, 
        p_precio_unit IN NUMBER, 
        p_categoria_id IN NUMBER
    );
    PROCEDURE LeerProductos;
    PROCEDURE ActualizarProducto(
        p_producto_id IN NUMBER, 
        p_nombre IN VARCHAR2, 
        p_descripcion IN VARCHAR2, 
        p_imagen IN VARCHAR2, 
        p_precio_unit IN NUMBER, 
        p_categoria_id IN NUMBER
    );
    PROCEDURE EliminarProducto(p_producto_id IN NUMBER);

    -- Procedimientos para FIDE_INVENTARIO_TB
    PROCEDURE InsertarInventario(
        p_stock IN NUMBER, 
        p_fecha_vencimiento IN DATE, 
        p_dias_en_stock IN NUMBER, 
        p_precio_unit IN NUMBER, 
        p_estado_id IN NUMBER, 
        p_producto_id IN NUMBER
    );
    PROCEDURE LeerInventario;
    PROCEDURE ActualizarInventario(
        p_inventario_id IN NUMBER, 
        p_stock IN NUMBER, 
        p_fecha_vencimiento IN DATE, 
        p_dias_en_stock IN NUMBER, 
        p_precio_unit IN NUMBER, 
        p_estado_id IN NUMBER, 
        p_producto_id IN NUMBER
    );
    PROCEDURE EliminarInventario(p_inventario_id IN NUMBER);

    -- Funciones Complementarias
    FUNCTION TotalProductosInventario RETURN NUMBER;
    FUNCTION ValorTotalInventario RETURN NUMBER;
END PaqueteProductos;
/

-----BODY DEL PAQUETE 
CREATE OR REPLACE PACKAGE BODY AdminDB.PaqueteProductos AS

    -- Procedimientos para FIDE_CATEGORIA_TB
    PROCEDURE InsertarCategoria(p_nombre IN VARCHAR2) AS
    BEGIN
        INSERT INTO FIDE_CATEGORIA_TB (CATEGORIA_ID, NOMBRE)
        VALUES (FIDE_CATEGORIA_SEQ.NEXTVAL, p_nombre);
    END;

    PROCEDURE LeerCategorias IS
    BEGIN
        FOR r IN (SELECT * FROM FIDE_CATEGORIA_TB) LOOP
            DBMS_OUTPUT.PUT_LINE(r.CATEGORIA_ID || ' - ' || r.NOMBRE);
        END LOOP;
    END;

    PROCEDURE ActualizarCategoria(p_categoria_id IN NUMBER, p_nombre IN VARCHAR2) AS
    BEGIN
        UPDATE FIDE_CATEGORIA_TB
        SET NOMBRE = p_nombre
        WHERE CATEGORIA_ID = p_categoria_id;
    END;

    PROCEDURE EliminarCategoria(p_categoria_id IN NUMBER) AS
    BEGIN
        DELETE FROM FIDE_CATEGORIA_TB
        WHERE CATEGORIA_ID = p_categoria_id;
    END;

    -- Procedimientos para FIDE_PRODUCTO_TB
    PROCEDURE InsertarProducto(
        p_nombre IN VARCHAR2, 
        p_descripcion IN VARCHAR2, 
        p_imagen IN VARCHAR2, 
        p_precio_unit IN NUMBER, 
        p_categoria_id IN NUMBER
    ) AS
    BEGIN
        INSERT INTO FIDE_PRODUCTO_TB (
            PRODUCTO_ID, NOMBRE, DESCRIPCION, IMAGEN, PRECIO_UNIT, CATEGORIA_ID
        )
        VALUES (
            FIDE_PRODUCTO_SEQ.NEXTVAL, p_nombre, p_descripcion, p_imagen, p_precio_unit, p_categoria_id
        );
    END;

    PROCEDURE LeerProductos IS
    BEGIN
        FOR r IN (
            SELECT 
                P.PRODUCTO_ID, P.NOMBRE, P.DESCRIPCION, P.IMAGEN, P.PRECIO_UNIT, 
                C.NOMBRE AS CATEGORIA
            FROM FIDE_PRODUCTO_TB P
            INNER JOIN FIDE_CATEGORIA_TB C ON P.CATEGORIA_ID = C.CATEGORIA_ID
        ) LOOP
            DBMS_OUTPUT.PUT_LINE(r.PRODUCTO_ID || ' - ' || r.NOMBRE || ' - ' || r.CATEGORIA);
        END LOOP;
    END;

    PROCEDURE ActualizarProducto(
        p_producto_id IN NUMBER, 
        p_nombre IN VARCHAR2, 
        p_descripcion IN VARCHAR2, 
        p_imagen IN VARCHAR2, 
        p_precio_unit IN NUMBER, 
        p_categoria_id IN NUMBER
    ) AS
    BEGIN
        UPDATE FIDE_PRODUCTO_TB
        SET NOMBRE = p_nombre,
            DESCRIPCION = p_descripcion,
            IMAGEN = p_imagen,
            PRECIO_UNIT = p_precio_unit,
            CATEGORIA_ID = p_categoria_id
        WHERE PRODUCTO_ID = p_producto_id;
    END;

    PROCEDURE EliminarProducto(p_producto_id IN NUMBER) AS
    BEGIN
        DELETE FROM FIDE_PRODUCTO_TB
        WHERE PRODUCTO_ID = p_producto_id;
    END;

    -- Procedimientos para FIDE_INVENTARIO_TB
    PROCEDURE InsertarInventario(
        p_stock IN NUMBER, 
        p_fecha_vencimiento IN DATE, 
        p_dias_en_stock IN NUMBER, 
        p_precio_unit IN NUMBER, 
        p_estado_id IN NUMBER, 
        p_producto_id IN NUMBER
    ) AS
    BEGIN
        INSERT INTO FIDE_INVENTARIO_TB (
            INVENTARIO_ID, STOCK, FECHA_VENCIMIENTO, DIAS_EN_STOCK, 
            PRECIO_UNIT, ESTADO_ID, PRODUCTO_ID
        )
        VALUES (
            FIDE_INVENTARIO_SEQ.NEXTVAL, p_stock, p_fecha_vencimiento, 
            p_dias_en_stock, p_precio_unit, p_estado_id, p_producto_id
        );
    END;

    PROCEDURE LeerInventario IS
    BEGIN
        FOR r IN (
            SELECT 
                I.INVENTARIO_ID, I.STOCK, I.FECHA_VENCIMIENTO, I.DIAS_EN_STOCK, 
                I.PRECIO_UNIT, E.NOMBRE AS ESTADO, P.NOMBRE AS PRODUCTO
            FROM FIDE_INVENTARIO_TB I
            INNER JOIN FIDE_ESTADO_TB E ON I.ESTADO_ID = E.ESTADO_ID
            INNER JOIN FIDE_PRODUCTO_TB P ON I.PRODUCTO_ID = P.PRODUCTO_ID
        ) LOOP
            DBMS_OUTPUT.PUT_LINE(r.INVENTARIO_ID || ' - ' || r.PRODUCTO || ' - ' || r.ESTADO);
        END LOOP;
    END;

    PROCEDURE ActualizarInventario(
        p_inventario_id IN NUMBER, 
        p_stock IN NUMBER, 
        p_fecha_vencimiento IN DATE, 
        p_dias_en_stock IN NUMBER, 
        p_precio_unit IN NUMBER, 
        p_estado_id IN NUMBER, 
        p_producto_id IN NUMBER
    ) AS
    BEGIN
        UPDATE FIDE_INVENTARIO_TB
        SET STOCK = p_stock,
            FECHA_VENCIMIENTO = p_fecha_vencimiento,
            DIAS_EN_STOCK = p_dias_en_stock,
            PRECIO_UNIT = p_precio_unit,
            ESTADO_ID = p_estado_id,
            PRODUCTO_ID = p_producto_id
        WHERE INVENTARIO_ID = p_inventario_id;
    END;

    PROCEDURE EliminarInventario(p_inventario_id IN NUMBER) AS
    BEGIN
        DELETE FROM FIDE_INVENTARIO_TB
        WHERE INVENTARIO_ID = p_inventario_id;
    END;

    -- Funciones Complementarias
    FUNCTION TotalProductosInventario RETURN NUMBER IS
        v_total NUMBER;
    BEGIN
        SELECT SUM(STOCK) INTO v_total FROM FIDE_INVENTARIO_TB;
        RETURN v_total;
    END;

    FUNCTION ValorTotalInventario RETURN NUMBER IS
        v_valor_total NUMBER;
    BEGIN
        SELECT SUM(STOCK * PRECIO_UNIT) INTO v_valor_total FROM FIDE_INVENTARIO_TB;
        RETURN v_valor_total;
    END;

END PaqueteProductos;
/










