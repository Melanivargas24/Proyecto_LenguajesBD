package com.cosaverde.service.impl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.cosaverde.service.CategoriaService;
import com.cosaverde.dao.CategoriaDao;
import com.cosaverde.domain.Categoria;
import jakarta.persistence.EntityManager;
import jakarta.persistence.ParameterMode;
import jakarta.persistence.PersistenceContext;
import jakarta.persistence.StoredProcedureQuery;



@Service
public class CategoriaServiceImpl implements CategoriaService {

    @Autowired
    private CategoriaDao categoriaDao;

    @PersistenceContext
    private EntityManager entityManager;

    @Override
    @Transactional(readOnly = true)
    public List<Categoria> getCategorias() {
        StoredProcedureQuery query = entityManager.createStoredProcedureQuery("FIDE_PROCEDIMIENTOS_PKG.FIDE_CATEGORIA_TB_OBTENER_SP", Categoria.class);
        query.registerStoredProcedureParameter(1, Class.class, ParameterMode.REF_CURSOR);
        query.execute();
        return query.getResultList();
    }
    

    @Override
    @Transactional(readOnly = true)
    public Categoria getCategoriaPorId(Long idCategoria) {
        StoredProcedureQuery query = entityManager.createStoredProcedureQuery("FIDE_PROCEDIMIENTOS_PKG.FIDE_CATEGORIA_TB_GET_BY_ID",
                Categoria.class);
        query.registerStoredProcedureParameter(1, Class.class, ParameterMode.REF_CURSOR);
        query.registerStoredProcedureParameter(2, Long.class, ParameterMode.IN);
        query.setParameter(2, idCategoria);
        query.execute();
        List<Categoria> result = query.getResultList();
        return result.isEmpty() ? null : result.get(0);
    }
    

    @Override
    @Transactional
    public void insertarCategoria(String nombre) {
        StoredProcedureQuery query = entityManager.createStoredProcedureQuery("FIDE_PROCEDIMIENTOS_PKG.FIDE_CATEGORIA_TB_INSERTAR_SP");
        query.registerStoredProcedureParameter(1, String.class, ParameterMode.IN);
        query.setParameter(1, nombre);
        query.execute();
    }
    

    @Override
    @Transactional
    public void actualizarCategoria(Long idCategoria, String nombre) {
        // Print en consola de id y nombre
        System.out.println("idCategoria: " + idCategoria + " nombre: " + nombre);
        entityManager.createNativeQuery("CALL FIDE_PROCEDIMIENTOS_PKG.FIDE_CATEGORIA_ACTUALIZAR_SP(:idCategoria, :nombre)")
                .setParameter("idCategoria", idCategoria)
                .setParameter("nombre", nombre)
                .executeUpdate();
    }
    
 
    @Override
    @Transactional
    public void eliminarCategoria(Long idCategoria) {
        entityManager.createStoredProcedureQuery("FIDE_PROCEDIMIENTOS_PKG.FIDE_CATEGORIA_ELIMINAR_SP")
                .registerStoredProcedureParameter("P_CATEGORIA_ID", Long.class, ParameterMode.IN)
                .setParameter("P_CATEGORIA_ID", idCategoria)
                .execute();
    }


}
