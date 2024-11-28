
package com.CosaVerde.Dao;


import com.CosaVerde.domain.Categoria;
import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;

/**
 *
 * @author sfallas
 */
public interface CategoriaDao extends JpaRepository<Categoria, Long>{
    List<Categoria> findByDescripcion(String descripcion);
    
}
