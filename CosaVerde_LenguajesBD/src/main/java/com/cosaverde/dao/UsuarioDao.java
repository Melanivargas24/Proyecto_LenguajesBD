package com.cosaverde.dao;

import org.springframework.data.jpa.repository.JpaRepository;

import com.cosaverde.domain.Usuario;
import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.jpa.repository.query.Procedure;
import org.springframework.data.repository.query.Param;

/**
 *
 * @author sfallas
 */
public interface UsuarioDao extends JpaRepository<Usuario, Long> {

  

    //Usuario findByEmail(String correo);
    
    @Query(value = "SELECT DISTINCT u.* FROM cosaVerde.usuario u " +
            "INNER JOIN cosaVerde.rol r ON u.id_usuario = r.id_usuario " +
            "WHERE r.nombre = :nombreRol", nativeQuery = true)
    List<Usuario> findAllByRolNombre(@Param("nombreRol") String nombreRol);
    
    @Query(value = "SELECT FIDE_USUARIO_TB_VERIFICAR_CREDENCIALES_FN(:correo, :contrasena) FROM dual", nativeQuery = true)
    Integer verificarCredenciales(@Param("correo") String correo, @Param("contrasena") String contrasena);

    @Procedure(procedureName = "INSERTAR_USUARIO_SP")
    void insertarUsuario(
        @Param("P_NOMBRE") String nombre,
        @Param("P_APELLIDO") String apellido,
        @Param("P_CORREO") String correo,
        @Param("P_CONTRASENA") String contrasena,
         @Param("P_USERNAME") String username,
        @Param("P_DIRECCION_ID") Long direccionId,
        @Param("P_ROL_ID") Long rolId,
        @Param("P_ESTADO_ID") Long estadoId
    );

    public Usuario findByCorreo(String correo);
    
}
