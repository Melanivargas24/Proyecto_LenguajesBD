
package com.CosaVerde.com.controller;

import com.CosaVerde.com.domain.Curso;
import com.CosaVerde.com.service.CursoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import java.util.List;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequestMapping("/curso")
public class CursoController {

    @Autowired
    private CursoService cursoService;
    
    @GetMapping("/listado")
    public String listado(@RequestParam(value = "nombre", required = false) String nombre,Model model) {
        System.out.println(nombre);
        List<Curso> cursos = cursoService.getCurso();
        
        if(nombre != null && !nombre.isEmpty()) {
             cursos = cursoService.findByNombreOrderByNombre(nombre);
        } else {
            System.out.println("entra");
             cursos = cursoService.getCurso();
        }
      
        model.addAttribute("cursos", cursos);
        return "/curso/listado";
    }
    
    
}