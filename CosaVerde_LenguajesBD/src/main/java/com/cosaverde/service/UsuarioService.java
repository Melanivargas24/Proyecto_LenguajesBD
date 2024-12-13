/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package com.cosaverde.service;

import com.cosaverde.domain.Estado;
import com.cosaverde.domain.Rol;
import java.util.List;
import com.cosaverde.domain.Usuario;

public interface UsuarioService {

   
    List<Usuario> getUsuarios();

    Usuario getUsuarioPorId(Long idUsuario);

    void registrarUsuario(String nombre, String apellido, String correo, String contrasena, String username, Long direccionId, Long rolId, Long idEstado);

    void actualizarUsuario(Long idUsuario, String nombre, String apellido, Long rolId);

    void eliminarUsuario(Long idUsuario);

    boolean verificarUsuarioActivo(Long idUsuario);

    String obtenerNombreCompleto(Long idUsuario);

    public boolean verificarCredenciales(String correo, String contrasena);
    
    public void save(Usuario usuario);

    public Rol getRolById(Long rolId);
    
    public Estado getEstadoById(Long idEstado);

    public Usuario obtenerUsuarioPorCorreo(String correo);
    
     public Usuario getUsuarioPorUsername(String username);
    
}
