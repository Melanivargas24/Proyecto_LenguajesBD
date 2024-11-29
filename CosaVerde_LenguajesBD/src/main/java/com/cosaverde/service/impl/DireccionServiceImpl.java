/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.cosaverde.service.impl;


import javax.persistence.*;

import com.cosaverde.dao.DireccionDao;
import com.cosaverde.domain.Direccion;
import com.cosaverde.service.DireccionService;
import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.ParameterMode;
import javax.persistence.PersistenceContext;
import javax.persistence.StoredProcedureQuery;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class DireccionServiceImpl implements DireccionService {

    @Autowired
    private DireccionDao direccionDao;

    @PersistenceContext
    private EntityManager entityManager;

    @Override
    @Transactional(readOnly = true)
    public List<Direccion> getDirecciones() {
        StoredProcedureQuery query = entityManager.createStoredProcedureQuery("FIDE_PROCEDIMIENTOS_PKG.FIDE_DIRECCION_TB_OBTENER_SP", Direccion.class);
        query.registerStoredProcedureParameter(1, Class.class, ParameterMode.REF_CURSOR);
        query.execute();
        return query.getResultList();
    }
    

    @Override
    @Transactional(readOnly = true)
    public Direccion getDireccionPorId(Long idDireccion) {
        StoredProcedureQuery query = entityManager.createStoredProcedureQuery("FIDE_PROCEDIMIENTOS_PKG.FIDE_DIRECCION_TB_GET_BY_ID",
                Direccion.class);
        query.registerStoredProcedureParameter(1, Class.class, ParameterMode.REF_CURSOR);
        query.registerStoredProcedureParameter(2, Long.class, ParameterMode.IN);
        query.setParameter(2, idDireccion);
        query.execute();
        List<Direccion> result = query.getResultList();
        return result.isEmpty() ? null : result.get(0);
    }
}