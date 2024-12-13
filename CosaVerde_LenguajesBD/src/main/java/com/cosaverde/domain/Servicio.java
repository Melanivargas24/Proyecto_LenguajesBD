
package com.cosaverde.domain;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;
import java.io.Serializable;
import java.util.List;
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
    
     @OneToMany(mappedBy = "servicio")
    private List<Cita> citas;


}