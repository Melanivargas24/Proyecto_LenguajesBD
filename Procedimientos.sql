-------PROCEDIMIENTOS--------

-------------------------Procedimientos de la parte de SERVICIOS -------------------------------
--Citas
--Sequencia de citas
CREATE SEQUENCE FIDE_INSERTAR_CITA_SEQ
START WITH 1
INCREMENT BY 1; 
--VISUALIZAR SEQUENCIA 
SELECT FIDE_INSERTAR_CITA_SEQ.NEXTVAL AS SECUENCIA FROM FIDE_CITA_TB; 
--Procedimiento de lectura de citas 
CREATE OR REPLACE PROCEDURE FIDE_CITA_TB_OBTENER_SP(P_RESULTADO OUT SYS_REFCURSOR)
AS
BEGIN
    OPEN P_RESULTADO FOR 
        SELECT * 
        FROM FIDE_CITA_TB;
END FIDE_CITA_TB_OBTENER_SP;
/
--Procedimiento de insert de citas
CREATE OR REPLACE PROCEDURE FIDE_INSERTAR_CITA_SP(
    P_USUARIO_ID IN NUMBER,
    P_SERVICIO_ID IN NUMBER,
    P_ESTADO_ID IN NUMBER,
    P_FECHA IN DATE,
    P_HORA IN VARCHAR2
) AS
BEGIN
    INSERT INTO FIDE_CITA_TB (
        CITA_ID,
        USUARIO_ID,
        SERVICIO_ID,
        ESTADO_ID,
        FECHA,
        HORA
    )
    VALUES (
        INSERTAR_CITA_SEQ.NEXTVAL, 
        P_USUARIO_ID,
        P_SERVICIO_ID,
        P_ESTADO_ID,
        P_FECHA,
        P_HORA
    );
    COMMIT; 
END;
/
--Mostrar procedimiento de insertar las citas 
BEGIN
    FIDE_INSERTAR_CITA_SP(
        P_USUARIO_ID => 1,
        P_SERVICIO_ID => 2,
        P_ESTADO_ID => 1,
        P_FECHA => TO_DATE('2024-11-22', 'YYYY-MM-DD'),
        P_HORA => '10:00 AM'
    );
END;
/

--Procedimiento de modificar de citas
CREATE OR REPLACE PROCEDURE FIDE_MODIFICAR_CITA_SP(
    P_CITA_ID IN NUMBER, 
    P_USUARIO_ID IN NUMBER,
    P_SERVICIO_ID IN NUMBER,
    P_ESTADO_ID IN NUMBER,
    P_FECHA IN DATE,
    P_HORA IN VARCHAR2
) AS
BEGIN
    UPDATE FIDE_CITA_TB
    SET
        USUARIO_ID = P_USUARIO_ID,
        SERVICIO_ID = P_SERVICIO_ID,
        ESTADO_ID = P_ESTADO_ID,
        FECHA = P_FECHA,
        HORA = P_HORA
    WHERE CITA_ID = P_CITA_ID;
    COMMIT; 
END;
/
--Mostrar procedimiento de modificar las citas 
BEGIN
    FIDE_MODIFICAR_CITA_SP(
        P_CITA_ID => 6, 
        P_USUARIO_ID => 2,
        P_SERVICIO_ID => 2,
        P_ESTADO_ID => 2,
        P_FECHA => TO_DATE('2024-12-01', 'YYYY-MM-DD'),
        P_HORA => '11:30 AM'
    );
END;
/
--Procedimiento de eliminar de citas
CREATE OR REPLACE PROCEDURE FIDE_ELIMINAR_CITA_SP(
    P_CITA_ID IN NUMBER 
) AS
BEGIN
    DELETE FROM FIDE_CITA_TB
    WHERE CITA_ID = P_CITA_ID;
    COMMIT; 
END;
/
--Mostrar procedimiento de eliminar las citas 
BEGIN
    FIDE_ELIMINAR_CITA_SP(
        P_CITA_ID => 6
    );
END;
/
--Eventos
--Sequencia de eventos
CREATE SEQUENCE FIDE_INSERTAR_EVENTO_SEQ
START WITH 1
INCREMENT BY 1; 
--VISUALIZAR SEQUENCIA 
SELECT FIDE_INSERTAR_EVENTO_SEQ.NEXTVAL AS SECUENCIA FROM FIDE_EVENTO_TB; 
--Procedimiento de lectura 
CREATE OR REPLACE PROCEDURE FIDE_EVENTO_TB_OBTENER_SP(P_RESULTADO OUT SYS_REFCURSOR)
AS
BEGIN
    OPEN P_RESULTADO FOR 
        SELECT * 
        FROM FIDE_EVENTO_TB;
END FIDE_EVENTO_TB_OBTENER_SP;
/
--Procedimiento de insert de evento
CREATE OR REPLACE PROCEDURE FIDE_INSERTAR_EVENTO_SP(
    P_USUARIO_ID IN NUMBER,
    P_SERVICIO_ID IN NUMBER,
    P_DIRECCION_ID IN NUMBER,
    P_ESTADO_ID IN NUMBER,
    P_FECHA IN DATE
) AS
BEGIN
    INSERT INTO FIDE_EVENTO_TB (
        EVENTO_ID,
        USUARIO_ID,
        SERVICIO_ID,
        DIRECCION_ID,
        ESTADO_ID,
        FECHA
    )
    VALUES (
        FIDE_INSERTAR_EVENTO_SEQ.NEXTVAL, 
        P_USUARIO_ID,
        P_SERVICIO_ID,
        P_DIRECCION_ID,
        P_ESTADO_ID,
        P_FECHA
    );
    COMMIT; 
END;
/
--Mostrar el insert de eventos 
BEGIN
        FIDE_INSERTAR_EVENTO_SP(
        P_USUARIO_ID => 1,
        P_SERVICIO_ID => 2,
        P_DIRECCION_ID => 2,
        P_ESTADO_ID => 1,
        P_FECHA => TO_DATE('2024-11-22', 'YYYY-MM-DD')
    );
END;
/
--Procedimiento de update de evento
CREATE OR REPLACE PROCEDURE FIDE_ACTUALIZAR_EVENTO_SP(
    P_EVENTO_ID IN NUMBER,
    P_USUARIO_ID IN NUMBER,
    P_SERVICIO_ID IN NUMBER,
    P_DIRECCION_ID IN NUMBER,
    P_ESTADO_ID IN NUMBER,
    P_FECHA IN DATE
) AS
BEGIN
    UPDATE FIDE_EVENTO_TB
    SET 
        USUARIO_ID = P_USUARIO_ID,
        SERVICIO_ID = P_SERVICIO_ID,
        DIRECCION_ID = P_DIRECCION_ID,
        ESTADO_ID = P_ESTADO_ID,
        FECHA = P_FECHA
    WHERE 
        EVENTO_ID = P_EVENTO_ID;
    COMMIT; 
