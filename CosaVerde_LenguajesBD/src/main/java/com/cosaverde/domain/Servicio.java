
package com.cosaverde.domain;

import java.io.Serializable;
import javax.persistence.*;
import lombok.Data;

@Data
@Entity
@Table(name="FIDE_SERVICIO_TB")
public class Servicio implements Serializable {
    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name="SERVICIO_ID")
    private Long idServicio;
    
    private String nombre;
    private String descripcion;
    private String imagen;

}