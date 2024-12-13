/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.cosaverde.service.impl;



import com.cosaverde.dao.DireccionDao;
import com.cosaverde.domain.Canton;
import com.cosaverde.domain.Direccion;
import com.cosaverde.domain.Distrito;
import com.cosaverde.domain.Provincia;
import com.cosaverde.service.DireccionService;
import jakarta.persistence.EntityManager;
import jakarta.persistence.ParameterMode;
import jakarta.persistence.PersistenceContext;
import jakarta.persistence.StoredProcedureQuery;
import java.util.List;
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
    
 @Override
    public void save(Direccion direccion) {
        direccionDao.save(direccion);
    }

    public Provincia findProvincia(Long provinciaId) {
        return entityManager.find(Provincia.class, provinciaId);

    }

    public Canton findCanton(Long cantonId) {
        return entityManager.find(Canton.class, cantonId);
    }

    public Distrito findDistrito(Long distritoId) {
        return entityManager.find(Distrito.class, distritoId);
    }

}