END;
/
--Mostrar el update de evento 
BEGIN
       FIDE_ACTUALIZAR_EVENTO_SP(
        P_EVENTO_ID => 2,
        P_USUARIO_ID => 2,
        P_SERVICIO_ID => 2,
        P_DIRECCION_ID => 2,
        P_ESTADO_ID => 2,
        P_FECHA => TO_DATE('2022-12-01', 'YYYY-MM-DD')
    );
END;
/
--Procedimiento almacenado de delete evento 
CREATE OR REPLACE PROCEDURE FIDE_ELIMINAR_EVENTO_SP(
    P_EVENTO_ID IN NUMBER
) AS
BEGIN
    DELETE FROM FIDE_EVENTO_TB
    WHERE EVENTO_ID = P_EVENTO_ID;
    COMMIT; 
END;
/
--MOSTRAR EL PROCEDIMEITNO DELETE 
BEGIN
      FIDE_ELIMINAR_EVENTO_SP(
        P_EVENTO_ID => 2
    );
END;
/

-------------------------Procedimientos de la parte de DIRECCIONES-------------------------------
--Provincia
--Sequencia de provincia
CREATE SEQUENCE FIDE_INSERTAR_PROVINCIA_SEQ
START WITH 1
INCREMENT BY 1; 
--VISUALIZAR SEQUENCIA 
SELECT FIDE_INSERTAR_PROVINCIA_SEQ.NEXTVAL AS SECUENCIA FROM FIDE_PROVINCIA_TB; 
--LECTURA
CREATE OR REPLACE PROCEDURE FIDE_PROVINCIA_TB_OBTENER_SP(P_RESULTADO OUT SYS_REFCURSOR)
AS
BEGIN
    OPEN P_RESULTADO FOR 
        SELECT * FROM FIDE_PROVINCIA_TB;
END FIDE_PROVINCIA_TB_OBTENER_SP;
/

--Procedimiento de insert 
CREATE OR REPLACE PROCEDURE FIDE_INSERTAR_PROVINCIA_SP(
    P_NOMBRE IN VARCHAR2
) AS
BEGIN
    INSERT INTO FIDE_PROVINCIA_TB (
        PROVINCIA_ID,
        NOMBRE
    )
    VALUES (
        FIDE_INSERTAR_PROVINCIA_SEQ.NEXTVAL, 
        P_NOMBRE
    );
    COMMIT; 
END;
/
--Mostrar el insert provincia 
BEGIN
     FIDE_INSERTAR_PROVINCIA_SP(
        P_NOMBRE => 'Guanacaste'
    );
END;
/
--Procedimiento update 
CREATE OR REPLACE PROCEDURE FIDE_ACTUALIZAR_PROVINCIA_SP(
    P_PROVINCIA_ID IN NUMBER,
    P_NOMBRE IN VARCHAR2
) AS
BEGIN
    UPDATE FIDE_PROVINCIA_TB
    SET 
        NOMBRE = P_NOMBRE
    WHERE 
        PROVINCIA_ID = P_PROVINCIA_ID;
    COMMIT; 
END;
/
--Mostrar update 
BEGIN
    FIDE_ACTUALIZAR_PROVINCIA_SP(
        P_PROVINCIA_ID => 3,
        P_NOMBRE => 'Puntarenas'
    );
END;
/
--Procedimiento delete 
CREATE OR REPLACE PROCEDURE FIDE_ELIMINAR_PROVINCIA_SP(
    P_PROVINCIA_ID IN NUMBER
) AS
BEGIN
    DELETE FROM FIDE_PROVINCIA_TB
    WHERE PROVINCIA_ID = P_PROVINCIA_ID;
    COMMIT; 
END;
/


--CANTON
--Sequencia de provincia
CREATE SEQUENCE FIDE_INSERTAR_CANTON_SEQ
START WITH 1
INCREMENT BY 1; 
--VISUALIZAR SEQUENCIA 
SELECT FIDE_INSERTAR_CANTON_SEQ.NEXTVAL AS SECUENCIA FROM FIDE_PROVINCIA_TB; 
--Lectura
CREATE OR REPLACE PROCEDURE FIDE_CANTON_TB_OBTENER_SP(P_RESULTADO OUT SYS_REFCURSOR)
AS
BEGIN
    OPEN P_RESULTADO FOR 
        SELECT * FROM FIDE_CANTON_TB;
END FIDE_CANTON_TB_OBTENER_SP;
/

--INSERT 
CREATE OR REPLACE PROCEDURE INSERTAR_CANTON_SP(
    P_NOMBRE IN VARCHAR2
) AS
BEGIN
    INSERT INTO FIDE_CANTON_TB (
        CANTON_ID,
        NOMBRE
    )
    VALUES (
        FIDE_INSERTAR_CANTON_SEQ.NEXTVAL, 
        P_NOMBRE
    );
    COMMIT; 
END;
/
--MOSTRAR INSERT 
BEGIN
    INSERTAR_CANTON_SP(
        P_NOMBRE => 'Sarchi'
    );
END;
/

--Update 
CREATE OR REPLACE PROCEDURE ACTUALIZAR_CANTON_SP(
    P_CANTON_ID IN NUMBER,
    P_NOMBRE IN VARCHAR2
) AS
BEGIN
    UPDATE FIDE_CANTON_TB
    SET 
        NOMBRE = P_NOMBRE
    WHERE 
        CANTON_ID = P_CANTON_ID;
    COMMIT; 
END;
/
--Mostrar update 
BEGIN
    ACTUALIZAR_CANTON_SP(
        P_CANTON_ID => 2,
        P_NOMBRE => 'Portoviejo'
    );
END;
/
--Delete
CREATE OR REPLACE PROCEDURE ELIMINAR_CANTON_SP(
    P_CANTON_ID IN NUMBER
) AS
BEGIN
    DELETE FROM FIDE_CANTON_TB
    WHERE CANTON_ID = P_CANTON_ID;
    COMMIT; 
END;
/

--DISTRITO 
--Sequencia de distrito
CREATE SEQUENCE FIDE_INSERTAR_DISTRITO_SEQ
START WITH 1
INCREMENT BY 1; 
--VISUALIZAR SEQUENCIA 
SELECT FIDE_INSERTAR_DISTRITO_SEQ.NEXTVAL AS SECUENCIA FROM FIDE_DISTRITO_TB; 

--PROCEDIMIENTO DE LECTURA 
CREATE OR REPLACE PROCEDURE FIDE_DISTRITO_TB_OBTENER_SP(P_RESULTADO OUT SYS_REFCURSOR)
AS
BEGIN
    OPEN P_RESULTADO FOR 
        SELECT * FROM FIDE_DISTRITO_TB;
