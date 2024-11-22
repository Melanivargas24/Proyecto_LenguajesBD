
package com.CosaVerde.com.domain;

import jakarta.persistence.*;
import java.io.Serializable;
import java.util.Date;
import lombok.Data;

@Data
@Entity
@Table(name="producto")
public class Curso implements Serializable {
    private static final long serialVersionUID = 1L;
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name="CURSO_ID")
    private Long idCurso;
    private Long idDireccion;
    private Long idTipoCurso;
    private Long idEstado;
    private String nombre;
    private String descripcion;
    private Date fecha;
    private String hora;
    private String Imagen;
    private Double precio;
    private int capacidad;

    public Curso() {
    }

    public Curso(Long idCurso, Long idDireccion, Long idTipoCurso, Long idEstado, String nombre, String descripcion, Date fecha, String hora, String Imagen, Double precio, int capacidad) {
        this.idCurso = idCurso;
        this.idDireccion = idDireccion;
        this.idTipoCurso = idTipoCurso;
        this.idEstado = idEstado;
        this.nombre = nombre;
        this.descripcion = descripcion;
        this.fecha = fecha;
        this.hora = hora;
        this.Imagen = Imagen;
        this.precio = precio;
        this.capacidad = capacidad;
    }
}
