package com.cosaverde.dao;

import org.springframework.data.jpa.repository.JpaRepository;

import com.cosaverde.domain.Inventario;

public interface InventarioDao extends JpaRepository<Inventario,Long>{
    
}
