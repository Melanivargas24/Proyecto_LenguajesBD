
package com.cosaverde.domain;


import jakarta.persistence.Column;
import jakarta.persistence.Entity;
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
@Table(name = "FIDE_CITA_TB")
public class Cita implements Serializable {
    private static final long serialVersionUID = 1L;

    @Id
    @Column(name = "CITA_ID")
    private Long idCita;
    
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date fecha;
    private String hora;
    
    @ManyToOne
    @JoinColumn(name = "ESTADO_ID")
    private Estado estado;
    
    @ManyToOne
    @JoinColumn(name = "SERVICIO_ID")
    private Servicio servicio;
    
    @ManyToOne
    @JoinColumn(name = "USUARIO_ID")
    private Usuario usuario;
    
    
    
}
