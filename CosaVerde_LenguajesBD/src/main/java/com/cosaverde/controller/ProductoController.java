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
import com.cosaverde.service.CategoriaService;
import com.cosaverde.service.InventarioService;
import com.cosaverde.service.ProductoService;


@Controller
@RequestMapping("/productos")
public class ProductoController {

    @Autowired
    private InventarioService inventarioService;
    @Autowired
    private ProductoService productoService;

    @Autowired
    private CategoriaService categoriaService;

    @GetMapping
    public String productos(Model model) {
        var lista = productoService.getProductos();
        var listaCategorias = categoriaService.getCategorias();
        model.addAttribute("productos", lista);
        model.addAttribute("categorias", listaCategorias);
        model.addAttribute("inventario", new Inventario()); 
        model.addAttribute("producto", new Producto());
        return "/productos/listado";
    }

    @PostMapping("/agregar")
    public String agregarProducto(Producto producto) {
        productoService.insertarProducto(producto.getNombre(), producto.getDescripcion(),
                producto.getImagen(), producto.getPrecio_unit(), producto.getCategoria().getIdCategoria());
        return "redirect:/productos";
    }

    @GetMapping("/eliminar/{id}")
    public String eliminarProducto(@PathVariable("id") Long idProducto) {
        System.out.println("idProducto: " + idProducto);
        productoService.eliminarProducto(idProducto);
        return "redirect:/productos";
    }

    @GetMapping("/editar/{id}")
    public String editarProducto(@PathVariable("id") Long idProducto, Model model) {
        var producto = productoService.getProductoPorId(idProducto);
        var listaCategorias = categoriaService.getCategorias();
        model.addAttribute("producto", producto);
        model.addAttribute("categorias", listaCategorias);
        return "/productos/editar";
    }

    @PostMapping("/editar")
    public String editarProducto(Producto producto) {
        productoService.actualizarProducto(producto.getIdProducto(), producto.getNombre(), producto.getDescripcion(),
                producto.getImagen(), producto.getPrecio_unit(), producto.getCategoria().getIdCategoria());
        return "redirect:/productos";
    }


}
