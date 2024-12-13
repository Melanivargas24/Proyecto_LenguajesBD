package com.cosaverde.service.impl;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.cosaverde.service.ServicioService;
import com.cosaverde.dao.ServicioDao;
import com.cosaverde.domain.Servicio;
import jakarta.persistence.EntityManager;
import jakarta.persistence.ParameterMode;
import jakarta.persistence.PersistenceContext;
import jakarta.persistence.StoredProcedureQuery;

@Service
public class ServicioServiceImpl implements ServicioService {

    @Autowired
    private ServicioDao ServicioDao;

    @PersistenceContext
    private EntityManager entityManager;

    @Override
    @Transactional(readOnly = true)
    public List<Servicio> getServicios() {
        StoredProcedureQuery query = entityManager
                .createStoredProcedureQuery("FIDE_PROCEDIMIENTOS_PKG.FIDE_SERVICIO_TB_OBTENER_SP", Servicio.class);
        query.registerStoredProcedureParameter(1, Class.class, ParameterMode.REF_CURSOR);
        query.execute();
        return query.getResultList();
    }


    @Override
    @Transactional(readOnly = true)
    public Servicio getServicioPorId(Long idServicio) {
        StoredProcedureQuery query = entityManager.createStoredProcedureQuery("FIDE_PROCEDIMIENTOS_PKG.FIDE_SERVICIO_TB_GET_BY_ID", Servicio.class);
        query.registerStoredProcedureParameter(1, Class.class, ParameterMode.REF_CURSOR);
        query.registerStoredProcedureParameter(2, Long.class, ParameterMode.IN);
        query.setParameter(2, idServicio);
        query.execute();
        List<Servicio> result = query.getResultList();
        return result.isEmpty() ? null : result.get(0);
    }

    @Override
    public void crearServicio(String nombre, String descripcion, String imagen) {
       StoredProcedureQuery query = entityManager.createStoredProcedureQuery("FIDE_PROCEDIMIENTOS_PKG.FIDE_SERVICIO_TB_INSERTAR_SP");
            query.registerStoredProcedureParameter(1, String.class, ParameterMode.IN);
            query.registerStoredProcedureParameter(2, String.class, ParameterMode.IN);
            query.registerStoredProcedureParameter(3, String.class, ParameterMode.IN);
            
            query.setParameter(1, nombre);
            query.setParameter(2, descripcion);
            query.setParameter(3, imagen);
            query.execute();
    }

    @Override
    @Transactional
    public void actualizarServicio(Servicio servicio) {
        StoredProcedureQuery query = entityManager.createStoredProcedureQuery("FIDE_PROCEDIMIENTOS_PKG.FIDE_SERVICIO_ACTUALIZAR_SP");
        query.registerStoredProcedureParameter("P_SERVICIO_ID", Long.class, ParameterMode.IN);
        query.registerStoredProcedureParameter("P_NOMBRE", String.class, ParameterMode.IN);
        query.registerStoredProcedureParameter("P_DESCRIPCION", String.class, ParameterMode.IN);
        query.registerStoredProcedureParameter("P_IMAGEN", String.class, ParameterMode.IN);

        query.setParameter("P_SERVICIO_ID", servicio.getIdServicio());
        query.setParameter("P_NOMBRE", servicio.getNombre());
        query.setParameter("P_DESCRIPCION", servicio.getDescripcion());
        query.setParameter("P_IMAGEN", servicio.getImagen());

        query.execute();
    }

    @Override
    @Transactional
    public void eliminarServicio(Long idServicio) {
        entityManager.createStoredProcedureQuery("FIDE_PROCEDIMIENTOS_PKG.FIDE_SERVICIO_ELIMINAR_SP")
                .registerStoredProcedureParameter("P_SERVICIO_ID", Long.class, ParameterMode.IN)
                .setParameter("P_SERVICIO_ID", idServicio)
                .execute();
    }

}
