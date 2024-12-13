
package com.cosaverde.domain;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import java.io.Serializable;
import lombok.Data;

@Data
@Entity
@Table(name = "FIDE_DETALLE_FACTURA_TB")
public class DetalleFactura implements Serializable {

    private static final long serialVersionUID = 1L; 

    @Id
    @Column(name = "DETALLE_FACTURA_ID")
    private Long idDetalleFactura;
    private int cantidadLineas;
    private int totalPorLinea;
    
    @ManyToOne
    @JoinColumn(name = "PRODUCTO_ID")
    private Producto producto;
    
    
}
