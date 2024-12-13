/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package com.cosaverde.dao;

import com.cosaverde.domain.Provincia;
import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

/**
 *
 * @author sfallas
 */
public interface ProvinciaDao extends JpaRepository<Provincia, Long> {

    @Query(value = "SELECT COLUMN_VALUE AS nombre FROM TABLE(FIDE_PROVINCIA_TB_LISTA_PROVINICAS_FN())", nativeQuery = true)
    List<String> findAllProvincias();

}