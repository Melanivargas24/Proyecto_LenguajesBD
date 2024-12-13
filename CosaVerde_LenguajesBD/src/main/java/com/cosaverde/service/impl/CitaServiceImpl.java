package com.cosaverde.service.impl;

import com.cosaverde.dao.CitaDao;
import com.cosaverde.domain.Cita;
import com.cosaverde.service.CitaService;
import jakarta.persistence.EntityManager;
import jakarta.persistence.ParameterMode;
import jakarta.persistence.PersistenceContext;
import jakarta.persistence.StoredProcedureQuery;
import java.util.Date;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class CitaServiceImpl implements CitaService {

    @Autowired
    private CitaDao citaDao;

    @PersistenceContext
    private EntityManager entityManager;

    @Override
    @Transactional(readOnly = true)
    public List<Cita> getCitas() {
        StoredProcedureQuery query = entityManager.createStoredProcedureQuery("FIDE_PROCEDIMIENTOS_PKG.FIDE_CITA_TB_OBTENER_SP", Cita.class);
        query.registerStoredProcedureParameter(1, void.class, ParameterMode.REF_CURSOR);
        query.execute();
        return query.getResultList();
    }
    

    @Override
    @Transactional(readOnly = true)
    public Cita getCitaPorId(Long idCita) {
        StoredProcedureQuery query = entityManager.createStoredProcedureQuery("FIDE_PROCEDIMIENTOS_PKG.FIDE_CITA_TB_GET_BY_ID",
                Cita.class);
        query.registerStoredProcedureParameter(1, void.class, ParameterMode.REF_CURSOR);
        query.registerStoredProcedureParameter(2, Long.class, ParameterMode.IN);
        query.setParameter(2, idCita);
        query.execute();
        List<Cita> result = query.getResultList();
        return result.isEmpty() ? null : result.get(0);
    }
    
@Override
@Transactional
public void crearCita(Date fecha, String hora, Long idEstado, Long idServicio, Long idUsuario) {
    StoredProcedureQuery query = entityManager.createStoredProcedureQuery("FIDE_PROCEDIMIENTOS_PKG.FIDE_INSERTAR_CITA_SP");
    
    query.registerStoredProcedureParameter(1, Long.class, ParameterMode.IN);  
    query.registerStoredProcedureParameter(2, Long.class, ParameterMode.IN); 
    query.registerStoredProcedureParameter(3, Long.class, ParameterMode.IN);  
    query.registerStoredProcedureParameter(4, Date.class, ParameterMode.IN);  
    query.registerStoredProcedureParameter(5, String.class, ParameterMode.IN); 
    
    query.setParameter(1, idUsuario);  
    query.setParameter(2, idServicio);   
    query.setParameter(3, idEstado);    
    query.setParameter(4, fecha);        
    query.setParameter(5, hora);       
    
    query.execute();
}


    @Override
    @Transactional
    public void actualizarCita(Long idCita, Date fecha, String hora, Long idEstado, Long idServicio, Long idUsuario) {
        StoredProcedureQuery query = entityManager.createStoredProcedureQuery("FIDE_PROCEDIMIENTOS_PKG.FIDE_CITA_ACTUALIZAR_SP");
        query.registerStoredProcedureParameter(1, Long.class, ParameterMode.IN);
        query.registerStoredProcedureParameter(2, Date.class, ParameterMode.IN);
        query.registerStoredProcedureParameter(3, String.class, ParameterMode.IN);
        query.registerStoredProcedureParameter(4, Long.class, ParameterMode.IN);
        query.registerStoredProcedureParameter(5, Long.class, ParameterMode.IN);
        query.registerStoredProcedureParameter(6, Long.class, ParameterMode.IN);
        query.setParameter(1, idCita);
        query.setParameter(2, fecha);
        query.setParameter(3, hora);
        query.setParameter(4, idEstado);
        query.setParameter(5, idServicio);
        query.setParameter(6, idUsuario);
        query.execute();
    }

    @Override
    @Transactional
    public void eliminarCita(Long idCita) {
       entityManager.createStoredProcedureQuery("FIDE_PROCEDIMIENTOS_PKG.FIDE_CITA_ELIMINAR_SP")
        .registerStoredProcedureParameter("P_CITA_ID", Long.class, ParameterMode.IN)
                .setParameter("P_CITA_ID", idCita)
                .execute();
    }
    

}
