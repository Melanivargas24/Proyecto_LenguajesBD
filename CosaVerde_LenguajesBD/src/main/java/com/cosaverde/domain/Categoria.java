
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
@Table(name = "FIDE_CATEGORIA_TB")
public class Categoria implements Serializable {
    private static final long serialVersionUID = 1L;

    @Id
    @Column(name = "CATEGORIA_ID")
    private Long idCategoria;

    private String nombre;

    // Relación bidireccional con Producto
    @OneToMany(mappedBy = "categoria")
    private List<Producto> productos;
}

