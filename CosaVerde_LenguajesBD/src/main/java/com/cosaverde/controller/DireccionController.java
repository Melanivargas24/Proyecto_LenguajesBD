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

import com.cosaverde.domain.Direccion;
import com.cosaverde.service.DireccionService;

@Controller
@RequestMapping("/direcciones")
public class DireccionController {
    @Autowired
    private DireccionService direccionService;
    
    @GetMapping
    public String direccion(Model model){
        var lista = direccionService.getDirecciones();
        model.addAttribute("direcciones",lista);
        model.addAttribute("direccion",new Direccion());
        return "direcciones/listado";
    }
}