
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
@Table(name = "FIDE_TIPO_CURSO_TB")
public class TipoCurso implements Serializable {
    private static final long serialVersionUID = 1L;

    @Id
    @Column(name = "TIPO_CURSO_ID")
    private Long idTipoCurso;

    private String nombre;
    
    @OneToMany(mappedBy = "tipocurso")
    private List<Curso> cursos;
    
}
