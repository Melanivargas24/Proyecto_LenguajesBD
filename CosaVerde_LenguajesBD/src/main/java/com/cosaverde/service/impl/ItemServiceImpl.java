
package com.cosaverde.service.impl;


import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Service;
import com.cosaverde.domain.Carrito;
import com.cosaverde.domain.Item;
import com.cosaverde.service.ItemService;
import com.cosaverde.domain.Usuario;
import static com.cosaverde.service.ItemService.listaItems;
import com.cosaverde.service.UsuarioService;
import jakarta.persistence.EntityManager;
import jakarta.persistence.ParameterMode;
import jakarta.persistence.PersistenceContext;
import jakarta.persistence.StoredProcedureQuery;
import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.namedparam.MapSqlParameterSource;
import org.springframework.jdbc.core.namedparam.SqlParameterSource;
import org.springframework.jdbc.core.simple.SimpleJdbcCall;
import org.springframework.transaction.annotation.Transactional;

@Service
public class ItemServiceImpl implements ItemService {
    
    @Autowired
    UsuarioService usuarioService;
    
      @Autowired
    private JdbcTemplate jdbcTemplate;
      
      @PersistenceContext
    private EntityManager entityManager;
      
       @Override
    public List<Item> gets() {
        return listaItems;
    }

    // En el ServiceImpl
    @Override
    @Transactional(readOnly = true)
    public List<Carrito> getProductos() {
         StoredProcedureQuery query = entityManager.createStoredProcedureQuery("FIDE_CARRITO_PKG.FIDE_CARRITO_TB_OBTENER_SP", Carrito.class);
        query.registerStoredProcedureParameter(1, Class.class, ParameterMode.REF_CURSOR);
        query.execute();
        return query.getResultList();
    }
    
    
    

    @Override
   public void save(Item item) {
        // Obtener el usuario autenticado
        String username;
        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        if (principal instanceof UserDetails userDetails) {
            username = userDetails.getUsername();
        } else {
            username = principal.toString();
        }

        if (username.isBlank()) {
            throw new IllegalStateException("No hay usuario autenticado");
        }

        Usuario usuario = usuarioService.getUsuarioPorUsername(username);
        if (usuario == null) {
            throw new IllegalStateException("Usuario no encontrado");
        }

        try {
            // Configurar SimpleJdbcCall para ejecutar el procedimiento almacenado con el paquete
            SimpleJdbcCall simpleJdbcCall = new SimpleJdbcCall(jdbcTemplate)
                    .withCatalogName("FIDE_PROCEDIMIENTOS_PKG") // Nombre del paquete
                    .withProcedureName("FIDE_AGREGAR_PRODUCTO_CARRITO_SP"); // Nombre del procedimiento

            // Preparar los parámetros de entrada
            SqlParameterSource parametros = new MapSqlParameterSource()
                    .addValue("p_usuario_id", usuario.getIdUsuario())
                    .addValue("p_producto_id", item.getIdProducto())
                    .addValue("p_cantidad", 1); // Siempre agregar 1

            // Ejecutar el procedimiento
            simpleJdbcCall.execute(parametros);

        } catch (DataAccessException e) {
            String mensajeError = e.getMessage();
            if (mensajeError.contains("Stock insuficiente")) {
            throw new IllegalStateException("No hay suficiente stock para este producto");
        } else if (mensajeError.contains("Producto no encontrado")) {
            throw new IllegalStateException("El producto no existe en el inventario");
        } else {
            throw new RuntimeException("Error al agregar producto al carrito", e);
        }
    }
}
    
    @Override
public void generarFactura(Long metodoPagoId) {
        // Obtener el usuario autenticado desde el SecurityContext
        String username;
        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        if (principal instanceof UserDetails userDetails) {
            username = userDetails.getUsername();
        } else {
            username = principal.toString();
        }

        if (username.isBlank()) {
            throw new IllegalStateException("No hay usuario autenticado");
        }

        // Obtener el usuario desde el servicio
        Usuario usuario = usuarioService.getUsuarioPorUsername(username);
        if (usuario == null) {
            throw new IllegalStateException("Usuario no encontrado");
        }
        // Llamada al procedimiento almacenado GENERAR_FACTURA
        try {
            SimpleJdbcCall simpleJdbcCall = new SimpleJdbcCall(jdbcTemplate)
                    .withCatalogName("FIDE_PROCEDIMIENTOS_PKG")
                    .withProcedureName("FIDE_GENERAR_FACTURA_SP");

            SqlParameterSource parametros = new MapSqlParameterSource()
                    .addValue("p_usuario_id", usuario.getIdUsuario()) // Usar el id del usuario autenticado
                    .addValue("p_metodo_pago_id", metodoPagoId);

            simpleJdbcCall.execute(parametros);
        } catch (Exception e) {
            throw new RuntimeException("Error al generar la factura: " + e.getMessage(), e);
        }
    }

}
