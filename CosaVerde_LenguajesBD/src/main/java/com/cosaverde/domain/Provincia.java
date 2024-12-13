/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.cosaverde.domain;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;
import java.io.Serializable;
import java.util.List;
import lombok.Data;

@Data
@Entity
@Table(name = "FIDE_PROVINCIA_TB")
public class Provincia implements Serializable {
    private static final long serialVersionUID = 1L;

    @Id
    @Column(name = "PROVINCIA_ID")
    private Long idProvincia;

    private String nombre;

    // Relación bidireccional con Direccion
    @OneToMany(mappedBy = "provincia")
    private List<Direccion> direccion;
}