END FIDE_DISTRITO_TB_OBTENER_SP;
/

--PROCEDIMIENTO DE INSERT 
CREATE OR REPLACE PROCEDURE INSERTAR_DISTRITO_SP(
    P_NOMBRE IN VARCHAR2
) AS
BEGIN
    INSERT INTO FIDE_DISTRITO_TB (
        DISTRITO_ID,
        NOMBRE
    )
    VALUES (
        FIDE_INSERTAR_DISTRITO_SEQ.NEXTVAL, 
        P_NOMBRE
    );
    COMMIT; 
END;
/
--MOSTRAR INSERT
BEGIN
    INSERTAR_DISTRITO_SP(
        P_NOMBRE => 'Distrito Central'
    );
END;
/

--PROCEDIMIENTO DE UPDATE 
CREATE OR REPLACE PROCEDURE ACTUALIZAR_DISTRITO_SP(
    P_DISTRITO_ID IN NUMBER,
    P_NOMBRE IN VARCHAR2
) AS
BEGIN
    UPDATE FIDE_DISTRITO_TB
    SET 
        NOMBRE = P_NOMBRE
    WHERE 
        DISTRITO_ID = P_DISTRITO_ID;
    COMMIT; 
END;
/
--MOSTRAR UPDATE 
BEGIN
    ACTUALIZAR_DISTRITO_SP(
        P_DISTRITO_ID => 1,
        P_NOMBRE => 'Distrito Sur'
    );
END;
/
--PROCEDIMIENTO DELETE 
CREATE OR REPLACE PROCEDURE ELIMINAR_DISTRITO_SP(
    P_DISTRITO_ID IN NUMBER
) AS
BEGIN
    DELETE FROM FIDE_DISTRITO_TB
    WHERE DISTRITO_ID = P_DISTRITO_ID;
    COMMIT; 
END;
/

--DIRECCION
--Sequencia de distrito
CREATE SEQUENCE FIDE_INSERTAR_DIRECCION_SEQ
START WITH 1
INCREMENT BY 1; 
--VISUALIZAR SEQUENCIA 
SELECT FIDE_INSERTAR_DIRECCION_SEQ.NEXTVAL AS SECUENCIA FROM FIDE_DIRECCION_TB; 

--Procedimiento de lectura 
CREATE OR REPLACE PROCEDURE FIDE_DIRECCION_TB_OBTENER_SP(P_RESULTADO OUT SYS_REFCURSOR)
AS
BEGIN
    OPEN P_RESULTADO FOR 
        SELECT * FROM FIDE_DIRECCION_TB;
END FIDE_DIRECCION_TB_OBTENER_SP;
/

--Procedimiento de insert 
CREATE OR REPLACE PROCEDURE INSERTAR_DIRECCION_SP(
    P_SE�AS IN VARCHAR2,
    P_PROVINCIA_ID IN NUMBER,
    P_DISTRITO_ID IN NUMBER,
    P_CANTON_ID IN NUMBER
) AS
BEGIN
    INSERT INTO FIDE_DIRECCION_TB (
        DIRECCION_ID,
        SE�AS,
        PROVINCIA_ID,
        DISTRITO_ID,
        CANTON_ID
    )
    VALUES (
        FIDE_INSERTAR_DIRECCION_SEQ.NEXTVAL, 
        P_SE�AS,
        P_PROVINCIA_ID,
        P_DISTRITO_ID,
        P_CANTON_ID
    );
    COMMIT; 
END;
/
--mostrar insert
BEGIN
    INSERTAR_DIRECCION_SP(
        P_SE�AS => 'Calle Principal, Casa Azul',
        P_PROVINCIA_ID => 1,
        P_DISTRITO_ID => 2,
        P_CANTON_ID => 2
    );
END;
/

--Procedimiento update 
CREATE OR REPLACE PROCEDURE ACTUALIZAR_DIRECCION_SP(
    P_DIRECCION_ID IN NUMBER,
    P_SE�AS IN VARCHAR2,
    P_PROVINCIA_ID IN NUMBER,
    P_DISTRITO_ID IN NUMBER,
    P_CANTON_ID IN NUMBER
) AS
BEGIN
    UPDATE FIDE_DIRECCION_TB
    SET 
        SE�AS = P_SE�AS,
        PROVINCIA_ID = P_PROVINCIA_ID,
        DISTRITO_ID = P_DISTRITO_ID,
        CANTON_ID = P_CANTON_ID
    WHERE 
        DIRECCION_ID = P_DIRECCION_ID;
    COMMIT; 
END;
/
--mostrar update 
BEGIN
    ACTUALIZAR_DIRECCION_SP(
        P_DIRECCION_ID => 1,
        P_SE�AS => 'Avenida Secundaria, Edificio Verde',
        P_PROVINCIA_ID => 2,
        P_DISTRITO_ID => 2,
        P_CANTON_ID => 1
    );
END;
/

--Procedimiento delete 
CREATE OR REPLACE PROCEDURE ELIMINAR_DIRECCION_SP(
    P_DIRECCION_ID IN NUMBER
) AS
BEGIN
    DELETE FROM FIDE_DIRECCION_TB
    WHERE DIRECCION_ID = P_DIRECCION_ID;
    COMMIT; 
END;
/
--mostrar delete 
BEGIN
    ELIMINAR_DIRECCION_SP(
        P_DIRECCION_ID => 1
    );
END;
/

-------------------------Procedimientos de la parte de ESTADO-------------------------------
--Sequencia de estado
CREATE SEQUENCE FIDE_ESTADO_SEQ
START WITH 1
INCREMENT BY 1; 
--VISUALIZAR SEQUENCIA 
SELECT FIDE_ESTADO_SEQ.NEXTVAL AS SECUENCIA FROM FIDE_ESTADO_TB; 

--PROCEDIMIENTO DE LECTURA 
CREATE OR REPLACE PROCEDURE FIDE_ESTADO_TB_OBTENER_SP(P_RESULTADO OUT SYS_REFCURSOR)
AS
BEGIN
    OPEN P_RESULTADO FOR 
        SELECT * FROM FIDE_ESTADO_TB;
END FIDE_ESTADO_TB_OBTENER_SP;
/

--PROCEDIMIENTO DE INSERT
CREATE OR REPLACE PROCEDURE INSERTAR_ESTADO_SP(
    P_NOMBRE IN VARCHAR2
) AS
BEGIN
    INSERT INTO FIDE_ESTADO_TB (
        ESTADO_ID,
        NOMBRE
    )
    VALUES (
        FIDE_ESTADO_SEQ.NEXTVAL, 
        P_NOMBRE
    );
    COMMIT; 
END;
/
--MOSTRAR INSERT
BEGIN
    INSERTAR_ESTADO_SP(
        P_NOMBRE => 'Activo'
    );
END;
/

