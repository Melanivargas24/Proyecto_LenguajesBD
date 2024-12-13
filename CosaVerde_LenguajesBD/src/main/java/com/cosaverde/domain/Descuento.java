package com.cosaverde.domain;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import java.io.Serializable;

import lombok.Data;

@Data
@Entity
@Table(name = "FIDE_DESCUENTO_TB")
public class Descuento implements Serializable {

    private static final long serialVersionUID = 1L; 

    @Id
    @Column(name = "DESCUENTO_ID")
    private Long idDescuento;
    private String nombre;
    private int porcentaje;
    String estado;

   


}