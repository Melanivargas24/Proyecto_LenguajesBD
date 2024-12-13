/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package com.cosaverde.service;

import com.cosaverde.domain.Carrito;
import com.cosaverde.domain.Item;
import java.util.ArrayList;
import java.util.List;

public interface ItemService {

    List<Item> listaItems = new ArrayList<>();
    
    public List<Carrito> getProductos();

    public List<Item> gets();

 
    public void save(Item item);
    public void generarFactura(Long metodoPagoId);

  
   // public List<MetodoPago> obtenerMetodosDePago();
    
}