--PROCEDIMIENTO DE UPDATE 
CREATE OR REPLACE PROCEDURE ACTUALIZAR_ESTADO_SP(
    P_ESTADO_ID IN NUMBER,
    P_NOMBRE IN VARCHAR2
) AS
BEGIN
    UPDATE FIDE_ESTADO_TB
    SET 
        NOMBRE = P_NOMBRE
    WHERE 
        ESTADO_ID = P_ESTADO_ID;
    COMMIT; 
END;
/
--MOSTRAR UPDATE 
BEGIN
    ACTUALIZAR_ESTADO_SP(
        P_ESTADO_ID => 1,
        P_NOMBRE => 'Inactivo'
    );
END;
/

--PROCEDIMIENTO DE DELETE 
CREATE OR REPLACE PROCEDURE ELIMINAR_ESTADO_SP(
    P_ESTADO_ID IN NUMBER
) AS
BEGIN
    DELETE FROM FIDE_ESTADO_TB
    WHERE ESTADO_ID = P_ESTADO_ID;
    COMMIT; 
END;
/

-------------------------Procedimientos de la parte de USUARIOS-------------------------------
--ROL
--Sequencia de ROL
CREATE SEQUENCE FIDE_ROL_SEQ
START WITH 1
INCREMENT BY 1; 
--VISUALIZAR SEQUENCIA 
SELECT FIDE_ROL_SEQ.NEXTVAL AS SECUENCIA FROM FIDE_ROL_TB; 

--PROCEDIMIENTO DE LECTURA 
CREATE OR REPLACE PROCEDURE FIDE_ROL_TB_OBTENER_SP(P_RESULTADO OUT SYS_REFCURSOR)
AS
BEGIN
    OPEN P_RESULTADO FOR 
        SELECT * FROM FIDE_ROL_TB;
END FIDE_ROL_TB_OBTENER_SP;
/

--PROCEDIMIENTO DE INSERT
CREATE OR REPLACE PROCEDURE INSERTAR_ROL_SP(
    P_NOMBRE IN VARCHAR2
) AS
BEGIN
    INSERT INTO FIDE_ROL_TB (
        ROL_ID,
        NOMBRE
    )
    VALUES (
        FIDE_ROL_SEQ.NEXTVAL, 
        P_NOMBRE
    );
    COMMIT; 
END;
/
--MOSTAR INSERT
 BEGIN
    INSERTAR_ROL_SP(
        P_NOMBRE => 'Administrador'
    );
END;
/

--PROCEDIMIENTO DE UPDATE 
CREATE OR REPLACE PROCEDURE ACTUALIZAR_ROL_SP(
    P_ROL_ID IN NUMBER,
    P_NOMBRE IN VARCHAR2
) AS
BEGIN
    UPDATE FIDE_ROL_TB
    SET 
        NOMBRE = P_NOMBRE
    WHERE 
        ROL_ID = P_ROL_ID;
    COMMIT; 
END;
/
--MOSTRAR UPDATE 
BEGIN
    ACTUALIZAR_ROL_SP(
        P_ROL_ID => 1,
        P_NOMBRE => 'Editor'
    );
END;
/

--PROCEDIMIENTO DELETE
CREATE OR REPLACE PROCEDURE ELIMINAR_ROL_SP(
    P_ROL_ID IN NUMBER
) AS
BEGIN
    DELETE FROM AdminDB.FIDE_ROL_TB
    WHERE ROL_ID = P_ROL_ID;
    COMMIT; 
END;
/

--USUARIO 
--Sequencia de USUARIO
CREATE SEQUENCE FIDE_INSERTAR_USUARIO_SEQ
START WITH 1
INCREMENT BY 1; 
--VISUALIZAR SEQUENCIA 
SELECT  FIDE_INSERTAR_USUARIO_SEQ.NEXTVAL AS SECUENCIA FROM FIDE_USUARIO_TB; 

--PROCEDIMIENTO DE LECTURA 
CREATE OR REPLACE PROCEDURE FIDE_USUARIO_TB_OBTENER_SP(P_RESULTADO OUT SYS_REFCURSOR)
AS
BEGIN
    OPEN P_RESULTADO FOR 
        SELECT * FROM FIDE_USUARIO_TB;
END FIDE_USUARIO_TB_OBTENER_SP;
/

--PROCEDIMIENTO DE INSERT
CREATE OR REPLACE PROCEDURE INSERTAR_USUARIO_SP(
    P_NOMBRE IN VARCHAR2,
    P_APELLIDO IN VARCHAR2,
    P_CORREO IN VARCHAR2,
    P_CONTRASE�A IN VARCHAR2,
    P_DIRECCION_ID IN NUMBER,
    P_ROL_ID IN NUMBER,
    P_ESTADO_ID IN NUMBER
) AS
BEGIN
    INSERT INTO FIDE_USUARIO_TB (
        USUARIO_ID,
        NOMBRE,
        APELLIDO,
        CORREO,
        CONTRASE�A,
        DIRECCION_ID,
        ROL_ID,
        ESTADO_ID
    )
    VALUES (
         FIDE_INSERTAR_USUARIO_SEQ.NEXTVAL, 
        P_NOMBRE,
        P_APELLIDO,
        P_CORREO,
        P_CONTRASE�A,
        P_DIRECCION_ID,
        P_ROL_ID,
        P_ESTADO_ID
    );
    COMMIT; 
END;
/
--MOSTRAR INSERT
BEGIN
    INSERTAR_USUARIO_SP(
        P_NOMBRE => 'Juan',
        P_APELLIDO => 'P�rez',
        P_CORREO => 'juan.perez@example.com',
        P_CONTRASE�A => 'segura123',
        P_DIRECCION_ID => 1,
        P_ROL_ID => 2,
        P_ESTADO_ID => 1
    );
END;
/

--PROCEDIMIENTO DELETE 
CREATE OR REPLACE PROCEDURE ELIMINAR_USUARIO_SP(
    P_USUARIO_ID IN NUMBER
) AS
BEGIN
    DELETE FROM FIDE_USUARIO_TB
    WHERE USUARIO_ID = P_USUARIO_ID;
    COMMIT; 
END;
/
--MOSTRAR DELETE 
BEGIN
    ELIMINAR_USUARIO_SP(
        P_USUARIO_ID => 3
    );
END;
/

-------------------------Procedimientos de la parte de INVENTARIO-------------------------------
--INVENTARIO 
--Sequencia de INVENTARIO
CREATE SEQUENCE FIDE_INSERTAR_INVENTARIO_SEQ
START WITH 1
INCREMENT BY 1; 
--VISUALIZAR SEQUENCIA 
SELECT FIDE_INSERTAR_INVENTARIO_SEQ.NEXTVAL AS SECUENCIA FROM FIDE_INVENTARIO_TB; 

