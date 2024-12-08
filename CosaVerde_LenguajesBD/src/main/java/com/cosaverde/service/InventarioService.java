package com.cosaverde.service;


import java.util.List;
import com.cosaverde.domain.Inventario;
import java.util.Date;



public interface InventarioService {
    public List<Inventario> getInventario();

    public Inventario getInventarioPorId(Long idInventario);

    void insertarInventario(int stock, Date fechaVencimiento, int diasEnStock, double precioUnit, Long idEstado, Long idProducto);
    
    void actualizarInventario(Long idInventario, int stock, Date fechaVencimiento, int diasEnStock, double precioUnit, Long idEstado, Long idProducto);
    
    void eliminarInventario(Long idInventario);
    
    public Double obtenerTotalInventario();
}



