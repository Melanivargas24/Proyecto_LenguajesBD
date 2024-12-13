package com.cosaverde.service;


import java.util.List;
import com.cosaverde.domain.Producto;


public interface ProductoService {
    public List<Producto> getProductos();
    
    public Producto getProductoPorId(Long idProducto);

    void insertarProducto(String nombre, String descripcion, String imagen, double precio_unit, Long idCategoria);
    void actualizarProducto(Long idProducto, String nombre, String descripcion, String imagen, double precio_unit, Long idCategoria);
    void eliminarProducto(Long idProducto);
    
    
    ///Para las funciones del carrito
    void agregarProductoCarrito(Long usuarioId, Long productoId, int cantidad);
    void eliminarProductoCarrito(Long usuarioId, Long productoId);
    void generarFactura(Long usuarioId, Long metodoPagoId);
    List<Producto> obtenerCarrito(Long usuarioId);
    double calcularSubtotal(Long usuarioId);
}