--PROCEDIMIENTO DE LECTURA 
CREATE OR REPLACE PROCEDURE FIDE_INVENTARIO_TB_OBTENER_SP(P_RESULTADO OUT SYS_REFCURSOR)
AS
BEGIN
    OPEN P_RESULTADO FOR 
        SELECT * FROM FIDE_INVENTARIO_TB;
END FIDE_INVENTARIO_TB_OBTENER_SP;
/

--PROCEDIMIENTO DE INSERT
CREATE OR REPLACE PROCEDURE INSERTAR_INVENTARIO_SP(
    P_STOCK IN NUMBER,
    P_FECHA_VENCIMIENTO IN DATE,
    P_DIAS_EN_STOCK IN NUMBER,
    P_PRECIO_UNIT IN DECIMAL,
    P_ESTADO_ID IN NUMBER,
    P_PRODUCTO_ID IN NUMBER
) AS
BEGIN
    INSERT INTO AdminDB.FIDE_INVENTARIO_TB (
        INVENTARIO_ID,
        STOCK,
        FECHA_VENCIMIENTO,
        DIAS_EN_STOCK,
        PRECIO_UNIT,
        ESTADO_ID,
        PRODUCTO_ID
    )
    VALUES (
       FIDE_INSERTAR_INVENTARIO_SEQ.NEXTVAL,
        P_STOCK,
        P_FECHA_VENCIMIENTO,
        P_DIAS_EN_STOCK,
        P_PRECIO_UNIT,
        P_ESTADO_ID,
        P_PRODUCTO_ID
    );
    COMMIT;
END;
/
--MOSTRAR INSERT
BEGIN
    INSERTAR_INVENTARIO_SP(
        P_STOCK => 5,
        P_FECHA_VENCIMIENTO => TO_DATE('2024-12-31', 'YYYY-MM-DD'),
        P_DIAS_EN_STOCK => 30,
        P_PRECIO_UNIT => 12,
        P_ESTADO_ID => 1,
        P_PRODUCTO_ID => 1
    );
END;
/

--PROCEDIMIENTO DE UPDATE 
CREATE OR REPLACE PROCEDURE ACTUALIZAR_INVENTARIO_SP(
    P_INVENTARIO_ID IN NUMBER,
    P_STOCK IN NUMBER,
    P_FECHA_VENCIMIENTO IN DATE,
    P_DIAS_EN_STOCK IN NUMBER,
    P_PRECIO_UNIT IN DECIMAL,
    P_ESTADO_ID IN NUMBER,
    P_PRODUCTO_ID IN NUMBER
) AS
BEGIN
    UPDATE FIDE_INVENTARIO_TB
    SET 
        STOCK = P_STOCK,
        FECHA_VENCIMIENTO = P_FECHA_VENCIMIENTO,
        DIAS_EN_STOCK = P_DIAS_EN_STOCK,
        PRECIO_UNIT = P_PRECIO_UNIT,
        ESTADO_ID = P_ESTADO_ID,
        PRODUCTO_ID = P_PRODUCTO_ID
    WHERE 
        INVENTARIO_ID = P_INVENTARIO_ID;
    COMMIT; 
END;
/
--MOSTRAR UPDATE 
BEGIN
    ACTUALIZAR_INVENTARIO_SP(
        P_INVENTARIO_ID => 3,
        P_STOCK => 52,
        P_FECHA_VENCIMIENTO => TO_DATE('2025-01-15', 'YYYY-MM-DD'),
        P_DIAS_EN_STOCK => 45,
        P_PRECIO_UNIT => 19,
        P_ESTADO_ID => 2,
        P_PRODUCTO_ID => 1
    );
END;
/
--PROCEDIMIENTO DELETE 
CREATE OR REPLACE PROCEDURE ELIMINAR_INVENTARIO_SP(
    P_INVENTARIO_ID IN NUMBER
) AS
BEGIN
    DELETE FROM FIDE_INVENTARIO_TB
    WHERE INVENTARIO_ID = P_INVENTARIO_ID;
    COMMIT; 
END;
/
--MOSTRAR DELETE 
BEGIN
    ELIMINAR_INVENTARIO_SP(
        P_INVENTARIO_ID => 3
    );
END;
/

-------------------------Procedimientos de la parte de CURSOS-------------------------------
--TIPO DE CURSO
--Sequencia de TIPOCURSO
CREATE SEQUENCE FIDE_TIPO_CURSO_SEQ
START WITH 1
INCREMENT BY 1; 
--VISUALIZAR SEQUENCIA 
SELECT FIDE_TIPO_CURSO_SEQ.NEXTVAL AS SECUENCIA FROM FIDE_TIPO_CURSO_TB; 

--PROCEDIMIENTO DE LECTURA 
CREATE OR REPLACE PROCEDURE FIDE_TIPO_CURSO_TB_OBTENER_SP(P_RESULTADO OUT SYS_REFCURSOR)
AS
BEGIN
    OPEN P_RESULTADO FOR 
        SELECT * FROM FIDE_TIPO_CURSO_TB;
END FIDE_TIPO_CURSO_TB_OBTENER_SP;
/

--PROCEDIMIENTO DE INSERT
CREATE OR REPLACE PROCEDURE INSERTAR_TIPO_CURSO_SP(
    P_TIPO_CURSO_ID IN NUMBER,
    P_NOMBRE IN VARCHAR2
) AS
BEGIN
    INSERT INTO FIDE_TIPO_CURSO_TB (
        TIPO_CURSO_ID,
        NOMBRE
    ) VALUES (
        P_TIPO_CURSO_ID,
        P_NOMBRE
    );
    COMMIT;
END;
/
--MOSTRAR INSERT
BEGIN
    INSERTAR_TIPO_CURSO_SP(
        P_TIPO_CURSO_ID => 3,
        P_NOMBRE => 'Curso de Botanica inicial'
    );
END;
/

--PROCEDIMIENTO UPDATE 
CREATE OR REPLACE PROCEDURE ACTUALIZAR_TIPO_CURSO_SP(
    P_TIPO_CURSO_ID IN NUMBER,
    P_NOMBRE IN VARCHAR2
) AS
BEGIN
    UPDATE FIDE_TIPO_CURSO_TB
    SET
        NOMBRE = P_NOMBRE
    WHERE
        TIPO_CURSO_ID = P_TIPO_CURSO_ID;
    COMMIT;
END;
/
--MOSTRAR UPDATE 
BEGIN
    ACTUALIZAR_TIPO_CURSO_SP(
        P_TIPO_CURSO_ID => 3,
        P_NOMBRE => 'Curso Botanica I'
    );
