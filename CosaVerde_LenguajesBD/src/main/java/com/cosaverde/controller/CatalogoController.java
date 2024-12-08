package com.cosaverde.controller;

import com.cosaverde.domain.Producto;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestMapping;

import com.cosaverde.service.CategoriaService;
import com.cosaverde.service.ProductoService;

@Controller
@RequestMapping("/catalogo")
public class CatalogoController {

    @Autowired
    private ProductoService productoService;

    @Autowired
    private CategoriaService categoriaService;
    
    // Método para mostrar el catálogo completo
    @GetMapping
    public String catalogo(Model model) {
        var lista = productoService.getProductos();
        var listaCategorias = categoriaService.getCategorias();
        model.addAttribute("productos", lista);
        model.addAttribute("categorias", listaCategorias);
        model.addAttribute("producto", new Producto()); // Crear un objeto Producto si se desea agregar un nuevo producto
        return "/catalogo/listado"; // Regresar a la página del catálogo
    }

}
