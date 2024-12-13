/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.cosaverde.service.impl;


import com.cosaverde.dao.RolDao;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.cosaverde.dao.UsuarioDao;
import com.cosaverde.domain.Distrito;
import com.cosaverde.domain.Estado;
import com.cosaverde.domain.Rol;
import com.cosaverde.domain.Usuario;
import com.cosaverde.service.UsuarioService;
import jakarta.persistence.EntityManager;
import jakarta.persistence.ParameterMode;
import jakarta.persistence.PersistenceContext;
import jakarta.persistence.StoredProcedureQuery;
import java.util.Map;
import javax.sql.DataSource;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.simple.SimpleJdbcCall;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

@Service
public class UsuarioServiceImpl implements UsuarioService {

    @Autowired
    private RolDao rolDao;

    @Autowired
    private UsuarioDao usuarioDao;
    
     @Autowired
    private JdbcTemplate jdbcTemplate;

    @PersistenceContext
    private EntityManager entityManager;

    @Transactional(readOnly = true)
    @Override
    public List<Usuario> getUsuarios() {
        StoredProcedureQuery query = entityManager.createStoredProcedureQuery("FIDE_PROCEDIMIENTOS_PKG.FIDE_USUARIO_TB_OBTENER_SP", Usuario.class);
        query.registerStoredProcedureParameter(1, Class.class, ParameterMode.REF_CURSOR);
        query.execute();
        return query.getResultList();
    }

    @Transactional(readOnly = true)
    @Override
    public Usuario getUsuarioPorId(Long idUsuario) {
        StoredProcedureQuery query = entityManager.createStoredProcedureQuery("FIDE_PROCEDIMIENTOS_PKG.FIDE_USUARIO_TB_GET_BY_ID", Usuario.class);
        query.registerStoredProcedureParameter(1, Class.class, ParameterMode.REF_CURSOR);
        query.registerStoredProcedureParameter(2, Long.class, ParameterMode.IN);
        query.setParameter(2, idUsuario);
        query.execute();
        List<Usuario> result = query.getResultList();
        return result.isEmpty() ? null : result.get(0);
    }

    @Transactional
    @Override
    public void registrarUsuario(String nombre, String apellido, String correo, String contrasena, String username,
            Long direccionId, Long rolId, Long idEstado) {
        StoredProcedureQuery query = entityManager.createStoredProcedureQuery("FIDE_PROCEDIMIENTOS_PKG.FIDE_USUARIO_TB_INSERTAR_SP");

        // Registrar parámetros del procedimiento
        query.registerStoredProcedureParameter(1, String.class, ParameterMode.IN);  // P_NOMBRE
        query.registerStoredProcedureParameter(2, String.class, ParameterMode.IN);  // P_APELLIDO
        query.registerStoredProcedureParameter(3, String.class, ParameterMode.IN);  // P_CORREO
        query.registerStoredProcedureParameter(4, String.class, ParameterMode.IN);  // P_CONTRASENA
        query.registerStoredProcedureParameter(5, String.class, ParameterMode.IN);  // P_USERNAME
        query.registerStoredProcedureParameter(6, Long.class, ParameterMode.IN);    // P_DIRECCION_ID
        query.registerStoredProcedureParameter(7, Long.class, ParameterMode.IN);    // P_ROL_ID
        query.registerStoredProcedureParameter(8, Long.class, ParameterMode.IN);    // P_ESTADO_ID

        // Establecer los valores para cada parámetro
        query.setParameter(1, nombre);
        query.setParameter(2, apellido);
        query.setParameter(3, correo);
        query.setParameter(4, contrasena);
         query.setParameter(5, username);
        query.setParameter(6, direccionId);
        query.setParameter(7, rolId);
        query.setParameter(8, idEstado);

        // Ejecutar el procedimiento almacenado
        query.execute();
    }

    @Transactional
    @Override
    public void actualizarUsuario(Long idUsuario, String nombre, String apellido, Long rolId) {
        entityManager.createNativeQuery("CALL FIDE_PROCEDIMIENTOS_PKG.FIDE_USUARIO_TB_ACTUALIZAR_SP(:idUsuario, :nombre, :apellido, :rolId)")
                .setParameter("idUsuario", idUsuario)
                .setParameter("nombre", nombre)
                .setParameter("apellido", apellido)
                .setParameter("rolId", rolId)
                .executeUpdate();
    }

