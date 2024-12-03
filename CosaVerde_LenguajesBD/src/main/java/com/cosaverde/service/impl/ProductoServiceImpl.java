package com.cosaverde.service.impl;

import java.util.ArrayList;
import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.ParameterMode;
import javax.persistence.PersistenceContext;
import javax.persistence.StoredProcedureQuery;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.cosaverde.dao.ProductoDao;
import com.cosaverde.domain.Producto;
import com.cosaverde.service.ProductoService;

@Service
public class ProductoServiceImpl implements ProductoService {

    @Autowired
    private ProductoDao productoDao;

    @PersistenceContext
    private EntityManager entityManager;

    @Override
    @Transactional(readOnly = true)
    public List<Producto> getProductos() {
        StoredProcedureQuery query = entityManager.createStoredProcedureQuery("FIDE_PROCEDIMIENTOS_PKG.FIDE_PRODUCTO_TB_OBTENER_SP", Producto.class);
        query.registerStoredProcedureParameter(1, Class.class, ParameterMode.REF_CURSOR);
        query.execute();
        return query.getResultList();
    }


    @Override
    @Transactional(readOnly = true)
    public Producto getProductoPorId(Long idProducto) {
        StoredProcedureQuery query = entityManager.createStoredProcedureQuery("FIDE_PROCEDIMIENTOS_PKG.FIDE_PRODUCTO_TB_GET_BY_ID", Producto.class);
        query.registerStoredProcedureParameter(1, Class.class, ParameterMode.REF_CURSOR);
        query.registerStoredProcedureParameter(2, Long.class, ParameterMode.IN);
        query.setParameter(2, idProducto);
        query.execute();
        List<Producto> result = query.getResultList();
        return result.isEmpty() ? null : result.get(0);
    }
    
   

    @Override
    @Transactional
    public void insertarProducto(String nombre, String descripcion, String imagen, double precio_unit, Long idCategoria) {
        StoredProcedureQuery query = entityManager.createStoredProcedureQuery("FIDE_PROCEDIMIENTOS_PKG.FIDE_PRODUCTO_TB_INSERTAR_SP");
        query.registerStoredProcedureParameter(1, String.class, ParameterMode.IN);
        query.registerStoredProcedureParameter(2, String.class, ParameterMode.IN);
        query.registerStoredProcedureParameter(3, String.class, ParameterMode.IN);
        query.registerStoredProcedureParameter(4, Double.class, ParameterMode.IN);
        query.registerStoredProcedureParameter(5, Long.class, ParameterMode.IN);
        query.setParameter(1, nombre);
        query.setParameter(2, descripcion);
        query.setParameter(3, imagen);
        query.setParameter(4, precio_unit);
        query.setParameter(5, idCategoria);
        query.execute();
    }

    @Override
    @Transactional
    public void actualizarProducto(Long idProducto, String nombre, String descripcion, String imagen, double precio_unit, Long idCategoria) {
        StoredProcedureQuery query = entityManager.createStoredProcedureQuery("FIDE_PROCEDIMIENTOS_PKG.FIDE_PRODUCTO_ACTUALIZAR_SP");
        query.registerStoredProcedureParameter(1, Long.class, ParameterMode.IN);
        query.registerStoredProcedureParameter(2, String.class, ParameterMode.IN);
        query.registerStoredProcedureParameter(3, String.class, ParameterMode.IN);
        query.registerStoredProcedureParameter(4, String.class, ParameterMode.IN);
        query.registerStoredProcedureParameter(5, Double.class, ParameterMode.IN);
        query.registerStoredProcedureParameter(6, Long.class, ParameterMode.IN);
        query.setParameter(1, idProducto);
        query.setParameter(2, nombre);
        query.setParameter(3, descripcion);
        query.setParameter(4, imagen);
        query.setParameter(5, precio_unit);
        query.setParameter(6, idCategoria);
        query.execute();
    }

    @Override
    @Transactional
    public void eliminarProducto(Long idProducto) {
       entityManager.createStoredProcedureQuery("FIDE_PROCEDIMIENTOS_PKG.FIDE_PRODUCTO_ELIMINAR_SP")
        .registerStoredProcedureParameter("P_PRODUCTO_ID", Long.class, ParameterMode.IN)
                .setParameter("P_PRODUCTO_ID", idProducto)
                .execute();
    }
    

}