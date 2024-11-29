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

import com.cosaverde.domain.Servicio;
import com.cosaverde.service.ServicioService;

@Controller
@RequestMapping("/servicios")
public class ServicioController {
    @Autowired
    private ServicioService servicioService;
    
    @GetMapping
    public String servicio(Model model){
        var lista = servicioService.getServicios();
        model.addAttribute("servicios",lista);
        model.addAttribute("servicio",new Servicio());
        return "servicios/listado";
    }
    
    @PostMapping("/agregar")
    public String agregarServicio(@ModelAttribute Servicio servicio) {
        servicioService.crearServicio( servicio.getNombre(),
                servicio.getDescripcion(), servicio.getImagen());
        return "redirect:/servicios";
    }
    
    @GetMapping("/editar/{id}")
    public String editarSucursal(@PathVariable("id") Long idServicio, Model model) {
        var servicio = servicioService.getServicioPorId(idServicio);
        model.addAttribute("servicio", servicio);
        return "servicios/editar";
    }

    @PostMapping("/editar")
    public String actualizarServicio(@ModelAttribute Servicio servicio) {
        servicioService.actualizarServicio(servicio);
        return "redirect:/servicios";
    }
    
    @GetMapping("/eliminar/{id}")
    public String eliminarServicio(@PathVariable("id") Long idServicio) {
        servicioService.eliminarServicio(idServicio);
        return "redirect:/servicios";
    }
}
