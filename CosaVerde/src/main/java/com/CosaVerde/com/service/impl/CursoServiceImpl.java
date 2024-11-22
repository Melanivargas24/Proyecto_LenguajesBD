
package com.CosaVerde.com.service.impl;
import com.CosaVerde.com.dao.CursoDao;
import com.CosaVerde.com.domain.Curso;
import com.CosaVerde.com.service.CursoService;
import java.util.List;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.simple.SimpleJdbcCall;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class CursoServiceImpl implements CursoService {

     @Autowired
    private CursoDao cursoDao;
     @Autowired
    private JdbcTemplate jdbcTemplate;
     
    @Override
    @Transactional(readOnly = true)
    public List<Curso> getCurso() {
         
      SimpleJdbcCall simpleJdbcCall = new SimpleJdbcCall(jdbcTemplate)
                .withProcedureName("GET_CURSOS")
                .returningResultSet("p_resultado", BeanPropertyRowMapper.newInstance(Curso.class));
      
        Map<String, Object> out = simpleJdbcCall.execute();

        var lista = (List<Curso>) out.get("p_resultado");
        
        return lista;
    }
    
    
    @Override
    @Transactional(readOnly = true)
    public Curso getCurso(Curso curso) {
        return cursoDao.findById(curso.getIdCurso()).orElse(null);
    }


    @Override
    @Transactional(readOnly = true)
    public List<Curso> findByNombreOrderByNombre(String nombre) {
     SimpleJdbcCall simpleJdbcCall = new SimpleJdbcCall(jdbcTemplate)
                .withProcedureName("FIND_CURSO_BY_NOMBRE")
                .returningResultSet("p_resultado", BeanPropertyRowMapper.newInstance(Curso.class));

        Map<String, Object> out = simpleJdbcCall.execute(Map.of("p_nombre", nombre));

        List<Curso> cursos = (List<Curso>) out.get("p_resultado");

        return cursos;
    }

}