END;
/
--PROCEDIMIENTO DELETE 
CREATE OR REPLACE PROCEDURE ELIMINAR_TIPO_CURSO_SP(
    P_TIPO_CURSO_ID IN NUMBER
) AS
BEGIN
    DELETE FROM FIDE_TIPO_CURSO_TB
    WHERE TIPO_CURSO_ID = P_TIPO_CURSO_ID;
    COMMIT;
END;
/
--MOSTRAR DELETE 
BEGIN
    ELIMINAR_TIPO_CURSO_SP(
        P_TIPO_CURSO_ID => 3
    );
END;
/

--CURSO
--Sequencia de curso
CREATE SEQUENCE FIDE_INGRESAR_CURSO_SEQ
START WITH 1
INCREMENT BY 1; 
--VISUALIZAR SEQUENCIA 
SELECT FIDE_INGRESAR_CURSO_SEQ.NEXTVAL AS SECUENCIA FROM FIDE_CURSO_TB; 

--PROCEDIMIENTO LECTURA 
CREATE OR REPLACE PROCEDURE FIDE_CURSO_TB_OBTENER_SP(P_RESULTADO OUT SYS_REFCURSOR)
AS
BEGIN
    OPEN P_RESULTADO FOR 
        SELECT * FROM FIDE_CURSO_TB;
END FIDE_CURSO_TB_OBTENER_SP;
/

--PROCEDIMIENTO INSERT
CREATE OR REPLACE PROCEDURE FIDE_CURSO_TB_INSERTAR_SP(
    P_NOMBRE IN VARCHAR2,
    P_DESCRIPCION IN VARCHAR2,
    P_FECHA IN DATE,
    P_HORA IN VARCHAR2,
    P_IMAGEN IN VARCHAR2,
    P_PRECIO IN DECIMAL,
    P_CAPACIDAD IN NUMBER,
    P_TIPO_CURSO_ID IN NUMBER,
    P_ESTADO_ID IN NUMBER,
    P_DIRECCION_ID IN NUMBER
) AS
BEGIN
    INSERT INTO AdminDB.FIDE_CURSO_TB (
        CURSO_ID, 
        NOMBRE, 
        DESCRIPCION, 
        FECHA, 
        HORA, 
        IMAGEN, 
        PRECIO, 
        CAPACIDAD, 
        TIPO_CURSO_ID, 
        ESTADO_ID, 
        DIRECCION_ID
    )
    VALUES (
        FIDE_INGRESAR_CURSO_SEQ.NEXTVAL, 
        P_NOMBRE,
        P_DESCRIPCION,
        P_FECHA,
        P_HORA,
        P_IMAGEN,
        P_PRECIO,
        P_CAPACIDAD,
        P_TIPO_CURSO_ID,
        P_ESTADO_ID,
        P_DIRECCION_ID
    );
    COMMIT;
END FIDE_CURSO_TB_INSERTAR_SP;
/

--PROCEDIMIENTO DE UPDATE 
CREATE OR REPLACE PROCEDURE FIDE_CURSO_TB_ACTUALIZAR_SP(
    P_CURSO_ID IN NUMBER,
    P_NOMBRE IN VARCHAR2,
    P_DESCRIPCION IN VARCHAR2,
    P_FECHA IN DATE,
    P_HORA IN VARCHAR2,
    P_IMAGEN IN VARCHAR2,
    P_PRECIO IN DECIMAL,
    P_CAPACIDAD IN NUMBER,
    P_TIPO_CURSO_ID IN NUMBER,
    P_ESTADO_ID IN NUMBER,
    P_DIRECCION_ID IN NUMBER
) AS
BEGIN
    UPDATE FIDE_CURSO_TB
    SET 
        NOMBRE = P_NOMBRE,
        DESCRIPCION = P_DESCRIPCION,
        FECHA = P_FECHA,
        HORA = P_HORA,
        IMAGEN = P_IMAGEN,
        PRECIO = P_PRECIO,
        CAPACIDAD = P_CAPACIDAD,
        TIPO_CURSO_ID = P_TIPO_CURSO_ID,
        ESTADO_ID = P_ESTADO_ID,
        DIRECCION_ID = P_DIRECCION_ID
    WHERE CURSO_ID = P_CURSO_ID;
    COMMIT;
END FIDE_CURSO_TB_ACTUALIZAR_SP;
/

--PROCEDIMIENTO DELETE 
CREATE OR REPLACE PROCEDURE FIDE_CURSO_TB_ELIMINAR_SP(
    P_CURSO_ID IN NUMBER
) AS
BEGIN
    DELETE FROM FIDE_CURSO_TB
    WHERE CURSO_ID = P_CURSO_ID;
    COMMIT;
END FIDE_CURSO_TB_ELIMINAR_SP;
/

-------------------------Procedimientos de la parte de COMPRAS-------------------------------
--Metodo_pago
--Sequencia de Metodo_pago
CREATE SEQUENCE FIDE_INGRESAR_METODO_PAGO_SEQ
START WITH 1
INCREMENT BY 1; 
--VISUALIZAR SEQUENCIA 
SELECT FIDE_INGRESAR_METODO_PAGO_SEQ.NEXTVAL AS SECUENCIA FROM FIDE_METODO_PAGO_TB; 

--PROCEDIMIENTO DE LECTURA 
CREATE OR REPLACE PROCEDURE FIDE_METODO_PAGO_TB_OBTENER_SP(P_RESULTADO OUT SYS_REFCURSOR)
AS
BEGIN
    OPEN P_RESULTADO FOR 
        SELECT * 
        FROM FIDE_METODO_PAGO_TB;
END FIDE_METODO_PAGO_TB_OBTENER_SP;
/

--PROCEDIMIENTO INSERT
CREATE OR REPLACE PROCEDURE FIDE_METODO_PAGO_TB_INSERTAR_SP(
    P_NOMBRE IN VARCHAR2
) AS
BEGIN
    INSERT INTO FIDE_METODO_PAGO_TB (
        METODO_PAGO_ID, 
        NOMBRE
    )
    VALUES (
        FIDE_INGRESAR_METODO_PAGO_SEQ.NEXTVAL, 
        P_NOMBRE
    );
    COMMIT;
END FIDE_METODO_PAGO_TB_INSERTAR_SP;
/
--PROCEDIMIENTO UPDATE 
CREATE OR REPLACE PROCEDURE FIDE_METODO_PAGO_TB_ACTUALIZAR_SP(
    P_METODO_PAGO_ID IN NUMBER,
    P_NOMBRE IN VARCHAR2
) AS
BEGIN
    UPDATE FIDE_METODO_PAGO_TB
    SET 
        NOMBRE = P_NOMBRE
    WHERE METODO_PAGO_ID = P_METODO_PAGO_ID;
    COMMIT;
