
package com.cosaverde.domain;



import java.io.Serializable;
import java.util.List;

import javax.persistence.*;

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

/*
    CREATE TABLE tab_categoria(
	id_categoria NUMBER NOT NULL,
	nombre varchar2(50) NOT NULL,
    PRIMARY KEY (id_categoria)
    );
*/ 