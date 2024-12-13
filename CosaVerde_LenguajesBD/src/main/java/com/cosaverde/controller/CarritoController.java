package com.cosaverde.controller;


import com.cosaverde.domain.Carrito;
import com.cosaverde.domain.Item;
import com.cosaverde.domain.MetodoPago;
import com.cosaverde.domain.Producto;
import com.cosaverde.service.ItemService;
import com.cosaverde.service.MetodoPagoService;
import com.cosaverde.service.ProductoService;
import com.cosaverde.service.ItemService;
import com.cosaverde.service.MetodoPagoService;
import com.cosaverde.service.ProductoService;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class CarritoController {

    @Autowired
    private ItemService itemService;
    
    @Autowired
    private ProductoService productoService;
    
    @Autowired
    private MetodoPagoService metodoPagoService;

    @GetMapping("/")
    private String listado(Model model) {
        var productos = productoService.getProductos();
        model.addAttribute("productos", productos);
        return "/index";
    }


@GetMapping("carrito/listado")
public String verCarrito(Model model) {
    var lista = itemService.getProductos();
    if (lista == null) {
        lista = new ArrayList<>(); 
    }

    var carritoTotalVenta = 0;
    for (Carrito i : lista) {
        carritoTotalVenta += (i.getCantidad() * i.getProducto().getPrecio_unit());
    }
    
    model.addAttribute("carritoTotal", carritoTotalVenta);

    model.addAttribute("productos", lista);
    model.addAttribute("carrito", new Carrito());
    
    
    List<MetodoPago> metodosPago = metodoPagoService.getMetodos();
    model.addAttribute("metodosPago", metodosPago); 
    return "carrito/listado";
}



    @GetMapping("/carrito/agregar/{idProducto}")
public ModelAndView agregarItem(Model model, @PathVariable("idProducto") Long idProducto) {
    Item item = new Item();
    item.setIdProducto(idProducto);

    itemService.save(item);

    var lista = itemService.gets();
    var totalCarritos = 0;
    var carritoTotalVenta = 0;
    for (Item i : lista) {
        totalCarritos += i.getCantidad();
        carritoTotalVenta += (i.getCantidad() * i.getPrecio_unit());
    }
    
    model.addAttribute("listaItems", lista);
    model.addAttribute("listaTotal", totalCarritos);
    model.addAttribute("carritoTotal", carritoTotalVenta);

    return new ModelAndView("/carrito/fragmentos :: verCarrito");
}

@PostMapping("/facturar/carrito")
public String generarFactura(
        @RequestParam("idMetodoPago") Long idMetodoPago, 
        Model model) {
        itemService.generarFactura(idMetodoPago);
        model.addAttribute("mensaje", "Factura generada exitosamente.");
        return "redirect:/"; 
   
}
}




