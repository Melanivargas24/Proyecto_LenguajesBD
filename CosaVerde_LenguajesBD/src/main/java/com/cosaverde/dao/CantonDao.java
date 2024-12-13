/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package com.cosaverde.dao;

import com.cosaverde.domain.Canton;
import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

/**
 *
 * @author sfallas
 */
public interface CantonDao extends JpaRepository<Canton, Long> {

    @Query(value = "SELECT COLUMN_VALUE AS nombre FROM TABLE(FIDE_CANTON_TB_LISTA_CANTONES_FN())", nativeQuery = true)
    List<String> findAllCantones();

}
