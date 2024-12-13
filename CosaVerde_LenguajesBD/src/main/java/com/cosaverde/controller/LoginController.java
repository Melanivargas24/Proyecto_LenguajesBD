/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.cosaverde.controller;

import com.cosaverde.domain.Canton;
import com.cosaverde.domain.Direccion;
import com.cosaverde.domain.Distrito;
import com.cosaverde.domain.Provincia;
import com.cosaverde.domain.Rol;
import com.cosaverde.domain.Usuario;
import com.cosaverde.service.CantonService;
import com.cosaverde.service.DireccionService;
import com.cosaverde.service.DistritoService;
import com.cosaverde.service.ProvinciaService;
import com.cosaverde.service.UsuarioService;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

/**
 * Controlador para el login y registro de usuarios.
 */
@Controller
public class LoginController {

    @Autowired
    private UsuarioService usuarioService;

    @Autowired
    private DireccionService direccionService;

    @Autowired
    private ProvinciaService provinciaService;

    @Autowired
    private CantonService cantonService;

    @Autowired
    private DistritoService distritoService;

    // Para retornar página de login
    @GetMapping("/login")
    public String login(Model model) {
        return "login/login";  // Página del login
    }

    @PostMapping("/login")
    public String login(Model model, HttpSession session,
            @RequestParam String correo,
            @RequestParam String contrasena) {
        boolean credencialesValidas = usuarioService.verificarCredenciales(correo, contrasena);

        if (credencialesValidas) {
            // Si las credenciales son válidas, se busca el usuario
            Usuario usuario = usuarioService.obtenerUsuarioPorCorreo(correo);
            session.setAttribute("usuario", usuario); // Almacenar el usuario en la sesión
            return "redirect:/"; // Redirigir a la página principal
        } else {
            model.addAttribute("mensaje", "Usuario o contraseña incorrectos. Intenta nuevamente.");
            return "login/login"; // Volver a la página de login
        }
    }

    // Para retornar página de login
    @GetMapping("/registro")
    public String registro(Model model) {
        List<Provincia> provincias = provinciaService.getAllProvincias();
        List<Canton> cantones = cantonService.getAllCantones();
        List<Distrito> distritos = distritoService.getAllDistritos();

        model.addAttribute("provincias", provincias);
        model.addAttribute("cantones", cantones);
        model.addAttribute("distritos", distritos);

        return "login/registro";  // Página del login
    }

    // Método para registrar un nuevo usuario
    @PostMapping("/registro")
    public String registrarUsuario(
            @RequestParam("nombre") String nombre,
            @RequestParam("apellidos") String apellidos,
            @RequestParam("correo") String correo,
            @RequestParam("contrasena") String contrasena,
            @RequestParam("rolId") Long rolId,
            @RequestParam("provinciaId") Long provinciaId,
            @RequestParam("cantonId") Long cantonId,
            @RequestParam("distritoId") Long distritoId,
            @RequestParam("senas") String senas) {

        // Crear una nueva dirección
        Direccion direccion = new Direccion();
        direccion.setProvincia(direccionService.findProvincia(provinciaId));
        direccion.setCanton(direccionService.findCanton(cantonId));
        direccion.setDistrito(direccionService.findDistrito(distritoId));
        direccion.setSenas(senas);

        // Guardar la dirección (ID autogenerado)
        direccionService.save(direccion);

        // Crear el usuario con los datos recibidos
        Usuario usuario = new Usuario();
        usuario.setNombre(nombre);
        usuario.setApellidos(apellidos);
        usuario.setCorreo(correo);
        usuario.setContrasena(contrasena);
        usuario.setDireccion(direccion);
        usuario.setEstado(usuarioService.getEstadoById(1L));

        // Buscar el rol por ID y asignarlo al usuario
        Rol rol = usuarioService.getRolById(rolId);
        if (rol == null) {
            throw new RuntimeException("Rol no encontrado");
        }
        usuario.setRol(rol); // Usar el método de agregar rol en lugar de setRoles

        // Guardar el usuario
        usuarioService.save(usuario);

        return "redirect:/login";
    }

    @RequestMapping("/provincias")
    @GetMapping
    public ResponseEntity<List<Provincia>> getAllProvincias() {
        List<Provincia> provincias = provinciaService.getAllProvincias();
        return ResponseEntity.ok(provincias);
    }

    @RequestMapping("/cantones")
    @GetMapping
    public ResponseEntity<List<Canton>> getAllCantones() {
        List<Canton> cantones = cantonService.getAllCantones();
        return ResponseEntity.ok(cantones);
    }

    @RequestMapping("/distritos")
    @GetMapping
    public ResponseEntity<List<Distrito>> getAllDistritos() {
        List<Distrito> distritos = distritoService.getAllDistritos();
        return ResponseEntity.ok(distritos);
    }

    @GetMapping("/logout")
    public String logout(HttpSession session, RedirectAttributes redirectAttributes) {
        session.invalidate();
        redirectAttributes.addFlashAttribute("mensaje", "Has cerrado sesión correctamente.");
        return "redirect:/login";
    }

}
