/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package com.cosaverde.dao;
import com.cosaverde.domain.Curso;
import org.springframework.data.jpa.repository.JpaRepository;


public interface CursoDao extends JpaRepository<Curso,Long>{
    
}
