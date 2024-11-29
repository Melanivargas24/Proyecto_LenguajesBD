/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package com.cosaverde.service;



import com.cosaverde.domain.Direccion;
import java.util.List;

public interface DireccionService {
    public List<Direccion> getDirecciones();
    public Direccion getDireccionPorId(Long idDireccion);


}

