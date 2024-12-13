/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package com.cosaverde.service;



import com.cosaverde.domain.Canton;
import com.cosaverde.domain.Direccion;
import com.cosaverde.domain.Distrito;
import com.cosaverde.domain.Provincia;
import java.util.List;

public interface DireccionService {
    public List<Direccion> getDirecciones();
    public Direccion getDireccionPorId(Long idDireccion);

     public void save(Direccion direccion);
    
    public Provincia findProvincia(Long provinciaId);

    public Canton findCanton(Long cantonId);

    public Distrito findDistrito(Long distritoId);

}

