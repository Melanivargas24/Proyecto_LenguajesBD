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
import java.util.Date;
import java.util.List;
import lombok.Data;
import org.springframework.format.annotation.DateTimeFormat;

@Data
@Entity
@Table(name = "FIDE_CURSO_TB")
public class Curso implements Serializable {
    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "CURSO_ID")
    private Long idCurso;

    private String nombre;
    private String descripcion;
    
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date fecha;
    
    private String hora;
    private String imagen;
    private int precio;
    private int capacidad;
    
    @ManyToOne
    @JoinColumn(name = "TIPO_CURSO_ID")
    private TipoCurso tipocurso;

    @ManyToOne
    @JoinColumn(name = "ESTADO_ID")
    private Estado estado;
    
    @ManyToOne
    @JoinColumn(name = "DIRECCION_ID")
    private Direccion direccion;
    
    
}