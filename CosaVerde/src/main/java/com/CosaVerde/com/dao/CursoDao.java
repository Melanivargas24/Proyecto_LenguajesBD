package com.CosaVerde.com.dao;

import com.CosaVerde.com.domain.Curso;
import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;

public interface CursoDao extends JpaRepository<Curso, Long> {

    
    public List<Curso> findByNombreOrderByNombre(String nombre);
    
    List<Curso> findByIdTipoCurso(Long idTipoCurso);
}