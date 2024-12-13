/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.cosaverde.controller;


import com.cosaverde.domain.Servicio;
import com.cosaverde.service.ServicioService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/serviciosCliente")
public class ServiciosClienteController {
    @Autowired
    private ServicioService servicioService;
    
    @GetMapping
    public String servicio(Model model){
        var lista = servicioService.getServicios();
        model.addAttribute("servicios",lista);
        model.addAttribute("servicio",new Servicio());
        return "serviciosCliente/listado";
    }
}