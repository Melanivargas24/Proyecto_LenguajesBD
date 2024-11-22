package com.CosaVerde.domain;

import jakarta.persistence.*;
import java.io.Serializable;
import java.util.List;
import lombok.Data;

@Data
@Entity
@Table(name= "categoria")
public class Categoria implements Serializable{
    
    private static final long serialVersionUID = 1L;
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_categoria")
    private Long idCategoria; // Hibernate transforma en id_categoria
    private String descripcion;
    private String rutaImagen;
    private Long precioUnit;
   
    
    @OneToMany
    @JoinColumn(name = "id_categoria", insertable = false, updatable = false)
    List<Producto> productos;

    public Categoria() {
    }

    public Categoria(String descripcion, String rutaImagen, Long precioUnit) {
        this.descripcion = descripcion;
        this.rutaImagen = rutaImagen;
        this.precioUnit = precioUnit;
    }
    
    
    
}