END FIDE_METODO_PAGO_TB_ACTUALIZAR_SP;
/
--PROCEDIMIENTO DELETE 
CREATE OR REPLACE PROCEDURE FIDE_METODO_PAGO_TB_ELIMINAR_SP(
    P_METODO_PAGO_ID IN NUMBER
) AS
BEGIN
    DELETE FROM FIDE_METODO_PAGO_TB
    WHERE METODO_PAGO_ID = P_METODO_PAGO_ID;
    COMMIT;
END FIDE_METODO_PAGO_TB_ELIMINAR_SP;
/

--DESCUENTO 
--Sequencia dedescuento 
CREATE SEQUENCE FIDE_DESCUENTO_SEQ
START WITH 1
INCREMENT BY 1; 
--VISUALIZAR SEQUENCIA 
SELECT FIDE_DESCUENTO_SEQ.NEXTVAL AS SECUENCIA FROM FIDE_DESCUENTO_TB; 

--PROCEDIMIENTO DE LECTURA 
CREATE OR REPLACE PROCEDURE FIDE_DESCUENTO_TB_OBTENER_SP(P_RESULTADO OUT SYS_REFCURSOR)
AS
BEGIN
    OPEN P_RESULTADO FOR 
        SELECT * FROM FIDE_DESCUENTO_TB;
END FIDE_DESCUENTO_TB_OBTENER_SP;
/

--PROCEDIMIENTO INSERT
CREATE OR REPLACE PROCEDURE FIDE_DESCUENTO_TB_INSERTAR_SP(
    P_NOMBRE IN VARCHAR2,
    P_PORCENTAJE IN DECIMAL
) AS
BEGIN
    INSERT INTO FIDE_DESCUENTO_TB (
        DESCUENTO_ID, 
        NOMBRE, 
        PORCENTAJE
    )
    VALUES (
        FIDE_DESCUENTO_SEQ.NEXTVAL, 
        P_NOMBRE,
        P_PORCENTAJE
    );
    COMMIT;
END FIDE_DESCUENTO_TB_INSERTAR_SP;
/

--PROCEDIMIENTO DE UPDATE 
CREATE OR REPLACE PROCEDURE FIDE_DESCUENTO_TB_ACTUALIZAR_SP(
    P_DESCUENTO_ID IN NUMBER,
    P_NOMBRE IN VARCHAR2,
    P_PORCENTAJE IN DECIMAL
) AS
BEGIN
    UPDATE FIDE_DESCUENTO_TB
    SET 
        NOMBRE = P_NOMBRE,
        PORCENTAJE = P_PORCENTAJE
    WHERE DESCUENTO_ID = P_DESCUENTO_ID;
    COMMIT;
END FIDE_DESCUENTO_TB_ACTUALIZAR_SP;
/

--PROCEDIMEINTO DELETE 
CREATE OR REPLACE PROCEDURE FIDE_DESCUENTO_TB_ELIMINAR_SP(
    P_DESCUENTO_ID IN NUMBER
) AS
BEGIN
    DELETE FROM FIDE_DESCUENTO_TB
    WHERE DESCUENTO_ID = P_DESCUENTO_ID;
    COMMIT;
END FIDE_DESCUENTO_TB_ELIMINAR_SP;
/

--TIPO_COMPRA 
--Sequencia de tipo_compra 
CREATE SEQUENCE FIDE_TIPO_COMPRA_SEQ
START WITH 1
INCREMENT BY 1; 
--VISUALIZAR SEQUENCIA 
SELECT FIDE_TIPO_COMPRA_SEQ.NEXTVAL AS SECUENCIA FROM FIDE_TIPO_COMPRA_TB; 

--PROCEDIMIENTO LECTURA
CREATE OR REPLACE PROCEDURE FIDE_TIPO_COMPRA_TB_OBTENER_SP(P_RESULTADO OUT SYS_REFCURSOR)
AS
BEGIN
    OPEN P_RESULTADO FOR 
        SELECT * FROM FIDE_TIPO_COMPRA_TB;
END FIDE_TIPO_COMPRA_TB_OBTENER_SP;
/

--PROCEDIMIENTO INSERT
CREATE OR REPLACE PROCEDURE FIDE_TIPO_COMPRA_TB_INSERTAR_SP(
    P_PRODUCTO_ID IN NUMBER,
    P_CURSO_ID IN NUMBER,
    P_SERVICIO_ID IN NUMBER
) AS
BEGIN
    INSERT INTO FIDE_TIPO_COMPRA_TB (
        TIPO_COMPRA_ID, 
        PRODUCTO_ID, 
        CURSO_ID, 
        SERVICIO_ID
    )
    VALUES (
        FIDE_TIPO_COMPRA_SEQ.NEXTVAL, 
        P_PRODUCTO_ID,
        P_CURSO_ID,
        P_SERVICIO_ID
    );
    COMMIT;
END FIDE_TIPO_COMPRA_TB_INSERTAR_SP;
/

--PROCEDIMIENTO UPDATE 
CREATE OR REPLACE PROCEDURE FIDE_TIPO_COMPRA_TB_ACTUALIZAR_SP(
    P_TIPO_COMPRA_ID IN NUMBER,
    P_PRODUCTO_ID IN NUMBER,
    P_CURSO_ID IN NUMBER,
    P_SERVICIO_ID IN NUMBER
) AS
BEGIN
    UPDATE FIDE_TIPO_COMPRA_TB
    SET 
        PRODUCTO_ID = P_PRODUCTO_ID,
        CURSO_ID = P_CURSO_ID,
        SERVICIO_ID = P_SERVICIO_ID
    WHERE TIPO_COMPRA_ID = P_TIPO_COMPRA_ID;
    COMMIT;
END FIDE_TIPO_COMPRA_TB_ACTUALIZAR_SP;
/

--PROCEDIMEINTO DELETE 
CREATE OR REPLACE PROCEDURE FIDE_TIPO_COMPRA_TB_ELIMINAR_SP(
    P_TIPO_COMPRA_ID IN NUMBER
) AS
BEGIN
    DELETE FROM FIDE_TIPO_COMPRA_TB
    WHERE TIPO_COMPRA_ID = P_TIPO_COMPRA_ID;
    COMMIT;
END FIDE_TIPO_COMPRA_TB_ELIMINAR_SP;
/

--DETALLE_FACTURA 
--Sequencia de detalle_factura 
CREATE SEQUENCE FIDE_DETALLE_FACTURA_SEQ
START WITH 1
INCREMENT BY 1; 
--VISUALIZAR SEQUENCIA 
SELECT FIDE_DETALLE_FACTURA_SEQ.NEXTVAL AS SECUENCIA FROM FIDE_DETALLE_FACTURA_TB; 

--PROCEDIMIENTO LECTURA
CREATE OR REPLACE PROCEDURE FIDE_DETALLE_FACTURA_TB_OBTENER_SP(P_RESULTADO OUT SYS_REFCURSOR)
AS
BEGIN
    OPEN P_RESULTADO FOR 
        SELECT * FROM FIDE_DETALLE_FACTURA_TB;
