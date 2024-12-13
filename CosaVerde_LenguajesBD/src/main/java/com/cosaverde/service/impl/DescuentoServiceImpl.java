/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.cosaverde.service.impl;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.cosaverde.service.DescuentoService;
import com.cosaverde.dao.DescuentoDao;
import com.cosaverde.domain.Descuento;
import jakarta.persistence.EntityManager;
import jakarta.persistence.ParameterMode;
import jakarta.persistence.PersistenceContext;
import jakarta.persistence.StoredProcedureQuery;


@Service
public class DescuentoServiceImpl implements DescuentoService {

    @Autowired
    private DescuentoDao descuentoDao;

    @PersistenceContext
    private EntityManager entityManager;

    @Override
    @Transactional(readOnly = true)
    public List<Descuento> getDescuentos() {
        StoredProcedureQuery query = entityManager
                .createStoredProcedureQuery("FIDE_PROCEDIMIENTOS_PKG.FIDE_DESCUENTO_TB_OBTENER_SP", Descuento.class);
        query.registerStoredProcedureParameter(1, Class.class, ParameterMode.REF_CURSOR);
        query.execute();
        return query.getResultList();
    }


    @Override
    @Transactional(readOnly = true)
    public Descuento getDescuentoPorId(Long idDescuento) {
        StoredProcedureQuery query = entityManager.createStoredProcedureQuery("FIDE_PROCEDIMIENTOS_PKG.FIDE_DESCUENTO_TB_GET_BY_ID", Descuento.class);
        query.registerStoredProcedureParameter(1, Class.class, ParameterMode.REF_CURSOR);
        query.registerStoredProcedureParameter(2, Long.class, ParameterMode.IN);
        query.setParameter(2, idDescuento);
        query.execute();
        List<Descuento> result = query.getResultList();
        return result.isEmpty() ? null : result.get(0);
    }

    @Override
    public void crearDescuento(String nombre, int porcentaje, String estado) {
       StoredProcedureQuery query = entityManager.createStoredProcedureQuery("FIDE_PROCEDIMIENTOS_PKG.FIDE_DESCUENTO_TB_INSERTAR_SP");
            query.registerStoredProcedureParameter(1, String.class, ParameterMode.IN);
            query.registerStoredProcedureParameter(2, Integer.class, ParameterMode.IN);
             query.registerStoredProcedureParameter(3, String.class, ParameterMode.IN);
            
            query.setParameter(1, nombre);
            query.setParameter(2, porcentaje);
            query.setParameter(3, estado);
            query.execute();
    }

    @Override
    @Transactional
    public void actualizarDescuento(Descuento descuento) {
        StoredProcedureQuery query = entityManager.createStoredProcedureQuery("FIDE_PROCEDIMIENTOS_PKG.FIDE_DESCUENTO_TB_ACTUALIZAR_SP");
        query.registerStoredProcedureParameter("P_DESCUENTO_ID", Long.class, ParameterMode.IN);
        query.registerStoredProcedureParameter("P_NOMBRE", String.class, ParameterMode.IN);
        query.registerStoredProcedureParameter("P_PORCENTAJE", Integer.class, ParameterMode.IN);
        query.registerStoredProcedureParameter("P_ESTADO", String.class, ParameterMode.IN);

        query.setParameter("P_DESCUENTO_ID", descuento.getIdDescuento());
        query.setParameter("P_NOMBRE", descuento.getNombre());
        query.setParameter("P_PORCENTAJE", descuento.getPorcentaje());
        query.setParameter("P_ESTADO", descuento.getEstado());

        query.execute();
    }

    @Override
    @Transactional
    public void eliminarDescuento(Long idDescuento) {
        entityManager.createStoredProcedureQuery("FIDE_PROCEDIMIENTOS_PKG.FIDE_DESCUENTO_TB_ELIMINAR_SP")
                .registerStoredProcedureParameter("P_DESCUENTO_ID", Long.class, ParameterMode.IN)
                .setParameter("P_DESCUENTO_ID", idDescuento)
                .execute();
    }

}
