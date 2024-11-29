/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.cosaverde.domain;


import java.io.Serializable;
import java.util.List;

import javax.persistence.*;

import lombok.Data;

@Data
@Entity
@Table(name = "FIDE_DISTRITO_TB")
public class Distrito implements Serializable {
    private static final long serialVersionUID = 1L;

    @Id
    @Column(name = "DISTRITO_ID")
    private Long idDistrito;

    private String nombre;

    // Relación bidireccional con Direccion
    @OneToMany(mappedBy = "distrito")
    private List<Direccion> direccion;
}