END FIDE_DETALLE_FACTURA_TB_OBTENER_SP;
/

--PROCEDIMIENTO INSERT
CREATE OR REPLACE PROCEDURE FIDE_DETALLE_FACTURA_TB_INSERTAR_SP(
    P_CANTIDAD_LINEAS IN NUMBER,
    P_TOTAL_POR_LINEA IN NUMBER,
    P_TIPO_COMPRA_ID IN NUMBER
) AS
BEGIN
    INSERT INTO FIDE_DETALLE_FACTURA_TB (
        DETALLE_FACTURA_ID, 
        CANTIDAD_LINEAS, 
        TOTAL_POR_LINEA, 
        TIPO_COMPRA_ID
    )
    VALUES (
        FIDE_DETALLE_FACTURA_SEQ.NEXTVAL, 
        P_CANTIDAD_LINEAS,
        P_TOTAL_POR_LINEA,
        P_TIPO_COMPRA_ID
    );
    COMMIT;
END FIDE_DETALLE_FACTURA_TB_INSERTAR_SP;
/

--PROCEDIMIENTO UPDATE 
CREATE OR REPLACE PROCEDURE FIDE_DETALLE_FACTURA_TB_ACTUALIZAR_SP(
    P_DETALLE_FACTURA_ID IN NUMBER,
    P_CANTIDAD_LINEAS IN NUMBER,
    P_TOTAL_POR_LINEA IN NUMBER,
    P_TIPO_COMPRA_ID IN NUMBER
) AS
BEGIN
    UPDATE FIDE_DETALLE_FACTURA_TB
    SET 
        CANTIDAD_LINEAS = P_CANTIDAD_LINEAS,
        TOTAL_POR_LINEA = P_TOTAL_POR_LINEA,
        TIPO_COMPRA_ID = P_TIPO_COMPRA_ID
    WHERE DETALLE_FACTURA_ID = P_DETALLE_FACTURA_ID;
    COMMIT;
END FIDE_DETALLE_FACTURA_TB_ACTUALIZAR_SP;
/

--PROCEDIMEITNO DELETE
CREATE OR REPLACE PROCEDURE FIDE_DETALLE_FACTURA_TB_ELIMINAR_SP(
    P_DETALLE_FACTURA_ID IN NUMBER
) AS
BEGIN
    DELETE FROM FIDE_DETALLE_FACTURA_TB
    WHERE DETALLE_FACTURA_ID = P_DETALLE_FACTURA_ID;
    COMMIT;
END FIDE_DETALLE_FACTURA_TB_ELIMINAR_SP;
/

--FACTURA 
--Sequencia de factura 
CREATE SEQUENCE FIDE_FACTURA_SEQ
START WITH 1
INCREMENT BY 1; 
--VISUALIZAR SEQUENCIA 
SELECT FIDE_FACTURA_SEQ.NEXTVAL AS SECUENCIA FROM FIDE_FACTURA_TB; 

--PROCEDIMEINTO LECTURA 
CREATE OR REPLACE PROCEDURE FIDE_FACTURA_TB_OBTENER_SP(P_RESULTADO OUT SYS_REFCURSOR)
AS
BEGIN
    OPEN P_RESULTADO FOR 
        SELECT * FROM FIDE_FACTURA_TB;
END FIDE_FACTURA_TB_OBTENER_SP;
/

--PROCEDIMIENTO INSERT
CREATE OR REPLACE PROCEDURE FIDE_FACTURA_TB_INSERTAR_SP(
    P_USUARIO_ID IN NUMBER,
    P_FECHA IN DATE,
    P_DETALLE_FACTURA_ID IN NUMBER,
    P_CANTIDAD_LINEAS IN NUMBER,
    P_DESCUENTO_ID IN NUMBER,
    P_IVA IN DECIMAL,
    P_SUBTOTAL IN DECIMAL,
    P_MONTO_TOTAL IN DECIMAL,
    P_METODO_PAGO_ID IN NUMBER
) AS
BEGIN
    INSERT INTO FIDE_FACTURA_TB (
        FACTURA_ID, 
        USUARIO_ID, 
        FECHA, 
        DETALLE_FACTURA_ID, 
        CANTIDAD_LINEAS, 
        DESCUENTO_ID, 
        IVA, 
        SUBTOTAL, 
        MONTO_TOTAL, 
        METODO_PAGO_ID
    )
    VALUES (
        FIDE_FACTURA_SEQ.NEXTVAL, 
        P_USUARIO_ID,
        P_FECHA,
        P_DETALLE_FACTURA_ID,
        P_CANTIDAD_LINEAS,
        P_DESCUENTO_ID,
        P_IVA,
        P_SUBTOTAL,
        P_MONTO_TOTAL,
        P_METODO_PAGO_ID
    );
    COMMIT;
END FIDE_FACTURA_TB_INSERTAR_SP;
/

--PROCEDIMIENTO UPDATE 
CREATE OR REPLACE PROCEDURE FIDE_FACTURA_TB_ACTUALIZAR_SP(
    P_FACTURA_ID IN NUMBER,
    P_USUARIO_ID IN NUMBER,
    P_FECHA IN DATE,
    P_DETALLE_FACTURA_ID IN NUMBER,
    P_CANTIDAD_LINEAS IN NUMBER,
    P_DESCUENTO_ID IN NUMBER,
    P_IVA IN DECIMAL,
    P_SUBTOTAL IN DECIMAL,
    P_MONTO_TOTAL IN DECIMAL,
    P_METODO_PAGO_ID IN NUMBER
) AS
BEGIN
    UPDATE FIDE_FACTURA_TB
    SET 
        USUARIO_ID = P_USUARIO_ID,
        FECHA = P_FECHA,
        DETALLE_FACTURA_ID = P_DETALLE_FACTURA_ID,
        CANTIDAD_LINEAS = P_CANTIDAD_LINEAS,
        DESCUENTO_ID = P_DESCUENTO_ID,
        IVA = P_IVA,
        SUBTOTAL = P_SUBTOTAL,
        MONTO_TOTAL = P_MONTO_TOTAL,
        METODO_PAGO_ID = P_METODO_PAGO_ID
    WHERE FACTURA_ID = P_FACTURA_ID;
    COMMIT;
END FIDE_FACTURA_TB_ACTUALIZAR_SP;
/

--PROCEDIMIENTO DELETE
CREATE OR REPLACE PROCEDURE FIDE_FACTURA_TB_ELIMINAR_SP(
    P_FACTURA_ID IN NUMBER
) AS
BEGIN
    DELETE FROM FIDE_FACTURA_TB
    WHERE FACTURA_ID = P_FACTURA_ID;
    COMMIT;
END FIDE_FACTURA_TB_ELIMINAR_SP;
/
