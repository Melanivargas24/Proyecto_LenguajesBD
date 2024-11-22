/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package com.CosaVerde.com.service;

import com.CosaVerde.com.domain.Curso;
import java.util.List;

public interface CursoService {

    public List<Curso> getCurso();
    
    public Curso getCurso(Curso curso);

    public List<Curso> findByNombreOrderByNombre(String nombre);

}