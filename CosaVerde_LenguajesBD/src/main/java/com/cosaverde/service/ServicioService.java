package com.cosaverde.service;


import java.util.List;
import com.cosaverde.domain.Servicio;


public interface ServicioService {
    public List<Servicio> getServicios();
    public Servicio getServicioPorId(Long idServicio);
    public void crearServicio (String nombre, String descripcion, String imagen);
    public void actualizarServicio(Servicio servicio);
    public void eliminarServicio(Long idServicio);
}

