/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.cosaverde.controller;

import com.cosaverde.domain.Curso;
import com.cosaverde.service.CursoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/cursosCliente")
public class CursosClienteController {
    
    @Autowired
    private CursoService cursoService;
    
    @GetMapping
    public String Cursos(Model model){
        var lista = cursoService.getCursos();
        model.addAttribute("cursos",lista);
        model.addAttribute("curso",new Curso());
        return "cursosCliente/listado";
    }
}
