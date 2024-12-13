/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.cosaverde.domain;

import jakarta.persistence.*;
import java.io.Serializable;
import java.util.Objects;

@Entity
@Table(name = "FIDE_CARRITO_TB")
public class Carrito implements Serializable {
    @EmbeddedId
    private CarritoId id;

    @ManyToOne
    @MapsId("idUsuario")
    @JoinColumn(name = "USUARIO_ID")
    private Usuario usuario;

    @ManyToOne
    @MapsId("idProducto")
    @JoinColumn(name = "PRODUCTO_ID")
    private Producto producto;

    @Column(name = "CANTIDAD", nullable = false)
    private int cantidad;

    // Constructores
    public Carrito() {}

    public Carrito(Usuario usuario, Producto producto, int cantidad) {
        this.id = new CarritoId(usuario.getIdUsuario(), producto.getIdProducto());
        this.usuario = usuario;
        this.producto = producto;
        this.cantidad = cantidad;
    }

    // Getters y setters
    public CarritoId getId() {
        return id;
    }

    public void setId(CarritoId id) {
        this.id = id;
    }

    public Usuario getUsuario() {
        return usuario;
    }

    public void setUsuario(Usuario usuario) {
        this.usuario = usuario;
    }

    public Producto getProducto() {
        return producto;
    }

    public void setProducto(Producto producto) {
        this.producto = producto;
    }

    public int getCantidad() {
        return cantidad;
    }

    public void setCantidad(int cantidad) {
        this.cantidad = cantidad;
    }

    // Clase interna para la clave compuesta
    @Embeddable
    public static class CarritoId implements Serializable {
        @Column(name = "USUARIO_ID")
        private Long idUsuario;

        @Column(name = "PRODUCTO_ID")
        private Long idProducto;

        // Constructores
        public CarritoId() {}

        public CarritoId(Long idUsuario, Long idProducto) {
            this.idUsuario = idUsuario;
            this.idProducto = idProducto;
        }

        // Getters, setters, equals, hashCode
        public Long getIdUsuario() {
            return idUsuario;
        }

        public void setIdUsuario(Long idUsuario) {
            this.idUsuario = idUsuario;
        }

        public Long getIdProducto() {
            return idProducto;
        }

        public void setIdProducto(Long idProducto) {
            this.idProducto = idProducto;
        }

        @Override
        public boolean equals(Object o) {
            if (this == o) return true;
            if (o == null || getClass() != o.getClass()) return false;
            CarritoId carritoId = (CarritoId) o;
            return idUsuario.equals(carritoId.idUsuario) && idProducto.equals(carritoId.idProducto);
        }

        @Override
        public int hashCode() {
            return Objects.hash(idUsuario, idProducto);
        }
    }
}