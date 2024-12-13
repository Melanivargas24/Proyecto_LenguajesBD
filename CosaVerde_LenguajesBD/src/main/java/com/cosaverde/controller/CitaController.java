/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.cosaverde.controller;


import com.cosaverde.domain.Cita;
import com.cosaverde.service.CitaService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/citas")
public class CitaController {
    
    @Autowired
    private CitaService citaService;
    
    @GetMapping
    public String servicio(Model model){
        var lista = citaService.getCitas();
        model.addAttribute("citas",lista);
        model.addAttribute("cita",new Cita());
        return "citas/listado";
    }
    


    @GetMapping("/eliminar/{id}")
    public String eliminarCita(@PathVariable("id") Long idCita) {
        citaService.eliminarCita(idCita);
        return "redirect:/citas";
    }

    @GetMapping("/editar/{id}")
    public String editarCita(@PathVariable("id") Long idCita, Model model) {
        var cita = citaService.getCitaPorId(idCita);
        var listaCitas = citaService.getCitas();
        model.addAttribute("cita", cita);
        model.addAttribute("citas", listaCitas);
        return "/citas/editar";
    }

    @PostMapping("/editar")
    public String editarProducto(Cita cita) {
        citaService.actualizarCita(cita.getIdCita(), cita.getFecha(), cita.getHora(),
                cita.getServicio().getIdServicio(), cita.getEstado().getIdEstado(), cita.getUsuario().getIdUsuario());
        return "redirect:/citas";
    }


}
