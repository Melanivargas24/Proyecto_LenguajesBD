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
@Table(name = "FIDE_ESTADO_TB")
public class Estado implements Serializable {
    private static final long serialVersionUID = 1L;

    @Id
    @Column(name = "ESTADO_ID")
    private Long idEstado;

    private String nombre;


}