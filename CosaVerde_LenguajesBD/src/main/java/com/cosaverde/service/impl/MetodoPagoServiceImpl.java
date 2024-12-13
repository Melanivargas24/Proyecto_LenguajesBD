package com.cosaverde.service.impl;

import com.cosaverde.dao.MetodoPagoDao;
import com.cosaverde.domain.MetodoPago;
import com.cosaverde.service.MetodoPagoService;
import jakarta.persistence.EntityManager;
import jakarta.persistence.ParameterMode;
import jakarta.persistence.PersistenceContext;
import jakarta.persistence.StoredProcedureQuery;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class MetodoPagoServiceImpl implements MetodoPagoService {

    @Autowired
    private MetodoPagoDao metodoDao;

    @PersistenceContext
    private EntityManager entityManager;

    @Override
    @Transactional(readOnly = true)
    public List<MetodoPago> getMetodos() {
        StoredProcedureQuery query = entityManager.createStoredProcedureQuery("FIDE_CARRITO_PKG.FIDE_METODO_PAGO_TB_OBTENER_SP", MetodoPago.class);
        query.registerStoredProcedureParameter(1, Class.class, ParameterMode.REF_CURSOR);
        query.execute();
        return query.getResultList();
    }
}
    