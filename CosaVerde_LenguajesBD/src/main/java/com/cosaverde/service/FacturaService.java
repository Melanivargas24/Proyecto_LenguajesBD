/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package com.cosaverde.service;

import com.cosaverde.domain.Factura;
import java.util.List;

public interface FacturaService {
    public List<Factura> getFacturas();
    public Factura getFacturaPorId(Long idFactura);


}