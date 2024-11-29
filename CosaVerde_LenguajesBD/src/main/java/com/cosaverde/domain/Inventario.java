package com.cosaverde.domain;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.*;


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
    
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date fechaVencimiento;
    
    private int diasEnStock;
    private Double precioUnit;
    
    @ManyToOne
    @JoinColumn(name = "ESTADO_ID")
    private Estado estado;
    
    @ManyToOne
    @JoinColumn(name = "PRODUCTO_ID")
    private Producto producto;

   


}