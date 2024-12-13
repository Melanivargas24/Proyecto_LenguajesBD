
package com.cosaverde.domain;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;
import java.io.Serializable;
import java.util.List;

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
    
     @OneToMany(mappedBy = "producto")
    private List<DetalleFactura> detalles;

 
    
}