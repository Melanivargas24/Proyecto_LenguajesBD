/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.cosaverde.domain;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

import javax.persistence.*;

import lombok.Data;
import org.springframework.format.annotation.DateTimeFormat;

@Data
@Entity
@Table(name = "FIDE_DIRECCION_TB")
public class Direccion implements Serializable {
    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "DIRECCION_ID")
    private Long idDireccion;

    private String señas;

    @ManyToOne
    @JoinColumn(name = "PROVINCIA_ID")
    private Provincia provincia;
    
    @ManyToOne
    @JoinColumn(name = "CANTON_ID")
    private Canton canton;
    
    @ManyToOne
    @JoinColumn(name = "DISTRITO_ID")
    private Distrito distrito;

    
}