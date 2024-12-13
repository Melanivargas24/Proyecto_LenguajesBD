/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package com.cosaverde.dao;

import com.cosaverde.domain.Carrito;
import com.cosaverde.domain.Producto;
import com.cosaverde.domain.Usuario;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface CarritoDao extends JpaRepository<Carrito, Carrito.CarritoId> {
    
    // Método para encontrar un item de carrito específico por usuario y producto
    Carrito findByUsuarioAndProducto(Usuario usuario, Producto producto);
    
    // Método para obtener todos los items del carrito de un usuario
    List<Carrito> findByUsuario(Usuario usuario);
}
