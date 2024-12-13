/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.cosaverde.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.cosaverde.domain.Descuento;
import com.cosaverde.service.DescuentoService;

@Controller
@RequestMapping("/descuentos")
public class DescuentoController {
    @Autowired
    private DescuentoService descuentoService;
    
    @GetMapping
    public String servicio(Model model){
        var lista = descuentoService.getDescuentos();
        model.addAttribute("descuentos",lista);
        model.addAttribute("descuento",new Descuento());
        return "descuentos/listado";
    }
    
    @PostMapping("/agregar")
    public String agregarDescuento(@ModelAttribute Descuento descuento) {
        descuentoService.crearDescuento( descuento.getNombre(),
                descuento.getPorcentaje(), descuento.getEstado());
        return "redirect:/descuentos";
    }
    
    @GetMapping("/editar/{id}")
    public String editarDescuento(@PathVariable("id") Long idDescuento, Model model) {
        var descuento = descuentoService.getDescuentoPorId(idDescuento);
        model.addAttribute("descuento", descuento);
        return "descuentos/editar";
    }

    @PostMapping("/editar")
    public String actualizarDescuentos(@ModelAttribute Descuento descuento) {
        descuentoService.actualizarDescuento(descuento);
        return "redirect:/descuentos";
    }
    
    @GetMapping("/eliminar/{id}")
    public String eliminarDescuentos(@PathVariable("id") Long idDescuento) {
        descuentoService.eliminarDescuento(idDescuento);
        return "redirect:/descuentos";
    }
}

