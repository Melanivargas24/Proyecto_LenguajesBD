
package com.cosaverde.domain;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper = false)
public class Item extends Producto {

    private int cantidad; //Almacenar la cantidad de items de un producto

    public Item() {
    }

    public Item(Producto producto) {
        super.setIdProducto(producto.getIdProducto());
        super.setNombre(producto.getNombre());
        super.setDescripcion(producto.getDescripcion());
        super.setPrecio_unit(producto.getPrecio_unit());
        super.setImagen(producto.getImagen());
        
        this.cantidad = 0;
    }
}
