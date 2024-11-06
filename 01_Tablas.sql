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
    SE�AS VARCHAR2(250) NOT NULL,
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
    PRECIO_UNIT DECIMAL(10, 2) NOT NULL,
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

