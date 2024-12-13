package com.cosaverde.domain;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import java.io.Serializable;
import java.util.Date;
import lombok.Data;
import org.springframework.format.annotation.DateTimeFormat;

@Data
@Entity
@Table(name = "FIDE_INVENTARIO_TB")
public class Inventario implements Serializable {

    private static final long serialVersionUID = 1L; 

    @Id
    @Column(name = "INVENTARIO_ID")
    private Long idInventario;
    
    private int stock;
    private int diasEnStock;
    
    @ManyToOne
    @JoinColumn(name = "ESTADO_ID")
    private Estado estado;
    
    @ManyToOne
    @JoinColumn(name = "PRODUCTO_ID")
    private Producto producto;

   


}