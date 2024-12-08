/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package com.cosaverde.service;

import com.cosaverde.domain.Descuento;
import java.util.List;

public interface DescuentoService {
    public List<Descuento> getDescuentos();
    public Descuento getDescuentoPorId(Long idDescuento);
    public void crearDescuento (String nombre, int porcentaje);
    public void actualizarDescuento(Descuento descuento);
    public void eliminarDescuento(Long idDescuento);
}


