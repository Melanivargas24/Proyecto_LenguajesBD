/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.cosaverde.service.impl;


import com.cosaverde.domain.Rol;
import com.cosaverde.domain.Usuario;
import com.cosaverde.service.UsuarioDetailsService;
import jakarta.persistence.EntityManager;
import jakarta.persistence.ParameterMode;
import jakarta.persistence.PersistenceContext;
import jakarta.persistence.StoredProcedureQuery;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service("userDetailsService")
public class UsuarioDetailsServiceImpl implements UsuarioDetailsService {


    @PersistenceContext
    private EntityManager entityManager;

    @Autowired
    private HttpSession session;

    @Override
    @Transactional(readOnly = true)
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        // Llamada al procedimiento almacenado para obtener el usuario por nombre
        StoredProcedureQuery query = entityManager.createStoredProcedureQuery(
                "FIDE_PROCEDIMIENTOS_PKG.FIDE_USUARIO_TB_OBTENER_POR_NOMBRE", Usuario.class);
        query.registerStoredProcedureParameter(1, Class.class, ParameterMode.REF_CURSOR);
        query.registerStoredProcedureParameter(2, String.class, ParameterMode.IN);
        query.setParameter(2, username);

        query.execute();

        List<Usuario> result = query.getResultList();
        if (result.isEmpty()) {
            throw new UsernameNotFoundException("Usuario no encontrado: " + username);
        }

        Usuario usuario = result.get(0);

        // Configurar sesión con información del usuario
        session.removeAttribute("id");
        session.removeAttribute("usuarioNombre");
        session.setAttribute("id", usuario.getIdUsuario());
        session.setAttribute("usuarioNombre", usuario.getNombre() + " " + usuario.getApellidos());
        return null;

    }

}

