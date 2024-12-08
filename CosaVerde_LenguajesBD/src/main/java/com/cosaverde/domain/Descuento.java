package com.cosaverde.domain;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.*;


import lombok.Data;
import org.springframework.format.annotation.DateTimeFormat;

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

   


}