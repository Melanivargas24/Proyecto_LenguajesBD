/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package com.cosaverde.service;


import java.util.List;
import com.cosaverde.domain.Cita;
import java.util.Date;

public interface CitaService {
    public List<Cita> getCitas();
    public Cita getCitaPorId(Long idCita);
    public void crearCita (Date fecha, String hora, Long idEstado, Long idServicio, Long idUsuario);
    public void actualizarCita(Long idCita, Date fecha, String hora, Long idEstado, Long idServicio, Long idUsuario);
    public void eliminarCita(Long idCita);

   
}