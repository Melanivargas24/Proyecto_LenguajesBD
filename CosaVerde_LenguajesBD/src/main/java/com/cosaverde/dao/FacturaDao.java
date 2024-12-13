package com.cosaverde.dao;
import org.springframework.data.jpa.repository.JpaRepository;


import com.cosaverde.domain.Factura;

public interface FacturaDao extends JpaRepository<Factura,Long> {
    
}
