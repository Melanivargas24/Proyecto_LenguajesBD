package com.cosaverde.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.cosaverde.dao.InventarioDao;
import com.cosaverde.domain.Inventario;
import com.cosaverde.service.InventarioService;
import java.math.BigDecimal;
import java.util.Date;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.ParameterMode;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import javax.persistence.StoredProcedureQuery;

@Service
public class InventarioServiceImpl implements InventarioService {
    @Autowired
    private InventarioDao inventarioDao;

    @PersistenceContext
    private EntityManager entityManager;

    @Override
    @Transactional(readOnly = true)
    public List<Inventario> getInventario() {
        StoredProcedureQuery query = entityManager.createStoredProcedureQuery("FIDE_PROCEDIMIENTOS_PKG.FIDE_INVENTARIO_TB_OBTENER_SP", Inventario.class);
        query.registerStoredProcedureParameter(1, Class.class, ParameterMode.REF_CURSOR);
        query.execute();
        return query.getResultList();
    }
  
    
    @Override
    @Transactional(readOnly = true)
    public Inventario getInventarioPorId(Long idInventario) {

        StoredProcedureQuery query = entityManager.createStoredProcedureQuery("FIDE_PROCEDIMIENTOS_PKG.FIDE_INVENTARIO_TB_GET_BY_ID",
                Inventario.class);
        query.registerStoredProcedureParameter(1, Class.class, ParameterMode.REF_CURSOR);
        query.registerStoredProcedureParameter(2, Long.class, ParameterMode.IN);
        query.setParameter(2, idInventario);
        query.execute();
        List<Inventario> result = query.getResultList();
        return result.isEmpty() ? null : result.get(0);
    }
    

    @Override
    @Transactional
    public void insertarInventario(int stock, Date fechaVencimiento, int diasEnStock, double precioUnit, 
            Long idEstado, Long idProducto) {
        StoredProcedureQuery query = entityManager.createStoredProcedureQuery("FIDE_PROCEDIMIENTOS_PKG.FIDE_INVENTARIO_TB_INSERT_SP");
        query.registerStoredProcedureParameter(1, Integer.class, ParameterMode.IN);
        query.registerStoredProcedureParameter(2, Date.class, ParameterMode.IN);
        query.registerStoredProcedureParameter(3, Integer.class, ParameterMode.IN);
        query.registerStoredProcedureParameter(4, Double.class, ParameterMode.IN);
        query.registerStoredProcedureParameter(5, Long.class, ParameterMode.IN);
        query.registerStoredProcedureParameter(6, Long.class, ParameterMode.IN);
        query.setParameter(1, stock);
        query.setParameter(2, fechaVencimiento);
        query.setParameter(3, diasEnStock);
        query.setParameter(4, precioUnit);
        query.setParameter(5, idEstado);
        query.setParameter(6, idProducto);
        query.execute();
    }
    

    @Override
    @Transactional
    public void actualizarInventario(Long idInventario, int stock, Date fechaVencimiento, int diasEnStock, 
            double precioUnit, Long idEstado, Long idProducto) {
        StoredProcedureQuery query = entityManager.createStoredProcedureQuery("FIDE_PROCEDIMIENTOS_PKG.FIDE_INVENTARIO_TB_ACTUALIZAR_SP");
        query.registerStoredProcedureParameter(1, Long.class, ParameterMode.IN);
        query.registerStoredProcedureParameter(2, Integer.class, ParameterMode.IN);
        query.registerStoredProcedureParameter(3, Date.class, ParameterMode.IN);
        query.registerStoredProcedureParameter(4, Integer.class, ParameterMode.IN);
        query.registerStoredProcedureParameter(5, Double.class, ParameterMode.IN);
        query.registerStoredProcedureParameter(6, Long.class, ParameterMode.IN);
        query.registerStoredProcedureParameter(7, Long.class, ParameterMode.IN);
        query.setParameter(1, idInventario);
        query.setParameter(2, stock);
        query.setParameter(3, fechaVencimiento);
        query.setParameter(4, diasEnStock);
        query.setParameter(5, precioUnit);
        query.setParameter(6, idEstado);
        query.setParameter(7, idProducto);
        query.execute();
    }
    
      @Override
    @Transactional
    public void eliminarInventario(Long idInventario) {
        entityManager.createStoredProcedureQuery("FIDE_PROCEDIMIENTOS_PKG.FIDE_INVENTARIO_TB_ELIMINAR_SP")
               .registerStoredProcedureParameter("P_INVENTARIO_ID", Long.class, ParameterMode.IN)
                .setParameter("P_INVENTARIO_ID", idInventario)
                .execute();
    }
 
    @Override
    @Transactional
    public Double obtenerTotalInventario() {
        Query query = entityManager.createNativeQuery("SELECT FIDE_INVENTARIO_TOTAL_PRODUCTOS_FN FROM dual");
        BigDecimal result = (BigDecimal) query.getSingleResult(); 
        return result.doubleValue();  
    }



}