    @Override
    @Transactional
    public void eliminarUsuario(Long idUsuario) {
        StoredProcedureQuery query = entityManager.createStoredProcedureQuery("FIDE_PROCEDIMIENTOS_PKG.FIDE_USUARIO_TB_ELIMINAR_SP");
        query.registerStoredProcedureParameter("P_USUARIO_ID", Long.class, ParameterMode.IN);
        query.setParameter("P_USUARIO_ID", idUsuario);
        query.execute();
    }

    @Transactional(readOnly = true)
    @Override
    public boolean verificarUsuarioActivo(Long idUsuario) {
        StoredProcedureQuery query = entityManager.createStoredProcedureQuery("FIDE_USUARIO_TB_VERIFICAR_ACTIVO_FN");
        query.registerStoredProcedureParameter(1, Long.class, ParameterMode.IN);
        query.registerStoredProcedureParameter(2, Integer.class, ParameterMode.OUT);
        query.setParameter(1, idUsuario);
        query.execute();
        Integer result = (Integer) query.getOutputParameterValue(2);
        return result != null && result == 1;
    }

    @Transactional(readOnly = true)
    @Override
    public String obtenerNombreCompleto(Long idUsuario) {
        StoredProcedureQuery query = entityManager.createStoredProcedureQuery("FIDE_USUARIO_TB_OBTENER_NOMBRE_COMPLETO_FN");
        query.registerStoredProcedureParameter(1, Long.class, ParameterMode.IN);
        query.registerStoredProcedureParameter(2, String.class, ParameterMode.OUT);
        query.setParameter(1, idUsuario);
        query.execute();
        return (String) query.getOutputParameterValue(2);
    }

    @Override
    public boolean verificarCredenciales(String correo, String contrasena) {
        Integer resultado = usuarioDao.verificarCredenciales(correo, contrasena);
        return resultado == 1;

    }

    @Transactional
    public void delete(Usuario usuario) {//Elimina el usuario del todo 
        usuarioDao.delete(usuario);
    }

    public void save(Usuario usuario, boolean crearRolUser) {
        // Guardar el usuario en la base de datos
        usuario = usuarioDao.save(usuario);

        if (crearRolUser) {
            // Crear y asignar el rol predeterminado "Usuario"
            Rol rol = new Rol();
            rol.setNombre("Usuario"); // Nombre del rol por defecto
            usuario.setIdUsuario(usuario.getIdUsuario()); // Asociar el rol con el usuario recién creado
            rolDao.save(rol); // Guardar el rol en la base de datos
        }
    }

    @Transactional
    @Override
    public void save(Usuario usuario) {
        usuarioDao.save(usuario);
    }

    @Override
    public Rol getRolById(Long rolId) {
        return rolDao.findById(rolId)
                .orElseThrow(() -> new RuntimeException("Rol no encontrado"));
    }

    @Override
    public Estado getEstadoById(Long idEstado) {
        return entityManager.find(Estado.class, idEstado);
    }

    @Override
    public Usuario obtenerUsuarioPorCorreo(String correo) {
        return usuarioDao.findByCorreo(correo);
    }
    
        @Override
    @Transactional(readOnly = true)
    public Usuario getUsuarioPorUsername(String username) {
        // Configurar y ejecutar la función
        SimpleJdbcCall simpleJdbcCall = new SimpleJdbcCall(jdbcTemplate)
                .withCatalogName("FIDE_FUNCIONES_PKG")
                .withFunctionName("FIDE_USUARIO_POR_NAME_FN")
                .returningResultSet("CDATOS", (rs, rowNum) -> {
                    Usuario usuario = new Usuario();
                    usuario.setIdUsuario(rs.getLong("usuario_id"));
                    usuario.setNombre(rs.getString("nombre"));
                    usuario.setApellidos(rs.getString("apellido"));
                    usuario.setCorreo(rs.getString("correo"));
                    usuario.setContrasena(rs.getString("contrasena"));
                    usuario.setUsername(rs.getString("username"));
                    return usuario;
                });

        // Ejecutar la función y obtener el cursor
        Map<String, Object> out = simpleJdbcCall.execute(Map.of("user_name", username));

        // Retornar el primer usuario encontrado o null
        return ((List<Usuario>) out.get("CDATOS")).stream().findFirst().orElse(null);
        
    }

}
