/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package com.cosaverde.dao;

import com.cosaverde.domain.Rol;
import org.springframework.data.jpa.repository.JpaRepository;

/**
 *
 * @author sfallas
 */
public interface RolDao extends JpaRepository<Rol, Long> {

}
