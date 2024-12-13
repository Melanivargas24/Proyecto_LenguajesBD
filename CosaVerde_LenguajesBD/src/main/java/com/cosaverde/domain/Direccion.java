/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
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
@Table(name = "FIDE_DIRECCION_TB")
public class Direccion implements Serializable {
    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "DIRECCION_ID")
    private Long idDireccion;

    private String senas;

    @ManyToOne
    @JoinColumn(name = "PROVINCIA_ID")
    private Provincia provincia;
    
    @ManyToOne
    @JoinColumn(name = "CANTON_ID")
    private Canton canton;
    
    @ManyToOne
    @JoinColumn(name = "DISTRITO_ID")
    private Distrito distrito;
    
    @OneToMany(mappedBy = "direccion")
    private List<Curso> cursos;
    
    
}