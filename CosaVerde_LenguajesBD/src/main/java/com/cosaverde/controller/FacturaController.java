package com.cosaverde.controller;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.cosaverde.domain.Factura;
import com.cosaverde.service.FacturaService;

@Controller
@RequestMapping("/facturas")
public class FacturaController {
    
    @Autowired
    private FacturaService facturaService;
    
    @GetMapping
    public String servicio(Model model){
        var lista = facturaService.getFacturas();
        model.addAttribute("facturas",lista);
        model.addAttribute("factura",new Factura());
        return "facturas/listado";
    }
    
}