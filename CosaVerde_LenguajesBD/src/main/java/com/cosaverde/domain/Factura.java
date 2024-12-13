package com.cosaverde.domain;


import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import java.io.Serializable;
import java.util.Date;
import lombok.Data;
import org.springframework.format.annotation.DateTimeFormat;

@Data
@Entity
@Table(name = "FIDE_FACTURA_TB")
public class Factura implements Serializable {
    private static final long serialVersionUID = 1L;

    @Id
    @Column(name = "FACTURA_ID")
    private Long idFactura;
    
    @ManyToOne
    @JoinColumn(name = "USUARIO_ID")
    private Usuario usuario;
    
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date fecha;
    
    @ManyToOne
    @JoinColumn(name = "DETALLE_FACTURA_ID")
    private DetalleFactura detallefactura;
    
    @ManyToOne
    @JoinColumn(name = "DESCUENTO_ID")
    private Descuento descuento;
    
    private int iva;
    private int subtotal;
    private int montoTotal;
    
    @ManyToOne
    @JoinColumn(name = "METODO_PAGO_ID")
    private MetodoPago metodopago;
    
    
}
