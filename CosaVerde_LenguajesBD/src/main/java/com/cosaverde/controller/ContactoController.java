
package com.cosaverde.controller;


import com.cosaverde.domain.Cita;
import com.cosaverde.service.CitaService;
import com.cosaverde.service.EstadoService;
import com.cosaverde.service.ServicioService;
import com.cosaverde.service.UsuarioService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/contacto")
public class ContactoController {
    
    @Autowired
    private CitaService citaService;
    
    @Autowired
    private EstadoService estadoService;
     
    @Autowired
    private UsuarioService usuarioService;
     
      @Autowired
    private ServicioService servicioService;
    
    
    
     @GetMapping
    public String mostrarFormulario(Model model) {
        var listaEstados = estadoService.getEstados();
        var listaServicios = servicioService.getServicios();
        var listaUsuarios = usuarioService.getUsuarios();
         model.addAttribute("cita", new Cita());
         model.addAttribute("estados", listaEstados);
         model.addAttribute("servicios", listaServicios);
         model.addAttribute("usuarios", listaUsuarios);
        return "contacto"; 
    }
  
    
       @PostMapping("/agregar")
    public String agregarCita(Cita cita) {
        citaService.crearCita(cita.getFecha(), cita.getHora(), 
                cita.getServicio().getIdServicio(), cita.getEstado().getIdEstado(), cita.getUsuario().getIdUsuario());
        return "redirect:/contacto";
    }


 


}
