/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.cosaverde.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.cosaverde.domain.Inventario;
import com.cosaverde.domain.Producto;
import com.cosaverde.service.EstadoService;
import com.cosaverde.service.InventarioService;
import com.cosaverde.service.ProductoService;



@Controller
@RequestMapping("/inventarios")
public class InventarioController {

    @Autowired
    private InventarioService inventarioService;
    

    @Autowired
    private EstadoService estadoService;


    @Autowired
    private ProductoService productoService;


    @GetMapping
    public String inventarios(Model model) {
        var lista = inventarioService.getInventario();
        var listaEstados = estadoService.getEstados();
        var listaProductos = productoService.getProductos();
        model.addAttribute("inventarios", lista);
        model.addAttribute("estados", listaEstados);
        model.addAttribute("productos", listaProductos);

        model.addAttribute("inventario", new Inventario());
        
        return "/inventarios/listado";
    }

    @PostMapping("/agregar")
    public String guardar(Inventario inventario) {
        //se valida si el id de producto ademas existe antes de agregar el inventario
        var listaInventarios = inventarioService.getInventario();

        for (Inventario inv : listaInventarios) {
            if (inv.getProducto().getIdProducto() == inventario.getProducto().getIdProducto()){
                return "redirect:/inventarios";
            }
        }
        inventarioService.insertarInventario(inventario.getStock(), 
                inventario.getFechaVencimiento() , inventario.getDiasEnStock(), inventario.getPrecioUnit(), 
                inventario.getEstado().getIdEstado(), inventario.getProducto().getIdProducto());
        return "redirect:/inventarios";
    }

    @GetMapping("/eliminar/{id}")
    public String eliminar(@PathVariable("id") Long idInventario) {
        inventarioService.eliminarInventario(idInventario);
        return "redirect:/inventarios";
    }

    @GetMapping("/editar/{id}")
    public String editar(@PathVariable("id") Long idInventario, Model model) {
        var inventario = inventarioService.getInventarioPorId(idInventario);
        var listaEstados = estadoService.getEstados();
        var listaProductos = productoService.getProductos();
        model.addAttribute("inventario", inventario);
        model.addAttribute("estados", listaEstados);
        model.addAttribute("productos", listaProductos);

        
        return "/inventarios/editar";
    }

    @PostMapping("/editar")
    public String actualizar(Inventario inventario) {
        inventarioService.actualizarInventario(inventario.getIdInventario(), inventario.getStock(), 
                inventario.getFechaVencimiento() , inventario.getDiasEnStock(), inventario.getPrecioUnit(), 
                inventario.getEstado().getIdEstado(), inventario.getProducto().getIdProducto());
        return "redirect:/inventarios";
    }


}
