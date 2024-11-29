/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.cosaverde.service.impl;


import javax.persistence.*;

import com.cosaverde.dao.EstadoDao;
import com.cosaverde.domain.Estado;
import com.cosaverde.service.EstadoService;
import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.ParameterMode;
import javax.persistence.PersistenceContext;
import javax.persistence.StoredProcedureQuery;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class EstadoServiceImpl implements EstadoService {

    @Autowired
    private EstadoDao estadoDao;

    @PersistenceContext
    private EntityManager entityManager;

    @Override
    @Transactional(readOnly = true)
    public List<Estado> getEstados() {
        StoredProcedureQuery query = entityManager.createStoredProcedureQuery("FIDE_PROCEDIMIENTOS_PKG.FIDE_ESTADO_TB_OBTENER_SP", Estado.class);
        query.registerStoredProcedureParameter(1, Class.class, ParameterMode.REF_CURSOR);
        query.execute();
        return query.getResultList();
    }
    

    @Override
    @Transactional(readOnly = true)
    public Estado getEstadoPorId(Long idEstado) {
        StoredProcedureQuery query = entityManager.createStoredProcedureQuery("FIDE_PROCEDIMIENTOS_PKG.FIDE_ESTADO_TB_GET_BY_ID",
                Estado.class);
        query.registerStoredProcedureParameter(1, Class.class, ParameterMode.REF_CURSOR);
        query.registerStoredProcedureParameter(2, Long.class, ParameterMode.IN);
        query.setParameter(2, idEstado);
        query.execute();
        List<Estado> result = query.getResultList();
        return result.isEmpty() ? null : result.get(0);
    }
}