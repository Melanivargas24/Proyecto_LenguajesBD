
package com.cosaverde.dao;
import org.springframework.data.jpa.repository.JpaRepository;

import com.cosaverde.domain.Servicio;

public interface ServicioDao extends JpaRepository<Servicio,Long> {
    
}