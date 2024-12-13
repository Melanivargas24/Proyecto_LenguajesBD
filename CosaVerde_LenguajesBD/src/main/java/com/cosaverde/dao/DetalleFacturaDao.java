package com.cosaverde.dao;
import org.springframework.data.jpa.repository.JpaRepository;


import com.cosaverde.domain.DetalleFactura;

public interface DetalleFacturaDao extends JpaRepository<DetalleFactura,Long> {
    
}
