/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package com.cosaverde.dao;

import org.springframework.data.jpa.repository.JpaRepository;


import com.cosaverde.domain.Direccion;

public interface DireccionDao extends JpaRepository<Direccion,Long> {
    
}