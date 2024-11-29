
package com.cosaverde.domain;


import java.io.Serializable;
import java.util.List;

import javax.persistence.*;

import lombok.Data;

@Data
@Entity
@Table(name = "FIDE_PRODUCTO_TB")
public class Producto implements Serializable {
    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "PRODUCTO_ID")
    private Long idProducto;

    private String nombre;
    private String descripcion;
    private String imagen;
    private double precio_unit;

    @ManyToOne
    @JoinColumn(name = "CATEGORIA_ID")
    private Categoria categoria;

    @OneToMany(mappedBy = "producto")
    private List<Inventario> inventarios;

   /* public int getCantidadTotalStock() {
        int cantidadTotal = 0;
        if (inventarios != null) {
            for (Inventario inventario : inventarios) {
                cantidadTotal += inventario.getStock();
            }
        }
        return cantidadTotal;
    }*/
    
    
}